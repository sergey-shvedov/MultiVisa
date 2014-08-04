//
//  Trip.h
//  MultiTest
//
//  Created by Administrator on 04.06.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Country, DayWithTrip, UserWithTrip, Vehicle;

@interface Trip : NSManagedObject

@property (nonatomic, retain) NSDate * entryDate;
@property (nonatomic, retain) NSNumber * numberOfTravelers;
@property (nonatomic, retain) NSDate * outDate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSSet *daysByTrip;
@property (nonatomic, retain) Country *entryCountry;
@property (nonatomic, retain) Vehicle *entryVehicle;
@property (nonatomic, retain) Country *outCountry;
@property (nonatomic, retain) Vehicle *outVehicle;
@property (nonatomic, retain) NSSet *usersByTrip;
@end

@interface Trip (CoreDataGeneratedAccessors)

- (void)addDaysByTripObject:(DayWithTrip *)value;
- (void)removeDaysByTripObject:(DayWithTrip *)value;
- (void)addDaysByTrip:(NSSet *)values;
- (void)removeDaysByTrip:(NSSet *)values;

- (void)addUsersByTripObject:(UserWithTrip *)value;
- (void)removeUsersByTripObject:(UserWithTrip *)value;
- (void)addUsersByTrip:(NSSet *)values;
- (void)removeUsersByTrip:(NSSet *)values;

@end
