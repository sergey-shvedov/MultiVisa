//
//  Country+Create.m
//  MultiTest
//
//  Created by Administrator on 28.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "Country+Create.h"
#import "CountryWithVehicleRule+Create.h"

@implementation Country (Create)
+(NSFetchRequest *)standartRequest
{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Country"];
    request.predicate=nil;
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"status" ascending:YES selector:@selector(compare:)],[NSSortDescriptor sortDescriptorWithKey:@"titleRUS" ascending:YES selector:@selector(localizedStandardCompare:)]];
    return request;

}
+(NSArray *)standartRequestResultsInContext:(NSManagedObjectContext *) context
{
    NSError *error;
    NSArray *mathes= [context executeFetchRequest:[self standartRequest] error:&error];
    return mathes;
}
+(BOOL)setupMainCountryInContext:(NSManagedObjectContext *)context
{
    Country *eu=[self mainCountryInContext:context];
    if (eu /*&& !eu.titleRUS*/) {
        eu.titleRUS=@"Страны Шенгенской зоны";
        eu.isEU=@1;
        eu.isShengen=@1;
        eu.maxTurVisaDays=@90;
        eu.maxTurVisaDaysPeriod=@180;
        //NSLog(@"SetUp: %@",eu.titleRUS);
        BOOL isRuled=[CountryWithVehicleRule createStandartAllCountryRulesFor:eu inContext:context];
        if (YES==isRuled) NSLog(@"Rules for %@ setted", eu.titleRUS);
        return YES;
    }else return NO;
}
+(BOOL)setupAllCountriesInContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Country"];
    NSError *error;
    NSArray *mathes=[context executeFetchRequest:request error:&error];
    if (!mathes || [mathes count]>1) { //>1
    }else{
        NSArray *allCountries =@[@"A",@"B",@"BG",@"H",@"D",
                                 @"GR",@"DK",@"IS",@"E",
                                 @"I",@"LV",@"LT",@"FL",
                                 @"L",@"M",@"NL",@"N",
                                 @"PL",@"P",@"RO",@"SK",@"SLO",
                                 @"FIN",@"F",@"CZ",@"CH",
                                 @"S",@"EST"
                                 ];
        NSArray *allCountriesRUS = @[@"Австрия",@"Бельгия",@"Болгария",@"Венгрия",@"Германия",
                                     @"Греция",@"Дания",@"Исландия",@"Испания",
                                     @"Италия",@"Латвия",@"Литва",@"Лихтенштейн",
                                     @"Люксембург",@"Мальта",@"Нидерланды",@"Норвегия",
                                     @"Польша",@"Португалия",@"Румыния",@"Словакия",@"Словения",
                                     @"Финляндия",@"Франция",@"Чехия",@"Швейцария",
                                     @"Швеция",@"Эстония"
                                     ];
        
        for (int i=0; i<[allCountries count]; i++) { // i=0
            
            
            if ([allCountries[i] length]) {
                
                Country *new=[self countryWithTitle:allCountries[i] andStatus:@1 inContext:context];
                
                if (i<[allCountriesRUS count]) {
                    new.titleRUS=allCountriesRUS[i];
                }
                
                new.isEU=@1;
                if (7==i || 12==i || 16==i || 25==i) {
                    new.isEU=@0;
                }
                new.isShengen=@1;
                new.maxTurVisaDays=@90;
                new.maxTurVisaDaysPeriod=@180;
                //NSLog(@"SetUp: %@",new.titleRUS);
                BOOL isRuled=[CountryWithVehicleRule createStandartAllCountryRulesFor:new inContext:context];
                if (YES==isRuled) NSLog(@"Rules for %@ setted", new.titleRUS);
                
            }
        }
    }
    return YES;
}
+(Country *)mainCountryInContext:(NSManagedObjectContext *)context
{
    return [self countryWithTitle:@"EU" andStatus:@0 inContext:context];
}
+(Country *)countryWithTitle:(NSString *)title andStatus:(NSNumber *)status inContext:(NSManagedObjectContext *)context
{
    Country *country = nil;
    
    if ([title length]){
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Country"];
        request.predicate=[NSPredicate predicateWithFormat:@"title = %@",title];
        NSError *error;
        NSArray *mathes=[context executeFetchRequest:request error:&error];
        
        if (!mathes || [mathes count]>1) {
            //error
        }else if (![mathes count]){
            //create new one
            country=[NSEntityDescription insertNewObjectForEntityForName:@"Country" inManagedObjectContext:context];
            country.title=title;
            country.status=status;
        }else{
            //already exists
            //NSLog(@"Already exists: %@", title);
            country=[mathes lastObject];
        }
    }
    
    return country;
}

-(NSInteger)rowOfAllCountries
{
    NSArray *countries=[Country standartRequestResultsInContext:self.managedObjectContext];
    return [self rowOfCountryArray:countries];
    /*NSInteger *row=nil;
    NSArray *countries=[Country standartRequestResultsInContext:self.managedObjectContext];
    if (countries && [countries count]>0) {
        if ([countries containsObject:self]) {
            return (NSInteger *)[countries indexOfObject:self];
        }else return (NSInteger *)1;
    }
    return  row;*/
}
-(NSInteger)rowOfCountryArray:(NSArray *)countries
{
    NSInteger row=-1;
    if (countries && [countries count]>0) {
        if ([[countries firstObject]isKindOfClass:[Country class]]) {
            if ([self.managedObjectContext isEqual:((Country *)[countries firstObject]).managedObjectContext]) {
                if ([countries containsObject:self]) {
                    return [countries indexOfObject:self];
                }else return 0;
                
            }
        }
        
    }
    return row;
}

@end
