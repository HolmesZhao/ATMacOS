//
//	ZWYCityCity.m
//
//	Create by yinhui gao on 5/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ZWYCityCity.h"

NSString *const kZWYCityCityA = @"A";
NSString *const kZWYCityCityB = @"B";
NSString *const kZWYCityCityC = @"C";
NSString *const kZWYCityCityD = @"D";
NSString *const kZWYCityCityE = @"E";
NSString *const kZWYCityCityF = @"F";
NSString *const kZWYCityCityG = @"G";
NSString *const kZWYCityCityH = @"H";
NSString *const kZWYCityCityJ = @"J";
NSString *const kZWYCityCityK = @"K";
NSString *const kZWYCityCityL = @"L";
NSString *const kZWYCityCityM = @"M";
NSString *const kZWYCityCityN = @"N";
NSString *const kZWYCityCityP = @"P";
NSString *const kZWYCityCityQ = @"Q";
NSString *const kZWYCityCityR = @"R";
NSString *const kZWYCityCityS = @"S";
NSString *const kZWYCityCityT = @"T";
NSString *const kZWYCityCityW = @"W";
NSString *const kZWYCityCityX = @"X";
NSString *const kZWYCityCityY = @"Y";
NSString *const kZWYCityCityZ = @"Z";

@interface ZWYCityCity ()
@end
@implementation ZWYCityCity




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kZWYCityCityA] != nil && [dictionary[kZWYCityCityA] isKindOfClass:[NSArray class]]){
		NSArray * aDictionaries = dictionary[kZWYCityCityA];
		NSMutableArray * aItems = [NSMutableArray array];
		for(NSDictionary * aDictionary in aDictionaries){
			ZWYCityA * aItem = [[ZWYCityA alloc] initWithDictionary:aDictionary];
			[aItems addObject:aItem];
		}
		self.a = aItems;
	}
	if(dictionary[kZWYCityCityB] != nil && [dictionary[kZWYCityCityB] isKindOfClass:[NSArray class]]){
		NSArray * bDictionaries = dictionary[kZWYCityCityB];
		NSMutableArray * bItems = [NSMutableArray array];
		for(NSDictionary * bDictionary in bDictionaries){
			ZWYCityA * bItem = [[ZWYCityA alloc] initWithDictionary:bDictionary];
			[bItems addObject:bItem];
		}
		self.b = bItems;
	}
	if(dictionary[kZWYCityCityC] != nil && [dictionary[kZWYCityCityC] isKindOfClass:[NSArray class]]){
		NSArray * cDictionaries = dictionary[kZWYCityCityC];
		NSMutableArray * cItems = [NSMutableArray array];
		for(NSDictionary * cDictionary in cDictionaries){
			ZWYCityA * cItem = [[ZWYCityA alloc] initWithDictionary:cDictionary];
			[cItems addObject:cItem];
		}
		self.c = cItems;
	}
	if(dictionary[kZWYCityCityD] != nil && [dictionary[kZWYCityCityD] isKindOfClass:[NSArray class]]){
		NSArray * dDictionaries = dictionary[kZWYCityCityD];
		NSMutableArray * dItems = [NSMutableArray array];
		for(NSDictionary * dDictionary in dDictionaries){
			ZWYCityA * dItem = [[ZWYCityA alloc] initWithDictionary:dDictionary];
			[dItems addObject:dItem];
		}
		self.d = dItems;
	}
	if(dictionary[kZWYCityCityE] != nil && [dictionary[kZWYCityCityE] isKindOfClass:[NSArray class]]){
		NSArray * eDictionaries = dictionary[kZWYCityCityE];
		NSMutableArray * eItems = [NSMutableArray array];
		for(NSDictionary * eDictionary in eDictionaries){
			ZWYCityA * eItem = [[ZWYCityA alloc] initWithDictionary:eDictionary];
			[eItems addObject:eItem];
		}
		self.e = eItems;
	}
	if(dictionary[kZWYCityCityF] != nil && [dictionary[kZWYCityCityF] isKindOfClass:[NSArray class]]){
		NSArray * fDictionaries = dictionary[kZWYCityCityF];
		NSMutableArray * fItems = [NSMutableArray array];
		for(NSDictionary * fDictionary in fDictionaries){
			ZWYCityA * fItem = [[ZWYCityA alloc] initWithDictionary:fDictionary];
			[fItems addObject:fItem];
		}
		self.f = fItems;
	}
	if(dictionary[kZWYCityCityG] != nil && [dictionary[kZWYCityCityG] isKindOfClass:[NSArray class]]){
		NSArray * gDictionaries = dictionary[kZWYCityCityG];
		NSMutableArray * gItems = [NSMutableArray array];
		for(NSDictionary * gDictionary in gDictionaries){
			ZWYCityA * gItem = [[ZWYCityA alloc] initWithDictionary:gDictionary];
			[gItems addObject:gItem];
		}
		self.g = gItems;
	}
	if(dictionary[kZWYCityCityH] != nil && [dictionary[kZWYCityCityH] isKindOfClass:[NSArray class]]){
		NSArray * hDictionaries = dictionary[kZWYCityCityH];
		NSMutableArray * hItems = [NSMutableArray array];
		for(NSDictionary * hDictionary in hDictionaries){
			ZWYCityA * hItem = [[ZWYCityA alloc] initWithDictionary:hDictionary];
			[hItems addObject:hItem];
		}
		self.h = hItems;
	}
	if(dictionary[kZWYCityCityJ] != nil && [dictionary[kZWYCityCityJ] isKindOfClass:[NSArray class]]){
		NSArray * jDictionaries = dictionary[kZWYCityCityJ];
		NSMutableArray * jItems = [NSMutableArray array];
		for(NSDictionary * jDictionary in jDictionaries){
			ZWYCityA * jItem = [[ZWYCityA alloc] initWithDictionary:jDictionary];
			[jItems addObject:jItem];
		}
		self.j = jItems;
	}
	if(dictionary[kZWYCityCityK] != nil && [dictionary[kZWYCityCityK] isKindOfClass:[NSArray class]]){
		NSArray * kDictionaries = dictionary[kZWYCityCityK];
		NSMutableArray * kItems = [NSMutableArray array];
		for(NSDictionary * kDictionary in kDictionaries){
			ZWYCityA * kItem = [[ZWYCityA alloc] initWithDictionary:kDictionary];
			[kItems addObject:kItem];
		}
		self.k = kItems;
	}
	if(dictionary[kZWYCityCityL] != nil && [dictionary[kZWYCityCityL] isKindOfClass:[NSArray class]]){
		NSArray * lDictionaries = dictionary[kZWYCityCityL];
		NSMutableArray * lItems = [NSMutableArray array];
		for(NSDictionary * lDictionary in lDictionaries){
			ZWYCityA * lItem = [[ZWYCityA alloc] initWithDictionary:lDictionary];
			[lItems addObject:lItem];
		}
		self.l = lItems;
	}
	if(dictionary[kZWYCityCityM] != nil && [dictionary[kZWYCityCityM] isKindOfClass:[NSArray class]]){
		NSArray * mDictionaries = dictionary[kZWYCityCityM];
		NSMutableArray * mItems = [NSMutableArray array];
		for(NSDictionary * mDictionary in mDictionaries){
			ZWYCityA * mItem = [[ZWYCityA alloc] initWithDictionary:mDictionary];
			[mItems addObject:mItem];
		}
		self.m = mItems;
	}
	if(dictionary[kZWYCityCityN] != nil && [dictionary[kZWYCityCityN] isKindOfClass:[NSArray class]]){
		NSArray * nDictionaries = dictionary[kZWYCityCityN];
		NSMutableArray * nItems = [NSMutableArray array];
		for(NSDictionary * nDictionary in nDictionaries){
			ZWYCityA * nItem = [[ZWYCityA alloc] initWithDictionary:nDictionary];
			[nItems addObject:nItem];
		}
		self.n = nItems;
	}
	if(dictionary[kZWYCityCityP] != nil && [dictionary[kZWYCityCityP] isKindOfClass:[NSArray class]]){
		NSArray * pDictionaries = dictionary[kZWYCityCityP];
		NSMutableArray * pItems = [NSMutableArray array];
		for(NSDictionary * pDictionary in pDictionaries){
			ZWYCityA * pItem = [[ZWYCityA alloc] initWithDictionary:pDictionary];
			[pItems addObject:pItem];
		}
		self.p = pItems;
	}
	if(dictionary[kZWYCityCityQ] != nil && [dictionary[kZWYCityCityQ] isKindOfClass:[NSArray class]]){
		NSArray * qDictionaries = dictionary[kZWYCityCityQ];
		NSMutableArray * qItems = [NSMutableArray array];
		for(NSDictionary * qDictionary in qDictionaries){
			ZWYCityA * qItem = [[ZWYCityA alloc] initWithDictionary:qDictionary];
			[qItems addObject:qItem];
		}
		self.q = qItems;
	}
	if(dictionary[kZWYCityCityR] != nil && [dictionary[kZWYCityCityR] isKindOfClass:[NSArray class]]){
		NSArray * rDictionaries = dictionary[kZWYCityCityR];
		NSMutableArray * rItems = [NSMutableArray array];
		for(NSDictionary * rDictionary in rDictionaries){
			ZWYCityA * rItem = [[ZWYCityA alloc] initWithDictionary:rDictionary];
			[rItems addObject:rItem];
		}
		self.r = rItems;
	}
	if(dictionary[kZWYCityCityS] != nil && [dictionary[kZWYCityCityS] isKindOfClass:[NSArray class]]){
		NSArray * sDictionaries = dictionary[kZWYCityCityS];
		NSMutableArray * sItems = [NSMutableArray array];
		for(NSDictionary * sDictionary in sDictionaries){
			ZWYCityA * sItem = [[ZWYCityA alloc] initWithDictionary:sDictionary];
			[sItems addObject:sItem];
		}
		self.s = sItems;
	}
	if(dictionary[kZWYCityCityT] != nil && [dictionary[kZWYCityCityT] isKindOfClass:[NSArray class]]){
		NSArray * tDictionaries = dictionary[kZWYCityCityT];
		NSMutableArray * tItems = [NSMutableArray array];
		for(NSDictionary * tDictionary in tDictionaries){
			ZWYCityA * tItem = [[ZWYCityA alloc] initWithDictionary:tDictionary];
			[tItems addObject:tItem];
		}
		self.t = tItems;
	}
	if(dictionary[kZWYCityCityW] != nil && [dictionary[kZWYCityCityW] isKindOfClass:[NSArray class]]){
		NSArray * wDictionaries = dictionary[kZWYCityCityW];
		NSMutableArray * wItems = [NSMutableArray array];
		for(NSDictionary * wDictionary in wDictionaries){
			ZWYCityA * wItem = [[ZWYCityA alloc] initWithDictionary:wDictionary];
			[wItems addObject:wItem];
		}
		self.w = wItems;
	}
	if(dictionary[kZWYCityCityX] != nil && [dictionary[kZWYCityCityX] isKindOfClass:[NSArray class]]){
		NSArray * xDictionaries = dictionary[kZWYCityCityX];
		NSMutableArray * xItems = [NSMutableArray array];
		for(NSDictionary * xDictionary in xDictionaries){
			ZWYCityA * xItem = [[ZWYCityA alloc] initWithDictionary:xDictionary];
			[xItems addObject:xItem];
		}
		self.x = xItems;
	}
	if(dictionary[kZWYCityCityY] != nil && [dictionary[kZWYCityCityY] isKindOfClass:[NSArray class]]){
		NSArray * yDictionaries = dictionary[kZWYCityCityY];
		NSMutableArray * yItems = [NSMutableArray array];
		for(NSDictionary * yDictionary in yDictionaries){
			ZWYCityA * yItem = [[ZWYCityA alloc] initWithDictionary:yDictionary];
			[yItems addObject:yItem];
		}
		self.y = yItems;
	}
	if(dictionary[kZWYCityCityZ] != nil && [dictionary[kZWYCityCityZ] isKindOfClass:[NSArray class]]){
		NSArray * zDictionaries = dictionary[kZWYCityCityZ];
		NSMutableArray * zItems = [NSMutableArray array];
		for(NSDictionary * zDictionary in zDictionaries){
			ZWYCityA * zItem = [[ZWYCityA alloc] initWithDictionary:zDictionary];
			[zItems addObject:zItem];
		}
		self.z = zItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.a != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * aElement in self.a){
			[dictionaryElements addObject:[aElement toDictionary]];
		}
		dictionary[kZWYCityCityA] = dictionaryElements;
	}
	if(self.b != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * bElement in self.b){
			[dictionaryElements addObject:[bElement toDictionary]];
		}
		dictionary[kZWYCityCityB] = dictionaryElements;
	}
	if(self.c != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * cElement in self.c){
			[dictionaryElements addObject:[cElement toDictionary]];
		}
		dictionary[kZWYCityCityC] = dictionaryElements;
	}
	if(self.d != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * dElement in self.d){
			[dictionaryElements addObject:[dElement toDictionary]];
		}
		dictionary[kZWYCityCityD] = dictionaryElements;
	}
	if(self.e != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * eElement in self.e){
			[dictionaryElements addObject:[eElement toDictionary]];
		}
		dictionary[kZWYCityCityE] = dictionaryElements;
	}
	if(self.f != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * fElement in self.f){
			[dictionaryElements addObject:[fElement toDictionary]];
		}
		dictionary[kZWYCityCityF] = dictionaryElements;
	}
	if(self.g != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * gElement in self.g){
			[dictionaryElements addObject:[gElement toDictionary]];
		}
		dictionary[kZWYCityCityG] = dictionaryElements;
	}
	if(self.h != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * hElement in self.h){
			[dictionaryElements addObject:[hElement toDictionary]];
		}
		dictionary[kZWYCityCityH] = dictionaryElements;
	}
	if(self.j != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * jElement in self.j){
			[dictionaryElements addObject:[jElement toDictionary]];
		}
		dictionary[kZWYCityCityJ] = dictionaryElements;
	}
	if(self.k != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * kElement in self.k){
			[dictionaryElements addObject:[kElement toDictionary]];
		}
		dictionary[kZWYCityCityK] = dictionaryElements;
	}
	if(self.l != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * lElement in self.l){
			[dictionaryElements addObject:[lElement toDictionary]];
		}
		dictionary[kZWYCityCityL] = dictionaryElements;
	}
	if(self.m != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * mElement in self.m){
			[dictionaryElements addObject:[mElement toDictionary]];
		}
		dictionary[kZWYCityCityM] = dictionaryElements;
	}
	if(self.n != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * nElement in self.n){
			[dictionaryElements addObject:[nElement toDictionary]];
		}
		dictionary[kZWYCityCityN] = dictionaryElements;
	}
	if(self.p != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * pElement in self.p){
			[dictionaryElements addObject:[pElement toDictionary]];
		}
		dictionary[kZWYCityCityP] = dictionaryElements;
	}
	if(self.q != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * qElement in self.q){
			[dictionaryElements addObject:[qElement toDictionary]];
		}
		dictionary[kZWYCityCityQ] = dictionaryElements;
	}
	if(self.r != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * rElement in self.r){
			[dictionaryElements addObject:[rElement toDictionary]];
		}
		dictionary[kZWYCityCityR] = dictionaryElements;
	}
	if(self.s != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * sElement in self.s){
			[dictionaryElements addObject:[sElement toDictionary]];
		}
		dictionary[kZWYCityCityS] = dictionaryElements;
	}
	if(self.t != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * tElement in self.t){
			[dictionaryElements addObject:[tElement toDictionary]];
		}
		dictionary[kZWYCityCityT] = dictionaryElements;
	}
	if(self.w != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * wElement in self.w){
			[dictionaryElements addObject:[wElement toDictionary]];
		}
		dictionary[kZWYCityCityW] = dictionaryElements;
	}
	if(self.x != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * xElement in self.x){
			[dictionaryElements addObject:[xElement toDictionary]];
		}
		dictionary[kZWYCityCityX] = dictionaryElements;
	}
	if(self.y != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * yElement in self.y){
			[dictionaryElements addObject:[yElement toDictionary]];
		}
		dictionary[kZWYCityCityY] = dictionaryElements;
	}
	if(self.z != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ZWYCityA * zElement in self.z){
			[dictionaryElements addObject:[zElement toDictionary]];
		}
		dictionary[kZWYCityCityZ] = dictionaryElements;
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
	if(self.a != nil){
		[aCoder encodeObject:self.a forKey:kZWYCityCityA];
	}
	if(self.b != nil){
		[aCoder encodeObject:self.b forKey:kZWYCityCityB];
	}
	if(self.c != nil){
		[aCoder encodeObject:self.c forKey:kZWYCityCityC];
	}
	if(self.d != nil){
		[aCoder encodeObject:self.d forKey:kZWYCityCityD];
	}
	if(self.e != nil){
		[aCoder encodeObject:self.e forKey:kZWYCityCityE];
	}
	if(self.f != nil){
		[aCoder encodeObject:self.f forKey:kZWYCityCityF];
	}
	if(self.g != nil){
		[aCoder encodeObject:self.g forKey:kZWYCityCityG];
	}
	if(self.h != nil){
		[aCoder encodeObject:self.h forKey:kZWYCityCityH];
	}
	if(self.j != nil){
		[aCoder encodeObject:self.j forKey:kZWYCityCityJ];
	}
	if(self.k != nil){
		[aCoder encodeObject:self.k forKey:kZWYCityCityK];
	}
	if(self.l != nil){
		[aCoder encodeObject:self.l forKey:kZWYCityCityL];
	}
	if(self.m != nil){
		[aCoder encodeObject:self.m forKey:kZWYCityCityM];
	}
	if(self.n != nil){
		[aCoder encodeObject:self.n forKey:kZWYCityCityN];
	}
	if(self.p != nil){
		[aCoder encodeObject:self.p forKey:kZWYCityCityP];
	}
	if(self.q != nil){
		[aCoder encodeObject:self.q forKey:kZWYCityCityQ];
	}
	if(self.r != nil){
		[aCoder encodeObject:self.r forKey:kZWYCityCityR];
	}
	if(self.s != nil){
		[aCoder encodeObject:self.s forKey:kZWYCityCityS];
	}
	if(self.t != nil){
		[aCoder encodeObject:self.t forKey:kZWYCityCityT];
	}
	if(self.w != nil){
		[aCoder encodeObject:self.w forKey:kZWYCityCityW];
	}
	if(self.x != nil){
		[aCoder encodeObject:self.x forKey:kZWYCityCityX];
	}
	if(self.y != nil){
		[aCoder encodeObject:self.y forKey:kZWYCityCityY];
	}
	if(self.z != nil){
		[aCoder encodeObject:self.z forKey:kZWYCityCityZ];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.a = [aDecoder decodeObjectForKey:kZWYCityCityA];
	self.b = [aDecoder decodeObjectForKey:kZWYCityCityB];
	self.c = [aDecoder decodeObjectForKey:kZWYCityCityC];
	self.d = [aDecoder decodeObjectForKey:kZWYCityCityD];
	self.e = [aDecoder decodeObjectForKey:kZWYCityCityE];
	self.f = [aDecoder decodeObjectForKey:kZWYCityCityF];
	self.g = [aDecoder decodeObjectForKey:kZWYCityCityG];
	self.h = [aDecoder decodeObjectForKey:kZWYCityCityH];
	self.j = [aDecoder decodeObjectForKey:kZWYCityCityJ];
	self.k = [aDecoder decodeObjectForKey:kZWYCityCityK];
	self.l = [aDecoder decodeObjectForKey:kZWYCityCityL];
	self.m = [aDecoder decodeObjectForKey:kZWYCityCityM];
	self.n = [aDecoder decodeObjectForKey:kZWYCityCityN];
	self.p = [aDecoder decodeObjectForKey:kZWYCityCityP];
	self.q = [aDecoder decodeObjectForKey:kZWYCityCityQ];
	self.r = [aDecoder decodeObjectForKey:kZWYCityCityR];
	self.s = [aDecoder decodeObjectForKey:kZWYCityCityS];
	self.t = [aDecoder decodeObjectForKey:kZWYCityCityT];
	self.w = [aDecoder decodeObjectForKey:kZWYCityCityW];
	self.x = [aDecoder decodeObjectForKey:kZWYCityCityX];
	self.y = [aDecoder decodeObjectForKey:kZWYCityCityY];
	self.z = [aDecoder decodeObjectForKey:kZWYCityCityZ];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	ZWYCityCity *copy = [ZWYCityCity new];

	copy.a = [self.a copy];
	copy.b = [self.b copy];
	copy.c = [self.c copy];
	copy.d = [self.d copy];
	copy.e = [self.e copy];
	copy.f = [self.f copy];
	copy.g = [self.g copy];
	copy.h = [self.h copy];
	copy.j = [self.j copy];
	copy.k = [self.k copy];
	copy.l = [self.l copy];
	copy.m = [self.m copy];
	copy.n = [self.n copy];
	copy.p = [self.p copy];
	copy.q = [self.q copy];
	copy.r = [self.r copy];
	copy.s = [self.s copy];
	copy.t = [self.t copy];
	copy.w = [self.w copy];
	copy.x = [self.x copy];
	copy.y = [self.y copy];
	copy.z = [self.z copy];

	return copy;
}
@end