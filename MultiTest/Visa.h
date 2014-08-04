//
//  Visa.h
//  MultiTest
//
//  Created by Administrator on 10.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Country, DayWithVisa, Passport;

@interface Visa : NSManagedObject

@property (nonatomic, retain) NSNumber * currentNumberEntries;
@property (nonatomic, retain) NSNumber * days;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSNumber * multiEntryType;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSString * typeABC;
@property (nonatomic, retain) NSNumber * yearType;
@property (nonatomic, retain) Country *forCountry;
@property (nonatomic, retain) Passport *inPassport;
@property (nonatomic, retain) NSSet *daysByVisa;
@end

@interface Visa (CoreDataGeneratedAccessors)

- (void)addDaysByVisaObject:(DayWithVisa *)value;
- (void)removeDaysByVisaObject:(DayWithVisa *)value;
- (void)addDaysByVisa:(NSSet *)values;
- (void)removeDaysByVisa:(NSSet *)values;

@end
