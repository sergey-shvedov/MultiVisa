//
//  VisaTemp.h
//  MultiTest
//
//  Created by Administrator on 01.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country+Create.h"
#import "Passport+Create.h"
#import "Visa.h"

@interface VisaTemp : NSObject
+(VisaTemp *) editingVisaTempCopyFromVisa:(Visa *)visa;
+(VisaTemp *) defaultVisaTempInContext:(NSManagedObjectContext *) context;

-(void) updateDaysWithVisa: (Visa *)visa inContext:(NSManagedObjectContext *)context;
-(void) updateVisa: (Visa *)visa;
-(void) insertNewVisaInContext:(NSManagedObjectContext *)context;
-(void) deleteVisa: (Visa *) visa InContext:(NSManagedObjectContext *)context;

@property (nonatomic, retain) NSString * typeABC;
@property (nonatomic, retain) NSNumber * currentNumberEntries;
@property (nonatomic, retain) NSNumber * days;
@property (nonatomic, retain) NSNumber * multiEntryType;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSNumber * yearType;
@property (nonatomic, retain) Passport *inPassport;
@property (nonatomic, retain) Country *forCountry;
@property (nonatomic, retain) NSSet *daysByVisa;

@property (nonatomic) BOOL isCountryNeedEdit;
@property (nonatomic) BOOL isCountryEdited;
@property (nonatomic) BOOL isStartDateNeedEdit;
@property (nonatomic) BOOL isStartDateEdited;
@property (nonatomic) BOOL isEndDateNeedEdit;
@property (nonatomic) BOOL isEndDateEdited;
@property (nonatomic) BOOL isVisaTypeNeedEdit;
@property (nonatomic) BOOL isVisaTypeEdited;
@property (nonatomic) BOOL isDaysNeedEdit;
@property (nonatomic) BOOL isDaysEdited;
@property (nonatomic) BOOL isPassportNeedEdit;
@property (nonatomic) BOOL isPassportEdited;

@property (nonatomic) BOOL isNeedToEdit;


@end
