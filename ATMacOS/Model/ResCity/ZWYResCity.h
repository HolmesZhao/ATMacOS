//
//	ZWYResCity.h
//
//	Create by yinhui gao on 5/11/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <AppKit/AppKit.h>
#import "ZWYResFlight.h"

@interface ZWYResCity : NSObject <NSCopying, NSCoding>

@property (nonatomic, strong) NSString * dataE;
@property (nonatomic, strong) NSString * dataS;
@property (nonatomic, strong) NSString * date;
@property (nonatomic, strong) NSString * displayE;
@property (nonatomic, strong) NSString * displayS;
@property (nonatomic, strong) ZWYResFlight * flight;
@property (nonatomic, strong) NSString * cabins;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
