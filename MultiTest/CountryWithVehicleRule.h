//
//  CountryWithVehicleRule.h
//  MultiTest
//
//  Created by Administrator on 27.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Country, Vehicle;

@interface CountryWithVehicleRule : NSManagedObject

@property (nonatomic, retain) NSNumber * maxNoVisaDays;
@property (nonatomic, retain) NSNumber * maxNoVisaDaysPeriod;
@property (nonatomic, retain) Country *inCountry;
@property (nonatomic, retain) Vehicle *byVehicle;

@end
