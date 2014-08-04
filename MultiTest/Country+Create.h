//
//  Country+Create.h
//  MultiTest
//
//  Created by Administrator on 28.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "Country.h"

@interface Country (Create)

+(Country *) countryWithTitle: (NSString *)title andStatus: (NSNumber *) status inContext: (NSManagedObjectContext *) context;
+(Country *) mainCountryInContext:(NSManagedObjectContext *) context;
+(NSFetchRequest *) standartRequest;
+(NSArray *)standartRequestResultsInContext:(NSManagedObjectContext *) context;

+(BOOL) setupMainCountryInContext: (NSManagedObjectContext *) context;
+(BOOL) setupAllCountriesInContext: (NSManagedObjectContext *) context;

-(NSInteger) rowOfAllCountries;
-(NSInteger) rowOfCountryArray:(NSArray *)countries;
@end
