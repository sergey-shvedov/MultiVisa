//
//  Week.h
//  MultiTest
//
//  Created by Administrator on 10.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Day;

@interface Week : NSManagedObject

@property (nonatomic, retain) NSNumber * from2001;
@property (nonatomic, retain) NSNumber * mainMonth;
@property (nonatomic, retain) NSNumber * numberFromMonthBeginner;
@property (nonatomic, retain) NSSet *days;
@end

@interface Week (CoreDataGeneratedAccessors)

- (void)addDaysObject:(Day *)value;
- (void)removeDaysObject:(Day *)value;
- (void)addDays:(NSSet *)values;
- (void)removeDays:(NSSet *)values;

@end
