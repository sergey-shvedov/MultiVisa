//
//  DayWithTrip+Create.h
//  MultiTest
//
//  Created by Administrator on 12.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "DayWithTrip.h"

@interface DayWithTrip (Create)

+(void) updateDaysFromDate: (NSDate *) entryDate toDate: (NSDate *) outDate withTrip: (Trip *)trip inContext: (NSManagedObjectContext *) context;
+(void) resettingDaysWithTrip: (Trip *) trip inContext: (NSManagedObjectContext *) context withOldIssueDate: (NSDate *) oldIssueDate andOldExperationDate: (NSDate *) oldExperationDate;

@end
