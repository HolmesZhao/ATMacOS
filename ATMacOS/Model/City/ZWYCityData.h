//
//	ZWYCityData.h
//
//	Create by yinhui gao on 5/11/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <AppKit/AppKit.h>
#import "ZWYCityCity.h"
#import "ZWYCityA.h"

@interface ZWYCityData : NSObject<NSCopying>

@property (nonatomic, strong) ZWYCityCity * cities;
@property (nonatomic, strong) NSArray * hots;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
