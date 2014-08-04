//
//  Day.h
//  MultiTest
//
//  Created by Administrator on 04.06.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DayWithPassport, DayWithTrip, DayWithVisa, Week;

@interface Day : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * day;
@property (nonatomic, retain) NSNumber * from2001;
@property (nonatomic, retain) NSNumber * month;
@property (nonatomic, retain) NSNumber * weekDay;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSNumber * last180TripDays;
@property (nonatomic, retain) Week *inWeek;
@property (nonatomic, retain) NSSet *passportsByDay;
@property (nonatomic, retain) NSSet *tripsByDay;
@property (nonatomic, retain) NSSet *visasByDay;
@end

@interface Day (CoreDataGeneratedAccessors)

- (void)addPassportsByDayObject:(DayWithPassport *)value;
- (void)removePassportsByDayObject:(DayWithPassport *)value;
- (void)addPassportsByDay:(NSSet *)values;
- (void)removePassportsByDay:(NSSet *)values;

- (void)addTripsByDayObject:(DayWithTrip *)value;
- (void)removeTripsByDayObject:(DayWithTrip *)value;
- (void)addTripsByDay:(NSSet *)values;
- (void)removeTripsByDay:(NSSet *)values;

- (void)addVisasByDayObject:(DayWithVisa *)value;
- (void)removeVisasByDayObject:(DayWithVisa *)value;
- (void)addVisasByDay:(NSSet *)values;
- (void)removeVisasByDay:(NSSet *)values;

@end


