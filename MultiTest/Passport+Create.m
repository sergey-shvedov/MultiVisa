//
//  Passport+Create.m
//  MultiTest
//
//  Created by Administrator on 01.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "Passport+Create.h"
#import "User+Create.h"
#import "NSDate+Project.h"

@implementation Passport (Create)
+(Passport *)mainPassportInContext:(NSManagedObjectContext *)context
{
    Passport *mainPassport=nil;
    
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Passport"];
    request.predicate=[NSPredicate predicateWithFormat:@"type = %@", @100];
    NSError *error;
    NSArray *mathes=[context executeFetchRequest:request error:&error];
    
    if (!mathes) {
        //error
    }else if (0 == [mathes count]){
        //Create New Main Passport
        mainPassport=[NSEntityDescription insertNewObjectForEntityForName:@"Passport" inManagedObjectContext:context];
        mainPassport.number=@"";
        mainPassport.type=@100; //main index
        mainPassport.isFingerprinting=@1;
        mainPassport.issueDate=[NSDate dateTo12h00EUfromDate:[NSDate dateWithTimeIntervalSinceNow:-60*60*24*365*20]];
        mainPassport.experationDate=[NSDate dateTo12h00EUfromDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*365*30]];
        mainPassport.whoOwn=[User mainUserInContext:context];
        mainPassport.visas=nil;
//#warning Need to handle .daysByPassport
        mainPassport.daysByPassport=nil;
    }else if (1 == [mathes count]){
        if ([mathes[0] isKindOfClass:[Passport class]]) mainPassport=(Passport *)mathes[0];
    }else{
        //error Multi main passports
        if ([mathes[0] isKindOfClass:[Passport class]]) mainPassport=(Passport *)mathes[0];
    }
    return mainPassport;
}
+(NSFetchRequest *) standartRequest
{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Passport"];
    request.predicate=nil;
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"experationDate" ascending:NO selector:@selector(compare:)]];
    return request;
}
+(NSArray *)standartRequestResultsInContext:(NSManagedObjectContext *)context
{
    NSError *error;
    NSArray *mathes= [context executeFetchRequest:[self standartRequest] error:&error];
    return mathes;
}
-(NSInteger)rowOfPassportArray:(NSArray *)passports
{
    NSInteger row=-1;
    if (passports && [passports count]>0) {
        if ([[passports firstObject]isKindOfClass:[Passport class]]) {
            if ([self.managedObjectContext isEqual:((Passport *)[passports firstObject]).managedObjectContext]) {
                if ([passports containsObject:self]) {
                    return [passports indexOfObject:self];
                }else return 0;
                
            }
        }
        
    }
    return row;
}
@end
