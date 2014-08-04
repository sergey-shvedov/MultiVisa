//
//  Vehicle.h
//  MultiTest
//
//  Created by Administrator on 28.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CountryWithVehicleRule, Trip;

@interface Vehicle : NSManagedObject

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSSet *entryTrips;
@property (nonatomic, retain) NSSet *outedTrips;
@property (nonatomic, retain) NSSet *rulesByCountry;
@end

@interface Vehicle (CoreDataGeneratedAccessors)

- (void)addEntryTripsObject:(Trip *)value;
- (void)removeEntryTripsObject:(Trip *)value;
- (void)addEntryTrips:(NSSet *)values;
- (void)removeEntryTrips:(NSSet *)values;

- (void)addOutedTripsObject:(Trip *)value;
- (void)removeOutedTripsObject:(Trip *)value;
- (void)addOutedTrips:(NSSet *)values;
- (void)removeOutedTrips:(NSSet *)values;

- (void)addRulesByCountryObject:(CountryWithVehicleRule *)value;
- (void)removeRulesByCountryObject:(CountryWithVehicleRule *)value;
- (void)addRulesByCountry:(NSSet *)values;
- (void)removeRulesByCountry:(NSSet *)values;

@end
