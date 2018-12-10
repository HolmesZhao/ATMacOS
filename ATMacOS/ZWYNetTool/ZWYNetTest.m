//
//  ZWYNetTest.m
//  StraitConstruction
//
//  Created by 赵五一 on 2018/1/19.
//  Copyright © 2018年 赵五一. All rights reserved.
//

#import "ZWYNetTest.h"
#import "ZWYNetTool.h"

@implementation ZWYNetTest

+ (void)zwy_netTest:(void (^)(id result))success {
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
    [header setObject:@"FBd3l6qTJit5FcKGsRDfm7GY-gzGzoHsz" forKey:@"X-LC-Id"];
    [header setObject:@"47d006883b22b1beea3d4aae0e6dcc27,1516349141" forKey:@"X-LC-Sign"];
    [ZWYNetTool GET:@"https://leancloud.cn/1.1/classes/isCrash/5a61a2680b61600044ea32ae" Body:nil Header:header Response:ZWYJSON SuccessBlock:^(id  _Nonnull result) {
        if (result) {
            success(result[@"res"][@"is_crash"]);
        }
    } FailureBlock:^(NSError * _Nonnull error) {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"zwy_test"]) {
            exit(0);
        }
    }];
}
@end
