//
//  UserWithTrip.h
//  MultiTest
//
//  Created by Administrator on 04.06.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Trip, User;

@interface UserWithTrip : NSManagedObject

@property (nonatomic, retain) Trip *inTrip;
@property (nonatomic, retain) User *whoTravel;

@end
