//
//  PassportTemp.h
//  MultiTest
//
//  Created by Administrator on 09.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Visa.h"
#import "User+Create.h"
#import "Passport.h"

@interface PassportTemp : NSObject

+(PassportTemp *) editingPassportTempCopyFromPassport:(Passport *)passport;
+(PassportTemp *) defaultPassportTempInContext:(NSManagedObjectContext *) context;

-(void) updateDaysWithPassport:(Passport *)passport inContext: (NSManagedObjectContext *)context;

-(void) updatePassport:(Passport *)passport;
-(void) insertNewPassportInContext:(NSManagedObjectContext *)context;

-(void) deletePassport: (Passport *) passport InContext:(NSManagedObjectContext *)context;

@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSNumber * isFingerprinting;
@property (nonatomic, retain) NSDate * issueDate;
@property (nonatomic, retain) NSDate * experationDate;
@property (nonatomic, retain) User *whoOwn;
@property (nonatomic, retain) NSSet *visas;
@property (nonatomic, retain) NSSet *daysByPassport;

@property (nonatomic) BOOL isIssueDateNeedEdit;
@property (nonatomic) BOOL isIssueDateEdited;
@property (nonatomic) BOOL isExperationDateNeedEdit;
@property (nonatomic) BOOL isExperationDateEdited;
@property (nonatomic) BOOL isTypeNeedEdit;
@property (nonatomic) BOOL isTypeEdited;

@property (nonatomic) BOOL isNeedToEdit;

@end
