//
//  Week+Create.h
//  MultiTest
//
//  Created by Administrator on 10.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "Week.h"

@interface Week (Create)
+(Week *) minWeekinContext: (NSManagedObjectContext *) context;
+(Week *) maxWeekinContext: (NSManagedObjectContext *) context;
+(void) insertWeekNumber: (NSInteger)number WithMonday:(NSDate *)date inContext: (NSManagedObjectContext *) context;
@end
