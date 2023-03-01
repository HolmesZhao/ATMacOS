import Foundation
import Promise

/// 进度文件全部操作(需要服务端合并, 产生新的记录), 文件不再上传 cos 直接 body 参数给服务器
func progressFileMergeHandle() -> Promise<Void> {
    guard self.tcpExceptionState == .None else {
        return .value
    }
    // 重新学习不需要上传进度
    guard syncScene != .reset else {
        return .value
    }
    return .value
        .done {
            self.monitorLogs?.setCardItem(.fail, forKey: .ProgressFromDevice)
        }
        .then {
            self.getProgressFiles()
        }
        .done {
            self.monitorLogs?.setCardItem(.success, forKey: .ProgressFromDevice)
            self.monitorLogs?.setCardItem(.fail, forKey: .ProgressNoticeServer)
        }
        .then { _ -> Promise<[ProgressFileSeverModel]> in
            self.base64OrCloudHandle()
        }
        .filterValues {
            $0.base64.isEmpty == false || $0.url.isEmpty == false
        }
        .then { models -> Guarantee<([ProgressFileSeverModel], Bool)> in
            return self.checkForUseAllSyncProgressFile().map { (models, $0) }
        }
        .then { value -> Promise<Void> in
            guard value.0.isEmpty == false else {
                return .value
            }
            if value.1 {
                return self.noticeServerProgressUpload(model: value.0.first)
            } else {
                return self.noticeServerProgressUpload(models: value.0)
            }
        }
        .done {
            self.monitorLogs?.setCardItem(.success, forKey: .ProgressNoticeServer)
        }
}

/// 检查是否使用打包进度文件上传
func checkForUseAllSyncProgressFile() -> Guarantee<Bool> {
    .value(allSyncProgressFile?.isSupported == true)
}

/// 检查是否使用云存储
func checkUploadWithCloud() -> Promise<Bool> {
    self.checkForUseAllSyncProgressFile()
        .then { value -> Promise<Bool> in
            var dataCount = 0
            if value {
                let data = self.allSyncProgressFile?.data ?? Data()
                dataCount = data.count
                MMLog.log("批量进度文件大小\(dataCount)", prefix: .studyCard)
            } else {
                dataCount = self
                    .processModels
                    .map { $0.file?.data?.count ?? 0 }
                    .reduce(0) { $0 + $1 }
                MMLog.log("单本进度文件循环总大小\(dataCount)", prefix: .studyCard)
            }
            return .value(dataCount > 2 * 1024 * 1024)
        }
}

/// 从硬件获取所有进度文件
func getProgressFiles() -> Promise<Void> {
    self.getProgressFilesNew()
        .recover { [weak self] error -> Promise<Void> in
            guard let `self` = self else {
                throw error
            }
            
            let cardError = error as? StudyCardManager.StudyCardError
            switch cardError {
            case .getRecordCommonNoSupport:
                MMLog.log("硬件获取进度文件不支持批量指令", prefix: .studyCard)
                return .loopProcess(dataSource: self.processModels, handler: self.getProgressFile(processModel:))
            default:
                throw error
            }
        }
}

/// 使用获取所有进度文件指令获取文件, 返回值为是否支持该指令, 不支持该指令则继续原有逻辑
func getProgressFilesNew() -> Promise<Void> {
    Promise { [weak self] seal in
        self?.seal = seal
        guard let using = self?.usingDevice else {
            seal.reject(studyCard: .noUsingDevice)
            return
        }
        guard let processModels = self?.processModels,
                processModels.count > 1
        else {
            // 只有一本书在处理的时候, 说明只有一本书, 或者正在下载一本书, 此时不需要批量上传进度
            MMLog.log("只有一本书不需要走批量", prefix: .studyCard)
            seal.reject(studyCard: .getRecordCommonNoSupport)
            return
        }
//            seal.reject(studyCard: .getRecordCommonNoSupport)
//            return;
        // 单词卡可能出现把 ping 回包插入 tar 中, 所以暂时停止 ping
        self?.stopPingBlue()
        // 保证清空上一次的缓存, 二次上传进度的时候, 如果不为 nil, 设备拿不到进度会因为缓存继续上传进度
        self?.allSyncProgressFile = nil
        MMLog.log("从学习卡批量获取进度文件", prefix: .studyCard)
        MMDeviceApi.getAllSyncRecords(using) { result in
            self?.startPingBlue()
            MMLog.log(
                "批量获取学习卡进度文件结果\(result.isSuccess), 是否支持批量\(result.isSupported)",
                prefix: .studyCard
            )
            self?.allSyncProgressFile = result
            if result.isSupported {
                seal.fulfill()
            } else {
                seal.reject(studyCard: .getRecordCommonNoSupport)
            }
        }
    }
}

