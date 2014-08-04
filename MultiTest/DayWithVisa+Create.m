//
//  DayWithVisa+Create.m
//  MultiTest
//
//  Created by Administrator on 12.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "DayWithVisa+Create.h"
#import "Day+Create.h"
#import "NSDate+Project.h"
#import "Visa.h"

@implementation DayWithVisa (Create)
+(void)updateDaysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate withVisa:(Visa *)visa inContext:(NSManagedObjectContext *)context
{
    //setup all days
    
    [Day insertDaysFromDate:startDate toDate:endDate inContext:context];
    
    //Get all days
    
    NSFetchRequest *request =[NSFetchRequest fetchRequestWithEntityName:@"Day"];
    request.predicate=[NSPredicate predicateWithFormat:@"from2001>=%@ && from2001<=%@",[NSNumber numberWithInteger:[startDate daysFrom2001]],[NSNumber numberWithInteger:[endDate daysFrom2001]]];
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001"ascending:YES selector:@selector(compare:)]];
    NSError *error;
    NSArray *days=[context executeFetchRequest:request error:&error];
    
    //Set this visa for days
    for (Day *day in days)
    {
        DayWithVisa *dayWithVisa =[NSEntityDescription insertNewObjectForEntityForName:@"DayWithVisa" inManagedObjectContext:context];
        dayWithVisa.usedDay=day;
        dayWithVisa.inVisa=visa;
    
        
        if ([[days firstObject] isEqual:day]) {
            dayWithVisa.isStart=@1;
            //NSLog(@"IsStart: %@",day);
        }else dayWithVisa.isStart=@0;
        if ([[days lastObject] isEqual:day]) {
            dayWithVisa.isEnd=@1;
            //NSLog(@"IsEnd: %@",day);
        }else dayWithVisa.isEnd=@0;
    }
}
+(void)resettingDaysWithVisa:(Visa *)visa inContext:(NSManagedObjectContext *)context withOldIssueDate:(NSDate *)oldIssueDate andOldExperationDate:(NSDate *)oldExperationDate
{
    //Setup all days
    
    [Day insertDaysFromDate:visa.startDate toDate:visa.endDate inContext:context];
    
    //Get DayWithVisa to delete
    
    NSFetchRequest *request =[NSFetchRequest fetchRequestWithEntityName:@"DayWithVisa"];
    request.predicate=[NSPredicate predicateWithFormat:@"inVisa = %@ && (usedDay.from2001<%@ || usedDay.from2001>%@)",visa ,[NSNumber numberWithInteger:[visa.startDate daysFrom2001]],[NSNumber numberWithInteger:[visa.endDate daysFrom2001]]];

    NSError *error;
    NSArray *daysWithVisaToDelete=[context executeFetchRequest:request error:&error];
    //NSLog(@"daysWithVisaToDelete: %lu",(unsigned long)[daysWithVisaToDelete count]);
    
    for (DayWithVisa *dayWithVisa in daysWithVisaToDelete)
    {
        [context deleteObject:dayWithVisa];
    }
    
    //Get days to craete new DayWithPassport
    
    NSFetchRequest *requestD =[NSFetchRequest fetchRequestWithEntityName:@"Day"];
    requestD.predicate=[NSPredicate predicateWithFormat:@"from2001>=%@ && from2001<=%@",[NSNumber numberWithInteger:[visa.startDate daysFrom2001]],[NSNumber numberWithInteger:[visa.endDate daysFrom2001]]];
    requestD.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001"ascending:YES selector:@selector(compare:)]];
    NSError *errorD;
    NSArray *days=[context executeFetchRequest:requestD error:&errorD];
    //NSLog(@"Get days to craete new DayWithVisa: %lu",(unsigned long)[days count]);
    
    NSInteger createOfDWV=0;
    for (Day *day in days)
    {
        NSInteger countOfDWV=0;
        
        for (DayWithVisa *dayWithVisa in day.visasByDay){
            if ([dayWithVisa.inVisa isEqual:visa]) {
                countOfDWV++;
                //NSLog(@"dayWithVisa Allready exist %d objects", countOfDWV);
                dayWithVisa.isStart=@0;
                dayWithVisa.isEnd=@0;
            }
        }
        
        if (0 == countOfDWV) { //create new one
            createOfDWV++;
            DayWithVisa *dayWithVisa =[NSEntityDescription insertNewObjectForEntityForName:@"DayWithVisa" inManagedObjectContext:context];
            dayWithVisa.usedDay=day;
            dayWithVisa.inVisa=visa;
            dayWithVisa.isStart=@0;
            dayWithVisa.isEnd=@0;
            //NSLog(@"create new dayWithVisa # %d", createOfDWV);
        }
    }
    
    
    NSFetchRequest *requestD2 =[NSFetchRequest fetchRequestWithEntityName:@"DayWithVisa"];
    requestD2.predicate=[NSPredicate predicateWithFormat:@"(usedDay.from2001==%@ || usedDay.from2001==%@) && inVisa == %@",[NSNumber numberWithInteger:[visa.startDate daysFrom2001]],[NSNumber numberWithInteger:[visa.endDate daysFrom2001]], visa];
    requestD2.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"usedDay.from2001"ascending:YES selector:@selector(compare:)]];
    NSError *errorD2;
    NSArray *daysWV2=[context executeFetchRequest:requestD2 error:&errorD2];
    //NSLog(@"Set DayWithVisa to reset properties: %lu",(unsigned long)[daysWV2 count]);
    if ([daysWV2 count]) {
        ((DayWithVisa *)[daysWV2 firstObject]).isStart=@1;
        ((DayWithVisa *)[daysWV2 lastObject]).isEnd=@1;
    }
}



//NOT USED NOW / USED CASCADE RULE
+(void)deleteDaysWithVisa:(Visa *)visa inContext:(NSManagedObjectContext *)context
{
    
    //Get all dayVithVisa
    
    NSFetchRequest *request =[NSFetchRequest fetchRequestWithEntityName:@"DayWithVisa"];
    request.predicate=[NSPredicate predicateWithFormat:@"inVisa == %@", visa];
    
    NSError *error;
    NSArray *daysWithVisa=[context executeFetchRequest:request error:&error];
    
    for (DayWithVisa *dayWithVisa in daysWithVisa)
    {
        [context deleteObject:dayWithVisa];
    }

}

@end
