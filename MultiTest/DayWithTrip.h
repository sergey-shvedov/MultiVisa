//
//  DayWithTrip.h
//  MultiTest
//
//  Created by Administrator on 10.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Day, Trip;

@interface DayWithTrip : NSManagedObject

@property (nonatomic, retain) NSNumber * isEntry;
@property (nonatomic, retain) NSNumber * isOut;
@property (nonatomic, retain) Trip *inTrip;
@property (nonatomic, retain) Day *usedDay;

@end
