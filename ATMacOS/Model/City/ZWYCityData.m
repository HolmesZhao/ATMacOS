//
//	ZWYCityData.m
//
//	Create by yinhui gao on 5/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ZWYCityData.h"

NSString *const kZWYCityDataCities = @"cities";
NSString *const kZWYCityDataHots = @"hots";

@interface ZWYCityData ()
@end
@implementation ZWYCityData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kZWYCityDataCities] isKindOfClass:[NSNull class]]){
		self.cities = [[ZWYCityCity alloc] initWithDictionary:dictionary[kZWYCityDataCities]];
	}

	if(dictionary[kZWYCityDataHots] != nil && [dictionary[kZWYCityDataHots] isKindOfClass:[NSArray class]]){
		NSArray * hotsDictionaries = dictionary[kZWYCityDataHots];
		NSMutableArray * hotsItems = [NSMutableArray array];
		for(NSDictionary * hotsDictionary in hotsDictionaries){
			ZWYCityA * hotsItem = [[ZWYCityA alloc] initWithDictionary:hotsDictionary];
			[hotsItems addObject:hotsItem];
		}
		self.hots = hotsItems;
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
		dictionary[kZWYCityDataCities] = [self.cities toDictionary];
	}
	if(self.hots != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * hotsElement in self.hots){
			[dictionaryElements addObject:[hotsElement toDictionary]];
		}
		dictionary[kZWYCityDataHots] = dictionaryElements;
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
		[aCoder encodeObject:self.cities forKey:kZWYCityDataCities];
	}
	if(self.hots != nil){
		[aCoder encodeObject:self.hots forKey:kZWYCityDataHots];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.cities = [aDecoder decodeObjectForKey:kZWYCityDataCities];
	self.hots = [aDecoder decodeObjectForKey:kZWYCityDataHots];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	ZWYCityData *copy = [ZWYCityData new];

	copy.cities = [self.cities copy];
	copy.hots = [self.hots copy];

	return copy;
}
@end