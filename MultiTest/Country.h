//
//  Country.h
//  MultiTest
//
//  Created by Administrator on 28.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CountryWithVehicleRule, Trip, Visa;

@interface Country : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * titleRUS;
@property (nonatomic, retain) NSNumber * isEU;
@property (nonatomic, retain) NSNumber * isShengen;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * imageBigURL;
@property (nonatomic, retain) NSNumber * maxTurVisaDays;
@property (nonatomic, retain) NSNumber * maxTurVisaDaysPeriod;
@property (nonatomic, retain) NSDate * updateDate;
@property (nonatomic, retain) NSNumber * visaPrice;
@property (nonatomic, retain) NSNumber * status; // 0-EU 1-members
@property (nonatomic, retain) NSSet *issuedVisas;
@property (nonatomic, retain) NSSet *entryTrips;
@property (nonatomic, retain) NSSet *outedTrips;
@property (nonatomic, retain) NSSet *rulesByVehicle;
@end

@interface Country (CoreDataGeneratedAccessors)

- (void)addIssuedVisasObject:(Visa *)value;
- (void)removeIssuedVisasObject:(Visa *)value;
- (void)addIssuedVisas:(NSSet *)values;
- (void)removeIssuedVisas:(NSSet *)values;

- (void)addEntryTripsObject:(Trip *)value;
- (void)removeEntryTripsObject:(Trip *)value;
- (void)addEntryTrips:(NSSet *)values;
- (void)removeEntryTrips:(NSSet *)values;

- (void)addOutedTripsObject:(Trip *)value;
- (void)removeOutedTripsObject:(Trip *)value;
- (void)addOutedTrips:(NSSet *)values;
- (void)removeOutedTrips:(NSSet *)values;

- (void)addRulesByVehicleObject:(CountryWithVehicleRule *)value;
- (void)removeRulesByVehicleObject:(CountryWithVehicleRule *)value;
- (void)addRulesByVehicle:(NSSet *)values;
- (void)removeRulesByVehicle:(NSSet *)values;

@end
