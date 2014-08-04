//
//  Passport.h
//  MultiTest
//
//  Created by Administrator on 10.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DayWithPassport, User, Visa;

@interface Passport : NSManagedObject

@property (nonatomic, retain) NSDate * experationDate;
@property (nonatomic, retain) NSNumber * isFingerprinting;
@property (nonatomic, retain) NSDate * issueDate;
@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSSet *visas;
@property (nonatomic, retain) User *whoOwn;
@property (nonatomic, retain) NSSet *daysByPassport;
@end

@interface Passport (CoreDataGeneratedAccessors)

- (void)addVisasObject:(Visa *)value;
- (void)removeVisasObject:(Visa *)value;
- (void)addVisas:(NSSet *)values;
- (void)removeVisas:(NSSet *)values;

- (void)addDaysByPassportObject:(DayWithPassport *)value;
- (void)removeDaysByPassportObject:(DayWithPassport *)value;
- (void)addDaysByPassport:(NSSet *)values;
- (void)removeDaysByPassport:(NSSet *)values;

@end
