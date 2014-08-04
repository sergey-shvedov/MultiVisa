//
//  DayWithPassport+Create.m
//  MultiTest
//
//  Created by Administrator on 11.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "DayWithPassport+Create.h"
#import "Day+Create.h"
#import "NSDate+Project.h"
#import "Passport+Create.h"
#import "Visa.h"

@implementation DayWithPassport (Create)
+(void) updateDaysFromDate: (NSDate *) issueDate toDate: (NSDate *) experationDate withPassport: (Passport *)passport inContext: (NSManagedObjectContext *) context
{
    //setup all days
    
    [Day insertDaysFromDate:issueDate toDate:experationDate inContext:context];
    
    //Get all days
    
    NSFetchRequest *request =[NSFetchRequest fetchRequestWithEntityName:@"Day"];
    request.predicate=[NSPredicate predicateWithFormat:@"from2001>=%@ && from2001<=%@",[NSNumber numberWithInteger:[issueDate daysFrom2001]],[NSNumber numberWithInteger:[experationDate daysFrom2001]]];
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001"ascending:YES selector:@selector(compare:)]];
    NSError *error;
    NSArray *days=[context executeFetchRequest:request error:&error];
    
    //Set this passport for days
    for (Day *day in days)
    {
        DayWithPassport *dayWithPassport =[NSEntityDescription insertNewObjectForEntityForName:@"DayWithPassport" inManagedObjectContext:context];
        dayWithPassport.usedDay=day;
        dayWithPassport.inPassport=passport;
       
        if ([[days firstObject] isEqual:day]) {
             dayWithPassport.isIssue=@1;
            //NSLog(@"IsIssue: %@",day);
        }else dayWithPassport.isIssue=@0;
        if ([[days lastObject] isEqual:day]) {
            dayWithPassport.isExperation=@1;
            //NSLog(@"IsExperation: %@",day);
        }else dayWithPassport.isExperation=@0;
        
    }
}

+(void) resettingDaysWithPassport: (Passport*)passport inContext: (NSManagedObjectContext *) context withOldIssueDate: (NSDate *) oldIssueDate andOldExperationDate: (NSDate *) oldExperationDate
{
    //Setup all days
    
    [Day insertDaysFromDate:passport.issueDate toDate:passport.experationDate inContext:context];
    
    //Get DayWithPassport to delete
    
    NSFetchRequest *request =[NSFetchRequest fetchRequestWithEntityName:@"DayWithPassport"];
    request.predicate=[NSPredicate predicateWithFormat:@"inPassport = %@ && (usedDay.from2001<%@ || usedDay.from2001>%@)", passport, [NSNumber numberWithInteger:[passport.issueDate daysFrom2001]],[NSNumber numberWithInteger:[passport.experationDate daysFrom2001]]];
    //request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001"ascending:YES selector:@selector(compare:)]];
    NSError *error;
    NSArray *daysWithPassportToDelete=[context executeFetchRequest:request error:&error];
    //NSLog(@"daysWithPassportToDelete: %lu",(unsigned long)[daysWithPassportToDelete count]);
    
    
    for (DayWithPassport *dayWithPassport in daysWithPassportToDelete)
    {
        [context deleteObject:dayWithPassport];
        //
    }
    
    
    //Get days to craete new DayWithPassport
    
    NSFetchRequest *requestD =[NSFetchRequest fetchRequestWithEntityName:@"Day"];
    //requestD.predicate=[NSPredicate predicateWithFormat:@"(from2001>=%@ && from2001<=%@) && (ANY passportsByDay.inPassport != %@)",[NSNumber numberWithInteger:[passport.issueDate daysFrom2001]],[NSNumber numberWithInteger:[passport.experationDate daysFrom2001]], passport];
    requestD.predicate=[NSPredicate predicateWithFormat:@"from2001>=%@ && from2001<=%@",[NSNumber numberWithInteger:[passport.issueDate daysFrom2001]],[NSNumber numberWithInteger:[passport.experationDate daysFrom2001]]];
    requestD.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001"ascending:YES selector:@selector(compare:)]];
    NSError *errorD;
    NSArray *days=[context executeFetchRequest:requestD error:&errorD];
    //NSLog(@"Get days to craete new DayWithPassport: %lu",(unsigned long)[days count]);
    
    NSInteger createOfDWP=0;
    for (Day *day in days)
    {
        NSInteger countOfDWP=0;
        
        for (DayWithPassport *dayWithPassport in day.passportsByDay){
            if ([dayWithPassport.inPassport isEqual:passport]) {
                countOfDWP++;
                //NSLog(@"dayWithPassport Allready exist %d objects", countOfDWP);
                dayWithPassport.isIssue=@0;
                dayWithPassport.isExperation=@0;
            }
        }
        
        if (0 == countOfDWP) { //create new one
            createOfDWP++;
            DayWithPassport *dayWithPassport =[NSEntityDescription insertNewObjectForEntityForName:@"DayWithPassport" inManagedObjectContext:context];
            dayWithPassport.usedDay=day;
            dayWithPassport.inPassport=passport;
            dayWithPassport.isIssue=@0;
            dayWithPassport.isExperation=@0;
            //NSLog(@"create new dayWithPassport # %d", createOfDWP);
        }
        
    }

    
    NSFetchRequest *requestD2 =[NSFetchRequest fetchRequestWithEntityName:@"DayWithPassport"];
    requestD2.predicate=[NSPredicate predicateWithFormat:@"(usedDay.from2001==%@ || usedDay.from2001==%@) && inPassport == %@",[NSNumber numberWithInteger:[passport.issueDate daysFrom2001]],[NSNumber numberWithInteger:[passport.experationDate daysFrom2001]],passport];
    requestD2.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"usedDay.from2001"ascending:YES selector:@selector(compare:)]];
    NSError *errorD2;
    NSArray *daysWP2=[context executeFetchRequest:requestD2 error:&errorD2];
    //NSLog(@"Set DayWithPassport to reset properties: %lu",(unsigned long)[daysWP2 count]);
    if ([daysWP2 count]) {
        ((DayWithPassport *)[daysWP2 firstObject]).isIssue=@1;
        //((DayWithPassport *)[daysWP2 firstObject]).isExperation=@0;
        //((DayWithPassport *)[daysWP2 lastObject]).isIssue=@0;
        ((DayWithPassport *)[daysWP2 lastObject]).isExperation=@1;
        
    }
    
    
    //Get dayVithPassport to reset properties

