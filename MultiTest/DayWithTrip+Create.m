//
//  DayWithTrip+Create.m
//  MultiTest
//
//  Created by Administrator on 12.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "DayWithTrip+Create.h"
#import "Day+Create.h"
#import "NSDate+Project.h"
#import "Trip.h"
#import "PassportSavedNotification.h"

@implementation DayWithTrip (Create)
+(void)updateDaysFromDate:(NSDate *)entryDate toDate:(NSDate *)outDate withTrip:(Trip *)trip inContext:(NSManagedObjectContext *)context
{
    
    //setup all days
    
    [Day insertDaysFromDate:entryDate toDate:outDate inContext:context];
    
    //Get all days
    
    NSFetchRequest *request =[NSFetchRequest fetchRequestWithEntityName:@"Day"];
    request.predicate=[NSPredicate predicateWithFormat:@"from2001>=%@ && from2001<=%@",[NSNumber numberWithInteger:[entryDate daysFrom2001]],[NSNumber numberWithInteger:[outDate daysFrom2001]]];
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001"ascending:YES selector:@selector(compare:)]];
    NSError *error;
    NSArray *days=[context executeFetchRequest:request error:&error];
    
    //Set this trip for all days
    for (Day *day in days)
    {
        DayWithTrip *dayWithTrip =[NSEntityDescription insertNewObjectForEntityForName:@"DayWithTrip" inManagedObjectContext:context];
        dayWithTrip.usedDay=day;
        dayWithTrip.inTrip=trip;
        
        
        if ([[days firstObject] isEqual:day]) {
            dayWithTrip.isEntry=@1;
            //NSLog(@"IsEntry: %@",day);
        }else dayWithTrip.isEntry=@0;
        if ([[days lastObject] isEqual:day]) {
            dayWithTrip.isOut=@1;
            //NSLog(@"IsExperation: %@",day);
        }else dayWithTrip.isOut=@0;
        
        
        
    }
    ///////////////////////////////////////////////// Send Notification
    NSError *error2;
    [context save:&error2];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TripNeedUpdateTodayCalendarView object:nil];
    
    ///////////////////////////////////////////////////// 90/180 RULE
    
    for (Day *day in days)
    {
        
        //90/180 rule
        
        NSFetchRequest *request2 =[NSFetchRequest fetchRequestWithEntityName:@"Day"];
        request2.predicate=[NSPredicate predicateWithFormat:@"from2001>=%@ && from2001<%@", day.from2001, [NSNumber numberWithInteger:([day.from2001 integerValue]+180)]];
        request2.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001"ascending:YES selector:@selector(compare:)]];
        NSError *error2;
        NSArray *last180days=[context executeFetchRequest:request2 error:&error2];
        for (Day *lastDay in last180days)
        {
            lastDay.last180TripDays=[NSNumber numberWithInteger:([lastDay.last180TripDays integerValue] + 1)];
        }
        
    }
    
}

