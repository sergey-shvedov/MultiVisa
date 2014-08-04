//
//  Day+Create.h
//  MultiTest
//
//  Created by Administrator on 10.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "Day.h"

@interface Day (Create)
+(Day *) minDayinContext: (NSManagedObjectContext *) context;
+(Day *) maxDayinContext: (NSManagedObjectContext *) context;
+(NSDate *) minDayDateinContext: (NSManagedObjectContext *) context;
+(NSDate *) maxDayDateinContext: (NSManagedObjectContext *) context;
+(void) insertDaysFromDate: (NSDate *) startDate toDate: (NSDate *) endDate inContext: (NSManagedObjectContext *) context;
+(Day *) dayTodayinContext: (NSManagedObjectContext *) context;

-(NSInteger)numberOfTripDaysByLast: (NSInteger) numberOfDays;
-(NSInteger) numberOfTripDaysCanUseFromNow;
-(NSDate *) dateOfLegalTripWithIntegerDays: (NSInteger) tripDays;

+(Day *) dayFromNumberFrom2001: (NSNumber *) numberFrom2001 inContext: (NSManagedObjectContext *) context;
@end
