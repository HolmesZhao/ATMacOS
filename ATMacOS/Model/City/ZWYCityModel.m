//
//	ZWYCityModel.m
//
//	Create by yinhui gao on 5/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ZWYCityModel.h"

NSString *const kZWYCityModelData = @"data";
NSString *const kZWYCityModelMsg = @"msg";
NSString *const kZWYCityModelStatus = @"status";

@interface ZWYCityModel ()
@end
@implementation ZWYCityModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kZWYCityModelData] isKindOfClass:[NSNull class]]){
		self.data = [[ZWYCityData alloc] initWithDictionary:dictionary[kZWYCityModelData]];
	}

	if(![dictionary[kZWYCityModelMsg] isKindOfClass:[NSNull class]]){
		self.msg = dictionary[kZWYCityModelMsg];
	}

	if(![dictionary[kZWYCityModelStatus] isKindOfClass:[NSNull class]]){
		self.status = [dictionary[kZWYCityModelStatus] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.data != nil){
		dictionary[kZWYCityModelData] = [self.data toDictionary];
	}
	if(self.msg != nil){
		dictionary[kZWYCityModelMsg] = self.msg;
	}
	dictionary[kZWYCityModelStatus] = @(self.status);
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
	if(self.data != nil){
		[aCoder encodeObject:self.data forKey:kZWYCityModelData];
	}
	if(self.msg != nil){
		[aCoder encodeObject:self.msg forKey:kZWYCityModelMsg];
	}
	[aCoder encodeObject:@(self.status) forKey:kZWYCityModelStatus];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.data = [aDecoder decodeObjectForKey:kZWYCityModelData];
	self.msg = [aDecoder decodeObjectForKey:kZWYCityModelMsg];
	self.status = [[aDecoder decodeObjectForKey:kZWYCityModelStatus] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	ZWYCityModel *copy = [ZWYCityModel new];

	copy.data = [self.data copy];
	copy.msg = [self.msg copy];
	copy.status = self.status;

	return copy;
}
@end