//    NSFetchRequest *requestD1 =[NSFetchRequest fetchRequestWithEntityName:@"DayWithPassport"];
//    requestD1.predicate=[NSPredicate predicateWithFormat:@"usedDay.from2001==%@ || usedDay.from2001==%@ && inPassport == %@",[NSNumber numberWithInteger:[oldIssueDate daysFrom2001]],[NSNumber numberWithInteger:[oldExperationDate daysFrom2001]], passport];
//    requestD1.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"usedDay.from2001"ascending:YES selector:@selector(compare:)]];
//    NSError *errorD1;
//    NSArray *daysWP1=[context executeFetchRequest:requestD1 error:&errorD1];
//    NSLog(@"Get DayWithPassport to reset properties: %lu",(unsigned long)[daysWP1 count]);
//    if ([daysWP1 count]) {
//        for (DayWithPassport *dayWithPassport in daysWP1) {
//            dayWithPassport.isIssue=@0;
//            dayWithPassport.isExperation=@0;
//        }
//    }
//    

    
}

//NOT USED NOW / USED CASCADE RULE
+(void)deleteDaysWithPassport:(Passport *)passport inContext:(NSManagedObjectContext *)context
{
    //Get all dayVithPassport
    
    NSFetchRequest *request =[NSFetchRequest fetchRequestWithEntityName:@"DayWithPassport"];
    request.predicate=[NSPredicate predicateWithFormat:@"inPassport == %@", passport];
    
    NSError *error;
    NSArray *daysWithPassport=[context executeFetchRequest:request error:&error];
    //NSLog(@"Found %d daysWithPassport to delete", [daysWithPassport count]);
    //Set Passport's visas to default passport
    
    Passport *mainPassport = [Passport mainPassportInContext:context];
    if (mainPassport) {
        for (Visa *visa in passport.visas)
        {
            visa.inPassport=mainPassport;
        }
    }

    [context deleteObject:passport]; //Delete the Passport
    NSError *error2;
    [context save:&error2]; //Save
    
    
    for (DayWithPassport *dayWithPassport in daysWithPassport) //Delete dayWithPassports  USED CASCADE RULE
    {
        [context deleteObject:dayWithPassport];
        
    }
    
    [context save:&error2]; //Save
}


@end
