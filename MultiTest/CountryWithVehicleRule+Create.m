//
//  CountryWithVehicleRule+Create.m
//  MultiTest
//
//  Created by Administrator on 28.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "CountryWithVehicleRule+Create.h"
#import "Vehicle+Create.h"
#import "Country+Create.h"

@implementation CountryWithVehicleRule (Create)
+(CountryWithVehicleRule *)countryRuleFor:(Country *)country withVehicle:(Vehicle *)vehicle inContext:(NSManagedObjectContext *)context
{
    return [[self class] countryRuleFor:country withVehicle:vehicle withMaxNoVisaDays:MAX_NO_VISA_DAYS andPeriod:MAX_NO_VISA_DAYS_PERIOD inContext:context];
}
+(CountryWithVehicleRule *)countryRuleFor:(Country *)country withVehicle:(Vehicle *)vehicle withMaxNoVisaDays:(NSNumber *)maxNoVisaDays andPeriod:(NSNumber *)maxNoVisaDaysPeriod inContext:(NSManagedObjectContext *)context
{
    CountryWithVehicleRule *countryRule=nil;
    
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"CountryWithVehicleRule"];
    //NSLog(@"STEP REQUEST");
    request.predicate=[NSPredicate predicateWithFormat:@"inCountry = %@ && byVehicle = %@",country,vehicle];
    NSError *error;
    NSArray *matches=[context executeFetchRequest:request error:&error];
    
    if (!matches || [matches count]>1) {
        //error
    }else if ([matches count] == 1){
        //already exists
        countryRule=[matches lastObject];
        //NSLog(@"Rule allready exists for %@ by %@",countryRule.inCountry.titleRUS,countryRule.byVehicle.type);
        if (countryRule.maxNoVisaDays!=maxNoVisaDays || countryRule.maxNoVisaDaysPeriod!=maxNoVisaDaysPeriod) {
            countryRule.maxNoVisaDays=maxNoVisaDays;
            countryRule.maxNoVisaDaysPeriod=maxNoVisaDaysPeriod;
        }
    }else{
        //create new one
        countryRule=[NSEntityDescription insertNewObjectForEntityForName:@"CountryWithVehicleRule" inManagedObjectContext:context];
        countryRule.maxNoVisaDays=maxNoVisaDays;
        countryRule.maxNoVisaDaysPeriod=maxNoVisaDaysPeriod;
        countryRule.inCountry=country;
        countryRule.byVehicle=vehicle;
        //NSLog(@"Created new Rule for %@ with %@: %@ no visa days per %@",countryRule.inCountry.titleRUS, countryRule.byVehicle.type,countryRule.maxNoVisaDays, countryRule.maxNoVisaDaysPeriod);
    }
    
    return countryRule;
}
+(BOOL)createStandartAllCountryRulesFor:(Country *)country inContext:(NSManagedObjectContext *)contect
{
    return [[self class] createAllCountryRulesFor:country withMaxNoVisaDays:MAX_NO_VISA_DAYS andPeriod:MAX_NO_VISA_DAYS_PERIOD inContext:contect];
    
}
+(BOOL)createAllCountryRulesFor:(Country *)country withMaxNoVisaDays:(NSNumber *)maxNoVisaDays andPeriod:(NSNumber *)maxNoVisaDaysPeriod inContext:(NSManagedObjectContext *)context
{
    NSArray *allVehicles=[Vehicle allVehiclesinContext:context];
    if ([allVehicles count]>0) {
        for (Vehicle *vehicle in allVehicles){
            CountryWithVehicleRule * rule=[self countryRuleFor:country withVehicle:vehicle withMaxNoVisaDays:maxNoVisaDays andPeriod:maxNoVisaDaysPeriod inContext:context];
            if (rule) NSLog(@"---------");
        }
        return YES;
    }
    return NO;
}

@end
