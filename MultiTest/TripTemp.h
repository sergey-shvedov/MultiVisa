//
//  TripTemp.h
//  MultiTest
//
//  Created by Administrator on 08.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country+Create.h"
#import "Trip.h"
#import "Vehicle+Create.h"

@interface TripTemp : NSObject

+(TripTemp *) editingTripTempCopyFromTrip:(Trip *)trip;
+(TripTemp *) defaultTripTempInContext:(NSManagedObjectContext *) context;


-(void) updateDaysWithTrip: (Trip *)trip inContext:(NSManagedObjectContext *)context;
-(void) updateTrip: (Trip *)trip;
-(void) insertNewTripInContext:(NSManagedObjectContext *)saveContext;
-(void) deleteTrip: (Trip *) trip InContext:(NSManagedObjectContext *)context;

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * entryDate;
@property (nonatomic, retain) NSDate * outDate;
@property (nonatomic, retain) NSNumber * numberOfTravelers;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSSet *usersByTrip;
@property (nonatomic, retain) Country *entryCountry;
@property (nonatomic, retain) Country *outCountry;
@property (nonatomic, retain) Vehicle *entryVehicle;
@property (nonatomic, retain) Vehicle *outVehicle;
@property (nonatomic, retain) NSSet *daysByTrip;

@property (strong,nonatomic) NSArray *users;

@property (nonatomic) BOOL isEntryCountryNeedEdit;
@property (nonatomic) BOOL isEntryCountryEdited;
@property (nonatomic) BOOL isOutCountryNeedEdit;
@property (nonatomic) BOOL isOutCountryEdited;
@property (nonatomic) BOOL isEntryDateNeedEdit;
@property (nonatomic) BOOL isEntryDateEdited;
@property (nonatomic) BOOL isOutDateNeedEdit;
@property (nonatomic) BOOL isOutDateEdited;
@property (nonatomic) BOOL isTitleNeedEdit;
@property (nonatomic) BOOL isTitleEdited;


@property (nonatomic) BOOL isNeedToEdit;

@end
