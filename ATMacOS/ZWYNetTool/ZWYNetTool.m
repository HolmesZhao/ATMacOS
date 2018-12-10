//
//  ZWYNetTool.m
//  Magic-C
//
//  Created by 赵五一 on 16/7/13.
//  Copyright © 2016年 赵五一. All rights reserved.
//

#import "ZWYNetTool.h"
#import <objc/message.h>

static NSTimeInterval _timeoutInterval;

@implementation ZWYNetTool

+ (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval {
    _timeoutInterval = timeoutInterval;
}

+ (NSTimeInterval)timeoutInterval {
    return _timeoutInterval;
}

+ (AFHTTPSessionManager *)zwy_netToolManagerWithHeaders:(NSDictionary *)headers response:(ZWYResponseStyle)responseStyle {
    // 1. 设置网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = self.timeoutInterval;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    // 2. 设置请求头
    if (headers) {
        for (NSString *key in headers.allKeys) {
            [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }
    // 3. 设置返回数据的类型
    switch (responseStyle) {
        case ZWYJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case ZWYXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case ZWYDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
            
        default:
            break;
    }
    // 4. 设置响应数据类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"image/jpeg", @"text/vnd.wap.wml", @"text/xml", nil]];
    return manager;
}

+ (void)GET:(NSString *)url Body:(id)body Header:(NSDictionary *)headers Response:(ZWYResponseStyle)responseStyle Progress:(NetworkProgress)progress SuccessBlock:(SuccessBlock)success FailureBlock:(FailureBlock)failure {
    AFHTTPSessionManager *manager = [self zwy_netToolManagerWithHeaders:headers response:responseStyle];
    // 5. UTF-8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    // 6. 使用AFN进行网络请求
    [manager GET:url parameters:body progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"Get requestUrl: %@ --- %@", url, downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject) {
            NSDictionary *res = @{@"url": task.currentRequest.URL.absoluteString, @"res": responseObject ? responseObject : @""};
            success(res);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error) {
            failure(error);
        }
        
    }];
}

+ (void)GET:(NSString *)url
       Body:(id)body
     Header:(NSDictionary *)headers
   Response:(ZWYResponseStyle)responseStyle
SuccessBlock:(SuccessBlock)success
FailureBlock:(FailureBlock)failure {
    [self GET:url Body:body Header:headers Response:responseStyle Progress:^(id  _Nonnull progress) {
    } SuccessBlock:^(id  _Nonnull result) {
        if (result) {
            success(result);
        }
    } FailureBlock:^(NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
}

+ (void)PUT:(NSString *)url
       Body:(id)body
  BodyStyle:(ZWYRequestStyle)bodyStyle
     Header:(NSDictionary *)headers
   Response:(ZWYResponseStyle)responseStyle
SuccessBlock:(SuccessBlock)success
FailureBlock:(FailureBlock)failure {
    AFHTTPSessionManager *manager = [self zwy_netToolManagerWithHeaders:headers response:responseStyle];
    // 2. 设置body的数据类型
    switch (bodyStyle) {
        case ZWYBodyJSON:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case ZWYBodyString:
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable * _Nullable error) {
                return parameters;
            }];
            break;
        case ZWYBodyOtherForm:
        {
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        }
            break;
            
        default:
            break;
    }
    // 5. UTF-8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    // 6. 使用AFN进行网络请求
    [manager PUT:url parameters:body success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSDictionary *res = @{@"url": task.currentRequest.URL.absoluteString, @"res": responseObject ? responseObject : @""};
            success(res);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
}

+ (void)DELETE:(NSString *)url
          Body:(id)body
     BodyStyle:(ZWYRequestStyle)bodyStyle
        Header:(NSDictionary *)headers
      Response:(ZWYResponseStyle)responseStyle
  SuccessBlock:(SuccessBlock)success
  FailureBlock:(FailureBlock)failure {
    AFHTTPSessionManager *manager = [self zwy_netToolManagerWithHeaders:headers response:responseStyle];
    
    // 2. 设置body的数据类型
    switch (bodyStyle) {
        case ZWYBodyJSON:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case ZWYBodyString:
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable * _Nullable error) {
                return parameters;
            }];
            break;
        case ZWYBodyOtherForm:
        {
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        }
            break;
            
        default:
            break;
    }
    
    // 5. UTF-8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    // 6. 使用AFN进行网络请求
    [manager DELETE:url parameters:body success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *res = @{@"url": task.currentRequest.URL.absoluteString, @"res": responseObject ? responseObject : @""};
            success(res);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)url Body:(id)body BodyStyle:(ZWYRequestStyle)bodyStyle Header:(NSDictionary *)headers Response:(ZWYResponseStyle)responseStyle Progress:(NetworkProgress)progress SuccessBlock:(SuccessBlock)success FailureBlock:(FailureBlock)failure {
    // 1. 设置网络管理者
    AFHTTPSessionManager *manager = [self zwy_netToolManagerWithHeaders:headers response:responseStyle];
    
    // 2. 设置body的数据类型
    switch (bodyStyle) {
        case ZWYBodyJSON:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case ZWYBodyString:
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable * _Nullable error) {
                return parameters;
            }];
            break;
        case ZWYBodyOtherForm:
        {
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        }
            break;

        default:
            break;
    }
    // 5. UTF-8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    // 6. 使用AFN进行网络请求
    [manager POST:url parameters:body progress:^(NSProgress * _Nonnull uploadProgress) {
        if (uploadProgress) {
            progress(uploadProgress);
        }
//        NSLog(@"Post requestUrl: %@ --- %@", url, uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *res = @{@"url": task.currentRequest.URL.absoluteString, @"res": responseObject ? responseObject : @""};
            success(res);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSLog(@"%@", error);
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)url Body:(id)body BodyStyle:(ZWYRequestStyle)bodyStyle Header:(NSDictionary *)headers Response:(ZWYResponseStyle)responseStyle SuccessBlock:(SuccessBlock)success FailureBlock:(FailureBlock)failure {
    [self POST:url Body:body BodyStyle:bodyStyle Header:headers Response:responseStyle Progress:^(id  _Nonnull progress) {
    } SuccessBlock:^(id  _Nonnull result) {
        if (success) {
            success(result);
        }
    } FailureBlock:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)url Body:(id)body BodyStyle:(ZWYRequestStyle)bodyStyle Header:(NSDictionary *)headers Response:(ZWYResponseStyle)responseStyle Progress:(NetworkProgress)progress FormDataBlock:(FormDataBlock)formDataBlock SuccessBlock:(SuccessBlock)success FailureBlock:(FailureBlock)failure {
    // 1. 设置网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2. 设置body的数据类型
    switch (bodyStyle) {
        case ZWYBodyJSON:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case ZWYBodyString:
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable * _Nullable error) {
                return parameters;
            }];
            break;
        case ZWYBodyOtherForm:
        {
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        }
            break;
        default:
            break;
    }
    // 3. 设置请求头
    if (headers) {
        for (NSString *key in headers.allKeys) {
            [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }
    // 3. 设置返回数据的类型
    switch (responseStyle) {
        case ZWYJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case ZWYXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case ZWYDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }
    // 4. 设置响应数据类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", @"application/javascript", @"image/jpeg", @"text/vnd.wap.wml", @"multipart/form-data", nil]];
    // 5. UTF-8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
//    请求参数大致如下, 应该是一个字典, {images[] : [数组]}
//    NSDictionary *param = (NSDictionary *)body;
//    NSArray *imageArr = nil;
//    NSArray *nameArr = nil;
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    if ([param.allKeys containsObject:@"images[]"]) {
//        imageArr = param[@"images[]"];
//        nameArr = param[@"imageName"];
//    } else {
//        imageArr = param[@"files[]"];
//        nameArr = param[@"imageName"];
//        [params setObject:param[@"token"] forKey:@"token"];
//        if ([param.allKeys containsObject:@"card_id"]) {
//            [params setObject:param[@"card_id"] forKey:@"card_id"];
//        } else {
//            [params setObject:param[@"uniacid"] forKey:@"uniacid"];
//        }
//    }
    
    [manager POST:url parameters:body constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//      处理上传内容
//        if ([param.allKeys containsObject:@"images[]"]) {
//            int i = 0;
//            for (NSData *data in imageArr) {
//                [formData appendPartWithFileData:data name:@"images[]" fileName:[NSString stringWithFormat:@"%@", nameArr[i]] mimeType:@"image/png"];
//                i++;
//            }
//        } else {
//            [formData appendPartWithFileData:imageArr[0] name:@"files[]" fileName:[NSString stringWithFormat:@"%@", nameArr[0]] mimeType:@"image/png"];
//        }
        if (formDataBlock) {
            formDataBlock(formData);
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
            NSLog(@"Post requestUrl: %@ --- %@", url, uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}





@end
