//
//  User.h
//  MultiTest
//
//  Created by Administrator on 27.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Passport, UserWithTrip;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSNumber * isMale;
@property (nonatomic, retain) NSSet *passports;
@property (nonatomic, retain) NSSet *tripsByUser;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addPassportsObject:(Passport *)value;
- (void)removePassportsObject:(Passport *)value;
- (void)addPassports:(NSSet *)values;
- (void)removePassports:(NSSet *)values;

- (void)addTripsByUserObject:(UserWithTrip *)value;
- (void)removeTripsByUserObject:(UserWithTrip *)value;
- (void)addTripsByUser:(NSSet *)values;
- (void)removeTripsByUser:(NSSet *)values;

@end
