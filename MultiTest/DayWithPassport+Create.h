//
//  DayWithPassport+Create.h
//  MultiTest
//
//  Created by Administrator on 11.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "DayWithPassport.h"

@interface DayWithPassport (Create)
+(void) updateDaysFromDate: (NSDate *) issueDate toDate: (NSDate *) experationDate withPassport: (Passport *)passport inContext: (NSManagedObjectContext *) context;
+(void) resettingDaysWithPassport: (Passport*)passport inContext: (NSManagedObjectContext *) context withOldIssueDate: (NSDate *) oldIssueDate andOldExperationDate: (NSDate *) oldExperationDate;
+(void) deleteDaysWithPassport: (Passport *)passport inContext:(NSManagedObjectContext *) context;
@end
