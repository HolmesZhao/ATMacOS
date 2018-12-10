//
//	ZWYResModel.h
//
//	Create by yinhui gao on 5/11/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <AppKit/AppKit.h>
#import "ZWYResCity.h"

@interface ZWYResModel : NSObject<NSCopying, NSCoding>

@property (nonatomic, strong) NSArray * cities;
@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * time;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (ZWYResModel *)resModel;

-(NSDictionary *)toDictionary;
- (BOOL)save;
+ (BOOL)remove;
@end