/// 从硬件获取进度文件
func getProgressFile(processModel: ProcessModel) -> Promise<Void> {
    Promise { [weak self] seal in
        self?.seal = seal
        guard let using = self?.usingDevice else {
            seal.reject(studyCard: .noUsingDevice)
            return
        }
        let book = processModel.book
        // 单词卡可能出现把 ping 回包插入 tar 中, 所以暂时停止 ping
        self?.stopPingBlue()
        // 保证清空上一次的缓存, 二次上传进度的时候, 如果不为 nil, 设备拿不到进度会因为缓存继续上传进度
        processModel.file = nil
        MMLog.log("从学习卡获取进度文件 \(book.bookId)", prefix: .studyCard)
        MMDeviceApi.getSyncRecord(
            using,
            bookType: book.bookType,
            bookId: book.bookId
        ) { records, success in
            defer {
                self?.startPingBlue()
                seal.fulfill()
                MMLog.log("获取学习卡进度文件结果\(success)", prefix: .studyCard)
            }
            guard success else {
                return
            }
            var file = UploadFile()
            file.isSuccess = true
            file.data = records.oriData
            processModel.file = file
        }
    }
}

/// 进度文件使用 base64 或者云文件处理
func base64OrCloudHandle() -> Promise<[ProgressFileSeverModel]> {
    self.checkUploadWithCloud()
        .then { value -> Promise<[ProgressFileSeverModel]> in
            if value {
                return self.uploadProgressFileHandle()
            } else {
                return self.uploadProgressFileBase64Handle()
            }
        }
}

/// 进度文件处理成 base64
func uploadProgressFileBase64Handle() -> Promise<[ProgressFileSeverModel]> {
    self.checkForUseAllSyncProgressFile()
        .then { value -> Promise<[ProgressFileSeverModel]> in
            if value {
                return self.uploadAllSyncProgressFileBase64().map { [$0] }
            } else {
                return Promise<[ProgressFileSeverModel]>.loopProcess(
                    dataSource: self.processModels,
                    handler: self.uploadProgressFileBase64(processModel:)
                )
            }
        }
}

/// 单本进度文件处理成 base64
func uploadProgressFileBase64(processModel: ProcessModel) -> Promise<ProgressFileSeverModel> {
    Promise { seal in
        guard let using = usingDevice else {
            seal.reject(studyCard: .noUsingDevice)
            return
        }
        guard let data = processModel.file?.data else {
            seal.fulfill(.init())
            return
        }
        let book = processModel.book
        var result = ProgressFileSeverModel()
        result.md5 = data.md5String
        result.base64 = data.base64EncodedString()
        result.bookId = book.bookId
        result.bookType = book.bookType
        result.deviceType = using.deviceType ?? ""
        result.deviceSN = using.snCode ?? ""
        MMLog.log("进度文件 Base64 成功", book, prefix: .studyCard)
        seal.fulfill(result)
    }
}

/// 批量进度文件转 base64
func uploadAllSyncProgressFileBase64() -> Promise<ProgressFileSeverModel> {
    Promise { seal in
        guard let using = usingDevice else {
            seal.reject(studyCard: .noUsingDevice)
            return
        }
        guard let data = allSyncProgressFile?.data else {
            seal.fulfill(.init())
            return
        }
        var result = ProgressFileSeverModel()
        result.md5 = data.md5String
        result.base64 = data.base64EncodedString()
        result.deviceType = using.deviceType ?? ""
        result.deviceSN = using.snCode ?? ""
        MMLog.log("进度文件 Base64 成功", prefix: .studyCard)
        seal.fulfill(result)
    }
}

/// 上传进度文件到 cos
func uploadProgressFileHandle() -> Promise<[ProgressFileSeverModel]> {
    self.checkForUseAllSyncProgressFile()
        .then { value -> Promise<[ProgressFileSeverModel]> in
            if value {
                return self.uploadAllSyncProgressFile().map { [$0] }
            } else {
                return Promise<[ProgressFileSeverModel]>.loopProcess(
                    dataSource: self.processModels,
                    handler: self.uploadProgressFile(processModel:)
                )
            }
        }
}

