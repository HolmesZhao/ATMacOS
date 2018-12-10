//
//	ZWYCityA.m
//
//	Create by yinhui gao on 5/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ZWYCityA.h"

NSString *const kZWYCityAData = @"data";
NSString *const kZWYCityADisplay = @"display";

@interface ZWYCityA ()
@end
@implementation ZWYCityA




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kZWYCityAData] isKindOfClass:[NSNull class]]){
		self.data = dictionary[kZWYCityAData];
	}

	if(![dictionary[kZWYCityADisplay] isKindOfClass:[NSNull class]]){
		self.display = dictionary[kZWYCityADisplay];
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
		dictionary[kZWYCityAData] = self.data;
	}
	if(self.display != nil){
		dictionary[kZWYCityADisplay] = self.display;
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
	if(self.data != nil){
		[aCoder encodeObject:self.data forKey:kZWYCityAData];
	}
	if(self.display != nil){
		[aCoder encodeObject:self.display forKey:kZWYCityADisplay];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.data = [aDecoder decodeObjectForKey:kZWYCityAData];
	self.display = [aDecoder decodeObjectForKey:kZWYCityADisplay];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	ZWYCityA *copy = [ZWYCityA new];

	copy.data = [self.data copy];
	copy.display = [self.display copy];

	return copy;
}
@end