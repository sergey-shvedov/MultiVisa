//
//  CountryWithVehicleRule+Create.h
//  MultiTest
//
//  Created by Administrator on 28.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "CountryWithVehicleRule.h"

#define MAX_NO_VISA_DAYS @0
#define MAX_NO_VISA_DAYS_PERIOD @180

@interface CountryWithVehicleRule (Create)
+(CountryWithVehicleRule *) countryRuleFor:(Country *)country withVehicle:(Vehicle *)vehicle withMaxNoVisaDays:(NSNumber *)maxNoVisaDays andPeriod: (NSNumber *)maxNoVisaDaysPeriod inContext:(NSManagedObjectContext *)context;
+(CountryWithVehicleRule *) countryRuleFor:(Country *)country withVehicle:(Vehicle *)vehicle inContext:(NSManagedObjectContext *)context;
+(BOOL)createAllCountryRulesFor:(Country *)country withMaxNoVisaDays:(NSNumber *)maxNoVisaDays andPeriod: (NSNumber *)maxNoVisaDaysPeriod inContext:(NSManagedObjectContext *)context;
+(BOOL)createStandartAllCountryRulesFor:(Country *)country inContext:(NSManagedObjectContext *)contect;
@end
