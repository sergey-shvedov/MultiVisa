//
//  DayWithVisa+Create.h
//  MultiTest
//
//  Created by Administrator on 12.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "DayWithVisa.h"

@interface DayWithVisa (Create)
+(void) updateDaysFromDate: (NSDate *) startDate toDate: (NSDate *) endDate withVisa: (Visa *)visa inContext: (NSManagedObjectContext *) context;
+(void) resettingDaysWithVisa: (Visa*)visa inContext: (NSManagedObjectContext *) context withOldIssueDate: (NSDate *) oldIssueDate andOldExperationDate: (NSDate *) oldExperationDate;
+(void) deleteDaysWithVisa: (Visa *) visa inContext:(NSManagedObjectContext *) context;

@end
