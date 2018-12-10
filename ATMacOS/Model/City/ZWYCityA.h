//
//	ZWYCityA.h
//
//	Create by yinhui gao on 5/11/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <AppKit/AppKit.h>

@interface ZWYCityA : NSObject <NSCopying, NSCoding>

@property (nonatomic, strong) NSString * data;
@property (nonatomic, strong) NSString * display;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
