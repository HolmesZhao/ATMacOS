//
//    ZWYResCity.m
//
//    Create by yinhui gao on 5/11/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ZWYResCity.h"

NSString *const kZWYResCityCabins = @"cabins";
NSString *const kZWYResCityDataE = @"dataE";
NSString *const kZWYResCityDataS = @"dataS";
NSString *const kZWYResCityDate = @"date";
NSString *const kZWYResCityDisplayE = @"displayE";
NSString *const kZWYResCityDisplayS = @"displayS";
NSString *const kZWYResCityFlight = @"flight";

@interface ZWYResCity ()
@end
@implementation ZWYResCity




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kZWYResCityCabins] isKindOfClass:[NSNull class]]){
        self.cabins = dictionary[kZWYResCityCabins];
    }
    
    if(![dictionary[kZWYResCityDataE] isKindOfClass:[NSNull class]]){
        self.dataE = dictionary[kZWYResCityDataE];
    }
    
    if(![dictionary[kZWYResCityDataS] isKindOfClass:[NSNull class]]){
        self.dataS = dictionary[kZWYResCityDataS];
    }
    
    if(![dictionary[kZWYResCityDate] isKindOfClass:[NSNull class]]){
        self.date = dictionary[kZWYResCityDate];
    }
    
    if(![dictionary[kZWYResCityDisplayE] isKindOfClass:[NSNull class]]){
        self.displayE = dictionary[kZWYResCityDisplayE];
    }
    
    if(![dictionary[kZWYResCityDisplayS] isKindOfClass:[NSNull class]]){
        self.displayS = dictionary[kZWYResCityDisplayS];
    }
    
    if(![dictionary[kZWYResCityFlight] isKindOfClass:[NSNull class]]){
        self.flight = [[ZWYResFlight alloc] initWithDictionary:dictionary[kZWYResCityFlight]];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.cabins != nil){
        dictionary[kZWYResCityCabins] = self.cabins;
    }
    if(self.dataE != nil){
        dictionary[kZWYResCityDataE] = self.dataE;
    }
    if(self.dataS != nil){
        dictionary[kZWYResCityDataS] = self.dataS;
    }
    if(self.date != nil){
        dictionary[kZWYResCityDate] = self.date;
    }
    if(self.displayE != nil){
        dictionary[kZWYResCityDisplayE] = self.displayE;
    }
    if(self.displayS != nil){
        dictionary[kZWYResCityDisplayS] = self.displayS;
    }
    if(self.flight != nil){
        dictionary[kZWYResCityFlight] = [self.flight toDictionary];
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
    if(self.cabins != nil){
        [aCoder encodeObject:self.cabins forKey:kZWYResCityCabins];
    }
    if(self.dataE != nil){
        [aCoder encodeObject:self.dataE forKey:kZWYResCityDataE];
    }
    if(self.dataS != nil){
        [aCoder encodeObject:self.dataS forKey:kZWYResCityDataS];
    }
    if(self.date != nil){
        [aCoder encodeObject:self.date forKey:kZWYResCityDate];
    }
    if(self.displayE != nil){
        [aCoder encodeObject:self.displayE forKey:kZWYResCityDisplayE];
    }
    if(self.displayS != nil){
        [aCoder encodeObject:self.displayS forKey:kZWYResCityDisplayS];
    }
    if(self.flight != nil){
        [aCoder encodeObject:self.flight forKey:kZWYResCityFlight];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.cabins = [aDecoder decodeObjectForKey:kZWYResCityCabins];
    self.dataE = [aDecoder decodeObjectForKey:kZWYResCityDataE];
    self.dataS = [aDecoder decodeObjectForKey:kZWYResCityDataS];
    self.date = [aDecoder decodeObjectForKey:kZWYResCityDate];
    self.displayE = [aDecoder decodeObjectForKey:kZWYResCityDisplayE];
    self.displayS = [aDecoder decodeObjectForKey:kZWYResCityDisplayS];
    self.flight = [aDecoder decodeObjectForKey:kZWYResCityFlight];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    ZWYResCity *copy = [ZWYResCity new];
    
    copy.cabins = [self.cabins copy];
    copy.dataE = [self.dataE copy];
    copy.dataS = [self.dataS copy];
    copy.date = [self.date copy];
    copy.displayE = [self.displayE copy];
    copy.displayS = [self.displayS copy];
    copy.flight = [self.flight copy];
    
    return copy;
}
@end