+(void)resettingDaysWithTrip:(Trip *)trip inContext:(NSManagedObjectContext *)context withOldIssueDate:(NSDate *)oldIssueDate andOldExperationDate:(NSDate *)oldExperationDate
{
    //Setup all days
    
    [Day insertDaysFromDate:trip.entryDate toDate:trip.outDate inContext:context];
    
    //Get DayWithTrip to delete
    
    NSFetchRequest *request =[NSFetchRequest fetchRequestWithEntityName:@"DayWithTrip"];
    request.predicate=[NSPredicate predicateWithFormat:@"inTrip = %@ && (usedDay.from2001<%@ || usedDay.from2001>%@)",trip ,[NSNumber numberWithInteger:[trip.entryDate daysFrom2001]],[NSNumber numberWithInteger:[trip.outDate daysFrom2001]]];
    
    NSError *error;
    NSArray *daysWithTripToDelete=[context executeFetchRequest:request error:&error];
    //NSLog(@"daysWithTripToDelete: %lu",(unsigned long)[daysWithTripToDelete count]);
    
    //deletion
    NSMutableArray *daysToMinus=[[NSMutableArray alloc]init];
    
    for (DayWithTrip *dayWithTrip in daysWithTripToDelete)
    {
        Day *day=dayWithTrip.usedDay;
        
        [daysToMinus addObject:day];
        //90/180 rule
        
        
        [context deleteObject:dayWithTrip];
    }
    
    //Get days to craete new DayWithTrip
    
    NSFetchRequest *requestD =[NSFetchRequest fetchRequestWithEntityName:@"Day"];
    requestD.predicate=[NSPredicate predicateWithFormat:@"from2001>=%@ && from2001<=%@",[NSNumber numberWithInteger:[trip.entryDate daysFrom2001]],[NSNumber numberWithInteger:[trip.outDate daysFrom2001]]];
    requestD.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001"ascending:YES selector:@selector(compare:)]];
    NSError *errorD;
    NSArray *days=[context executeFetchRequest:requestD error:&errorD];
    //NSLog(@"Get days to craete new DayWithTrip: %lu",(unsigned long)[days count]);
    
    NSInteger createOfDWT=0;
    NSMutableArray *daysToPlus=[[NSMutableArray alloc]init];
    for (Day *day in days)
    {
        NSInteger countOfDWT=0;
        
        for (DayWithTrip *dayWithTrip in day.tripsByDay){
            if ([dayWithTrip.inTrip isEqual:trip]) {
                countOfDWT++;
                //NSLog(@"dayWithTrip Allready exist %d objects", countOfDWT);
                dayWithTrip.isEntry=@0;
                dayWithTrip.isOut=@0;
            }
        }
        
        if (0 == countOfDWT) { //create new one
            createOfDWT++;
            DayWithTrip *dayWithTrip =[NSEntityDescription insertNewObjectForEntityForName:@"DayWithTrip" inManagedObjectContext:context];
            dayWithTrip.usedDay=day;
            dayWithTrip.inTrip=trip;
            dayWithTrip.isEntry=@0;
            dayWithTrip.isOut=@0;
            //NSLog(@"create new dayWithTrip # %d", countOfDWT);
            
            //90/180 rule
            
            [daysToPlus addObject:day];
            
            
        }
    }
    
    ///////////////////////////////////////////////// Send Notification
    NSError *error2;
    [context save:&error2];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TripNeedUpdateTodayCalendarView object:nil];
    
    /////////////////////////////////////////////////  90/180 RULE
    
    for (Day *day in daysToMinus)
    {
        NSFetchRequest *request2 =[NSFetchRequest fetchRequestWithEntityName:@"Day"];
        request2.predicate=[NSPredicate predicateWithFormat:@"from2001>=%@ && from2001<%@",day.from2001, [NSNumber numberWithInteger:([day.from2001 integerValue]+180)]];
        request2.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001"ascending:YES selector:@selector(compare:)]];
        NSError *error2;
        NSArray *last180days=[context executeFetchRequest:request2 error:&error2];
        for (Day *lastDay in last180days)
        {
            lastDay.last180TripDays=[NSNumber numberWithInteger:([lastDay.last180TripDays integerValue] - 1)];
        }

    }
    
    for (Day *day in daysToPlus)
    {
        NSFetchRequest *request2 =[NSFetchRequest fetchRequestWithEntityName:@"Day"];
        request2.predicate=[NSPredicate predicateWithFormat:@"from2001>=%@ && from2001<%@", day.from2001, [NSNumber numberWithInteger:([day.from2001 integerValue]+180)]];
        request2.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001"ascending:YES selector:@selector(compare:)]];
        NSError *error2;
        NSArray *last180days=[context executeFetchRequest:request2 error:&error2];
        for (Day *lastDay in last180days)
        {
            lastDay.last180TripDays=[NSNumber numberWithInteger:([lastDay.last180TripDays integerValue] + 1)];
        }

    }
    
    
    
    NSFetchRequest *requestD2 =[NSFetchRequest fetchRequestWithEntityName:@"DayWithTrip"];
    requestD2.predicate=[NSPredicate predicateWithFormat:@"(usedDay.from2001==%@ || usedDay.from2001==%@) && inTrip == %@",[NSNumber numberWithInteger:[trip.entryDate daysFrom2001]],[NSNumber numberWithInteger:[trip.outDate daysFrom2001]], trip];
    requestD2.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"usedDay.from2001"ascending:YES selector:@selector(compare:)]];
    NSError *errorD2;
    NSArray *daysWV2=[context executeFetchRequest:requestD2 error:&errorD2];
    //NSLog(@"Set DayWithTrip to reset properties: %lu",(unsigned long)[daysWV2 count]);
    if ([daysWV2 count]) {
        ((DayWithTrip *)[daysWV2 firstObject]).isEntry=@1;
        ((DayWithTrip *)[daysWV2 lastObject]).isOut=@1;
    }
}




@end