/// 单本上传进度文件到 cos
func uploadProgressFile(processModel: ProcessModel) -> Promise<ProgressFileSeverModel> {
    Promise { seal in
        guard let using = usingDevice else {
            seal.reject(studyCard: .noUsingDevice)
            return
        }
        guard let data = processModel.file?.data else {
            seal.fulfill(.init())
            return
        }
        let book = processModel.book
        let userId = UserModel.sharedInstance()?.userId ?? ""
        let name = "Book_\(userId)_\(Int(Date().timeIntervalSince1970 * 1000))".md5
        MMLog.log("上传进度文件到 cos", prefix: .studyCard)
        OSManager
            .manager
            .upload(
                datas: [data],
                objectKeys: [name],
                module: .wordbook) {
                    guard let url = OSManager.manager.getCompleteURL(with: name, type: .wordbook) else {
                        seal.fulfill(.init())
                        return
                    }
                    var result = ProgressFileSeverModel()
                    result.md5 = data.md5String
                    result.url = url
                    result.bookId = book.bookId
                    result.bookType = book.bookType
                    result.deviceType = using.deviceType ?? ""
                    result.deviceSN = using.snCode ?? ""
                    MMLog.log("上传进度到云成功", prefix: .studyCard)
                    seal.fulfill(result)
                } failure: { error in
                    MMLog.log("上传进度到云失败: \(error?.localizedDescription ?? "")", prefix: .studyCard)
                    seal.fulfill(.init())
                } progress: { _ in
                    
                }
    }
}

/// 批量进度文件上传到 cos
func uploadAllSyncProgressFile() -> Promise<ProgressFileSeverModel> {
    Promise { seal in
        guard let using = usingDevice else {
            seal.reject(studyCard: .noUsingDevice)
            return
        }
        guard let data = allSyncProgressFile?.data else {
            seal.fulfill(.init())
            return
        }

        let userId = UserModel.sharedInstance()?.userId ?? ""
        let name = "Book_\(userId)_\(Int(Date().timeIntervalSince1970 * 1000))".md5
        MMLog.log("上传进度文件到 cos", prefix: .studyCard)
        OSManager
            .manager
            .upload(
                datas: [data],
                objectKeys: [name],
                module: .wordbook) {
                    guard let url = OSManager.manager.getCompleteURL(with: name, type: .wordbook) else {
                        seal.fulfill(.init())
                        return
                    }
                    var result = ProgressFileSeverModel()
                    result.md5 = data.md5String
                    result.url = url
                    result.deviceType = using.deviceType ?? ""
                    result.deviceSN = using.snCode ?? ""
                    MMLog.log("上传进度到云成功", prefix: .studyCard)
                    seal.fulfill(result)
                } failure: { error in
                    MMLog.log("上传进度到云失败: \(error?.localizedDescription ?? "")", prefix: .studyCard)
                    seal.fulfill(.init())
                } progress: { _ in
                    
                }
    }
}

/// 通知服务端进度上传
/// - Parameter models: 进度结果模型数组
func noticeServerProgressUpload(models: [ProgressFileSeverModel]) -> Promise<Void> {
    Promise { [weak self] seal in
        guard models.isEmpty == false else {
            seal.fulfill()
            return
        }
        
        guard let using = self?.usingDevice else {
            seal.reject(studyCard: .noUsingDevice)
            return
        }
        let param: [String: Any] = [
            "progressList": models.mm.toJSON(),
            "deviceSN": using.snCode ?? "",
            "deviceType": using.deviceType ?? ""
        ]
        MMLog.log("通知服务端进度上传", models.map { $0.bookId }, prefix: .studyCard)
        APIRequest.mmPost(
            withParms: param,
            request: .kUrl_studyen_studycard_batchUploadStudyProgress
        ) { rsp in
            MMLog.log("通知服务端上传进度成功", rsp.content, prefix: .studyCard)
            seal.fulfill()
            guard rsp.isSuccess() == false else {
                return
            }
            MMToast.showText(rsp.msg)
        } failureBlock: {
            MMLog.log("通知服务端上传进度失败: \($0.code) - \($0.msg)", prefix: .studyCard)
            seal.fulfill()
        }
    }
}

/// 通知服务端进度上传
/// - Parameter model: 进度结果模型
func noticeServerProgressUpload(model: ProgressFileSeverModel?) -> Promise<Void> {
    Promise { seal in
        guard let param: [String: Any] = model?.mm.toJSON() else {
            seal.fulfill()
            return
        }
        MMLog.log("通知服务端进度上传", model?.bookId ?? 0, prefix: .studyCard)
        APIRequest.mmPost(
            withParms: param,
            request: .kUrl_studyen_studycard_uploadStudyProgressFile
        ) { rsp in
            MMLog.log("通知服务端上传进度成功", rsp.content, prefix: .studyCard)
            seal.fulfill()
            guard rsp.isSuccess() == false else {
                return
            }
            MMToast.showText(rsp.msg)
        } failureBlock: {
            MMLog.log("通知服务端上传进度失败: \($0.code) - \($0.msg)", prefix: .studyCard)
            seal.fulfill()
        }
    }
}