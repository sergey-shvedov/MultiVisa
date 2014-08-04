//
//  DayWithPassport.h
//  MultiTest
//
//  Created by Administrator on 10.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Day, Passport;

@interface DayWithPassport : NSManagedObject

@property (nonatomic, retain) NSNumber * isIssue;
@property (nonatomic, retain) NSNumber * isExperation;
@property (nonatomic, retain) Day *usedDay;
@property (nonatomic, retain) Passport *inPassport;

@end
