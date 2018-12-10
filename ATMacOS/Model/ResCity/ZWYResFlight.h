//
//	ZWYResFlight.h
//
//	Create by yinhui gao on 5/11/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <AppKit/AppKit.h>

@interface ZWYResFlight : NSObject <NSCopying, NSCoding>

@property (nonatomic, strong) NSString * airlineNameS;
@property (nonatomic, strong) NSString * airlineNameE;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
