//
//	ZWYResFlight.m
//
//	Create by yinhui gao on 5/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ZWYResFlight.h"

NSString *const kZWYResFlightAirlineName = @"airlineName";
NSString *const kZWYResFlightFlightNumber = @"flightNumber";

@interface ZWYResFlight ()
@end
@implementation ZWYResFlight




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kZWYResFlightAirlineName] isKindOfClass:[NSNull class]]){
		self.airlineNameS = dictionary[kZWYResFlightAirlineName];
	}

	if(![dictionary[kZWYResFlightFlightNumber] isKindOfClass:[NSNull class]]){
		self.airlineNameE = dictionary[kZWYResFlightFlightNumber];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.airlineNameS != nil){
		dictionary[kZWYResFlightAirlineName] = self.airlineNameS;
	}
	if(self.airlineNameE != nil){
		dictionary[kZWYResFlightFlightNumber] = self.airlineNameE;
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
	if(self.airlineNameS != nil){
		[aCoder encodeObject:self.airlineNameS forKey:kZWYResFlightAirlineName];
	}
	if(self.airlineNameE != nil){
		[aCoder encodeObject:self.airlineNameE forKey:kZWYResFlightFlightNumber];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.airlineNameS = [aDecoder decodeObjectForKey:kZWYResFlightAirlineName];
	self.airlineNameE = [aDecoder decodeObjectForKey:kZWYResFlightFlightNumber];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	ZWYResFlight *copy = [ZWYResFlight new];

	copy.airlineNameS = [self.airlineNameS copy];
	copy.airlineNameE = [self.airlineNameE copy];

	return copy;
}
@end
