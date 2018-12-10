//
//	ZWYCityModel.h
//
//	Create by yinhui gao on 5/11/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <AppKit/AppKit.h>
#import "ZWYCityData.h"

@interface ZWYCityModel : NSObject

@property (nonatomic, strong) ZWYCityData * data;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, assign) NSInteger status;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end