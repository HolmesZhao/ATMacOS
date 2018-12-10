//
//  ZWYNetTool.h
//  Magic-C
//
//  Created by 赵五一 on 16/7/13.
//  Copyright © 2016年 赵五一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^NetworkProgress)(id progress);
typedef void(^FormDataBlock)(id<AFMultipartFormData>  _Nonnull formData);
typedef void(^SuccessBlock)(id result);
typedef void(^FailureBlock)(NSError *error);

typedef NS_ENUM(NSUInteger, ZWYResponseStyle) {
    ZWYJSON,
    ZWYDATA,
    ZWYXML,
};

typedef NS_ENUM(NSUInteger, ZWYRequestStyle) {
    ZWYBodyString,
    ZWYBodyJSON,
    ZWYBodyOtherForm,
};

@interface ZWYNetTool : NSObject

/**
 * 设置超时时间
 */
@property (nonatomic, assign, class) NSTimeInterval timeoutInterval;

/**
 Get 请求

 @param url 请求的url
 @param body 请求的参数
 @param headers 请求头
 @param responseStyle 返回值类型
 @param progress 下载进度
 @param success 请求成功
 @param failure 请求失败
 */
+ (void)GET:(NSString *)url
       Body:(id _Nullable)body
     Header:(NSDictionary * _Nullable)headers
   Response:(ZWYResponseStyle)responseStyle
   Progress:(NetworkProgress)progress
SuccessBlock:(SuccessBlock)success
FailureBlock:(FailureBlock)failure;

+ (void)GET:(NSString *)url
       Body:(id _Nullable)body
     Header:(NSDictionary * _Nullable)headers
   Response:(ZWYResponseStyle)responseStyle
SuccessBlock:(SuccessBlock)success
FailureBlock:(FailureBlock)failure;


/**
 PUT 请求

 @param url 请求的url
 @param body 请求的参数
 @param headers 请求头
 @param responseStyle 返回值类型
 @param success 请求成功
 @param failure 请求失败
 */
+ (void)PUT:(NSString *)url
       Body:(id _Nullable)body
  BodyStyle:(ZWYRequestStyle)bodyStyle
     Header:(NSDictionary * _Nullable)headers
   Response:(ZWYResponseStyle)responseStyle
SuccessBlock:(SuccessBlock)success
FailureBlock:(FailureBlock)failure;

/**
 DELETE 请求
 
 @param url 请求的url
 @param body 请求的参数
 @param headers 请求头
 @param responseStyle 返回值类型
 @param success 请求成功
 @param failure 请求失败
 */
+ (void)DELETE:(NSString *)url
          Body:(id _Nullable)body
     BodyStyle:(ZWYRequestStyle)bodyStyle
        Header:(NSDictionary * _Nullable)headers
      Response:(ZWYResponseStyle)responseStyle
  SuccessBlock:(SuccessBlock)success
  FailureBlock:(FailureBlock)failure;


/**
 Post 请求

 @param url 请求的url
 @param body 请求的参数
 @param bodyStyle 请求的参数类型
 @param headers 请求头
 @param responseStyle 返回值类型
 @param progress 上传进度
 @param success 请求成功
 @param failure 请求失败
 */
+ (void)POST:(NSString *)url
        Body:(id)body
   BodyStyle:(ZWYRequestStyle)bodyStyle
      Header:(NSDictionary * _Nullable)headers
    Response:(ZWYResponseStyle)responseStyle
    Progress:(NetworkProgress)progress
SuccessBlock:(SuccessBlock)success
FailureBlock:(FailureBlock)failure;

+ (void)POST:(NSString *)url
        Body:(id)body
   BodyStyle:(ZWYRequestStyle)bodyStyle
      Header:(NSDictionary * _Nullable)headers
    Response:(ZWYResponseStyle)responseStyle
SuccessBlock:(SuccessBlock)success
FailureBlock:(FailureBlock)failure;

/**
  Post 上传

 @param url 服务器地址
 @param body 上传的参数内容
 @param bodyStyle  上传的类型
 @param headers 请求头
 @param responseStyle 返回值类型
 @param progress 上传进度
 @param formDataBlock 上传数据处理
 @param success 请求成功
 @param failure 请求失败    
 */
+ (void)POST:(NSString *)url
        Body:(id)body
   BodyStyle:(ZWYRequestStyle)bodyStyle
      Header:(NSDictionary * _Nullable)headers
    Response:(ZWYResponseStyle)responseStyle
    Progress:(NetworkProgress)progress
FormDataBlock:(FormDataBlock)formDataBlock
SuccessBlock:(SuccessBlock)success
FailureBlock:(FailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
