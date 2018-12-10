//
//	ZWYResModel.m
//
//	Create by yinhui gao on 5/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ZWYResModel.h"

NSString *const kZWYResModelCities = @"cities";
NSString *const kZWYResModelPrice = @"price";
NSString *const kZWYResModelTime = @"time";

@interface ZWYResModel ()
@end
@implementation ZWYResModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kZWYResModelCities] != nil && [dictionary[kZWYResModelCities] isKindOfClass:[NSArray class]]){
		NSArray * citiesDictionaries = dictionary[kZWYResModelCities];
		NSMutableArray * citiesItems = [NSMutableArray array];
		for(NSDictionary * citiesDictionary in citiesDictionaries){
			ZWYResCity * citiesItem = [[ZWYResCity alloc] initWithDictionary:citiesDictionary];
			[citiesItems addObject:citiesItem];
		}
		self.cities = citiesItems;
	}
	if(![dictionary[kZWYResModelPrice] isKindOfClass:[NSNull class]]){
		self.price = dictionary[kZWYResModelPrice];
	}

	if(![dictionary[kZWYResModelTime] isKindOfClass:[NSNull class]]){
		self.time = dictionary[kZWYResModelTime];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.cities != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYResCity * citiesElement in self.cities){
			[dictionaryElements addObject:[citiesElement toDictionary]];
		}
		dictionary[kZWYResModelCities] = dictionaryElements;
	}
	if(self.price != nil){
		dictionary[kZWYResModelPrice] = self.price;
	}
	if(self.time != nil){
		dictionary[kZWYResModelTime] = self.time;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.cities != nil){
		[aCoder encodeObject:self.cities forKey:kZWYResModelCities];
	}
	if(self.price != nil){
		[aCoder encodeObject:self.price forKey:kZWYResModelPrice];
	}
	if(self.time != nil){
		[aCoder encodeObject:self.time forKey:kZWYResModelTime];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.cities = [aDecoder decodeObjectForKey:kZWYResModelCities];
	self.price = [aDecoder decodeObjectForKey:kZWYResModelPrice];
	self.time = [aDecoder decodeObjectForKey:kZWYResModelTime];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	ZWYResModel *copy = [ZWYResModel new];

	copy.cities = [self.cities copy];
	copy.price = [self.price copy];
	copy.time = [self.time copy];

	return copy;
}

+ (ZWYResModel *)resModel {
    NSString *filePath = [ZWYResModel _saveToLocal:@"ZWYResModel"];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

+ (NSString *)_saveToLocal {
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *newFilePath = [filePath stringByAppendingPathComponent:@"ZWYResModelCache"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:newFilePath]) {
        NSError *error = nil;
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:newFilePath withIntermediateDirectories:YES attributes:nil error:&error];
        if (!success) {
            NSLog(@"%s==创建失败==%@", __func__, error);
        }
    }
    return newFilePath;
}

+ (NSString *)_saveToLocal:(NSString *)identify {
    NSString *newFilePath = [[self _saveToLocal] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", identify]];
    return newFilePath;
}

- (BOOL)save {
    NSString *filePath = [ZWYResModel _saveToLocal:@"ZWYResModel"];
    BOOL success = [NSKeyedArchiver archiveRootObject:self toFile:filePath];
    if (!success) {
        NSLog(@"%s==没有保存失败", __func__);
        return NO;
    } else return YES;
}

+ (BOOL)remove {
    NSString *filePath = [ZWYResModel _saveToLocal:@"ZWYResModel"];
    BOOL isRemove = [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
    if (isRemove) {
        return YES;
    } else {
        return NO;
    }
}

@end
