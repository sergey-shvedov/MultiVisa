//
//  DayWithVisa.h
//  MultiTest
//
//  Created by Administrator on 10.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Day, Visa;

@interface DayWithVisa : NSManagedObject

@property (nonatomic, retain) NSNumber * isStart;
@property (nonatomic, retain) NSNumber * isEnd;
@property (nonatomic, retain) Visa *inVisa;
@property (nonatomic, retain) Day *usedDay;

@end
