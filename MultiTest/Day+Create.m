//
//  Day+Create.m
//  MultiTest
//
//  Created by Administrator on 10.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "Day+Create.h"
#import "NSDate+Project.h"
#import "Week+Create.h"

@implementation Day (Create)

+(NSDate *) minDayDateinContext: (NSManagedObjectContext *) context
{
    NSDate *minDayDate = nil;
    
    NSFetchRequest *requestDict=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
    [requestDict setResultType:NSDictionaryResultType];
    NSExpression *keyPathExpression=[NSExpression expressionForKeyPath:@"date"];
    NSExpression *minExpression=[NSExpression expressionForFunction:@"min:" arguments:[NSArray arrayWithObject:keyPathExpression]];
    NSExpressionDescription *expressionnDescription=[[NSExpressionDescription alloc]init];
    [expressionnDescription setName:@"minDate"];
    [expressionnDescription setExpression:minExpression];
    [expressionnDescription setExpressionResultType:NSDateAttributeType];
    [requestDict setPropertiesToFetch:[NSArray arrayWithObject:expressionnDescription]];
    
    NSError *error;
    NSArray *matches=[context executeFetchRequest:requestDict error:&error];
    
    
    
    if (!matches) {
        //error
    }else if ([matches count]>0){
        minDayDate=(NSDate *)[[matches objectAtIndex:0] valueForKey:@"minDate"];
    }
    
    return minDayDate;
}
+(NSDate *) maxDayDateinContext: (NSManagedObjectContext *) context
{
    NSDate *maxDayDate = nil;
    
    
    NSFetchRequest *requestDict=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
    [requestDict setResultType:NSDictionaryResultType];
    NSExpression *keyPathExpression=[NSExpression expressionForKeyPath:@"date"];
    NSExpression *minExpression=[NSExpression expressionForFunction:@"max:" arguments:[NSArray arrayWithObject:keyPathExpression]];
    NSExpressionDescription *expressionnDescription=[[NSExpressionDescription alloc]init];
    [expressionnDescription setName:@"maxDate"];
    [expressionnDescription setExpression:minExpression];
    [expressionnDescription setExpressionResultType:NSDateAttributeType];
    [requestDict setPropertiesToFetch:[NSArray arrayWithObject:expressionnDescription]];
    
    NSError *error;
    NSArray *matches=[context executeFetchRequest:requestDict error:&error];
    
    
    
    if (!matches) {
        //error
    }else if ([matches count]>0){
        maxDayDate=(NSDate *)[[matches objectAtIndex:0] valueForKey:@"maxDate"];
    }
    
    
    return maxDayDate;
}

+(Day *)minDayinContext: (NSManagedObjectContext *) context  //UNDERCONTRUCTION: Please get from minDayDateinContext:
{
    Day *minDay = nil;
    

    
//    NSFetchRequest *request2=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
//    
//    
//    request2.predicate=[NSPredicate predicateWithFormat:@"date==min(date)"];
//    NSError *error;
//    NSArray *match2=[context executeFetchRequest:request2 error:&error];
//    if ([match2 count]>0) {
//        if ([[match2 firstObject] isKindOfClass:[Day class]]) {
//            minDay=[match2 firstObject];
//        }
//    }
    
    
   return minDay;
}
+(Day *)maxDayinContext: (NSManagedObjectContext *) context  //UNDERCONTRUCTION: Please get from maxDayDateinContext:
{
    Day *maxDay = nil;
    
//    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
//    //request.predicate=[NSPredicate predicateWithFormat:@"from2001==from2001.@max"];
//    request.predicate=[NSPredicate predicateWithFormat:@"date==max(date)"];
//    NSError *error;
//    NSArray *match=[context executeFetchRequest:request error:&error];
//    if ([match count]>0) {
//        if ([[match firstObject] isKindOfClass:[Day class]]) {
//            maxDay=[match firstObject];
//        }
//    }
    return maxDay;
}

+(void) addFromDate:(NSDate *)startDate toDate:(NSDate *)endDate inContext:(NSManagedObjectContext *)context
{
    NSDate *startWeekDate=startDate;
    NSDate *endWeekDate=endDate;
    NSInteger needStartDays=0;
    NSInteger needEndDays=0;
    NSInteger startWeekNumber=[startDate weeksFrom2001];
    NSInteger endWeekNumber=[endDate weeksFrom2001];
    
    needStartDays=[startDate daysFrom2001]%7;
    startWeekDate=[NSDate dateWithTimeInterval:(-60*60*24*needStartDays) sinceDate:startDate];
    
    if (0 != ([endDate daysFrom2001]+1)%7) needEndDays=7-([endDate daysFrom2001]+1)%7;
    endWeekDate=[NSDate dateWithTimeInterval:(60*60*24*needEndDays) sinceDate:endDate];
    
    int k=0;
    for (NSInteger i=startWeekNumber ; i<=endWeekNumber; i++, k++) {
        //NSLog(@"%@---%ld-------%ld---------Creating week for %@",startDate,(long)needStartDays, (long)needEndDays, [NSDate dateWithTimeInterval:(k*7*24*60*60) sinceDate:startWeekDate]);
        [Week insertWeekNumber:i WithMonday:[NSDate dateWithTimeInterval:(k*7*24*60*60) sinceDate:startWeekDate] inContext:context];
        
    }
    
    
}

+(void)insertDaysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate inContext:(NSManagedObjectContext *)context
{
    startDate=[NSDate dateTo12h00EUfromDate:startDate];
    endDate=[NSDate dateTo12h00EUfromDate:endDate];
    
    if (NSOrderedDescending==[startDate compare:endDate]) {
        NSDate *temp=startDate;
        startDate=endDate;
        endDate=temp;
    }
    
    //Add addition time
    
    startDate=[NSDate dateWithTimeInterval:-180*24*60*60 sinceDate:startDate];
    endDate=[NSDate dateWithTimeInterval:180*24*60*60 sinceDate:endDate];

    //Day *minDay = [self minDayinContext:context];
    //Day *maxDay = [self maxDayinContext:context];
    NSDate *minDayDate = [self minDayDateinContext:context];
    NSDate *maxDayDate = [self maxDayDateinContext:context];
    
    //NSLog(@"!!!!!!! MAX MIN !!!!!!!!!: %@   %@", maxDayDate, minDayDate);
    
    if (maxDayDate && minDayDate){
        if (NSOrderedAscending==[startDate compare:minDayDate]) {
            if (NSOrderedAscending==[endDate compare:minDayDate]) {
                [self addFromDate:startDate toDate:endDate inContext:context];
            }else if ((NSOrderedAscending==[endDate compare:maxDayDate]) || NSOrderedSame==[endDate compare:maxDayDate]) {
                [self addFromDate:startDate toDate:[NSDate dateWithTimeInterval:-24*60*60 sinceDate:minDayDate] inContext:context];
            }else{
                [self addFromDate:startDate toDate:[NSDate dateWithTimeInterval:-24*60*60 sinceDate:minDayDate] inContext:context];
                [self addFromDate:[NSDate dateWithTimeInterval:24*60*60 sinceDate:maxDayDate] toDate:endDate inContext:context];
            }
        } else if (NSOrderedAscending==[startDate compare:maxDayDate]){
            if ((NSOrderedAscending==[endDate compare:maxDayDate]) || (NSOrderedSame==[endDate compare:maxDayDate])){
                 //do nothing
            }else{
                [self addFromDate:[NSDate dateWithTimeInterval:24*60*60 sinceDate:maxDayDate] toDate:endDate inContext:context];
            }
        } else {
            [self addFromDate:startDate toDate:endDate inContext:context];
        }
    }else{
        [self addFromDate:startDate toDate:endDate inContext:context];
    }
    
    //old version
    {
//        NSLog(@"!!!!!!! MAX MIN !!!!!!!!!: %@   %@", maxDay.date, minDay.date);
//        
//        if (maxDay && minDay){
//            if (NSOrderedAscending==[startDate compare:minDay.date]) {
//                if (NSOrderedAscending==[endDate compare:minDay.date]) {
//                    [self addFromDate:startDate toDate:endDate inContext:context];
//                }else if ((NSOrderedAscending==[endDate compare:maxDay.date]) || NSOrderedSame==[endDate compare:maxDay.date]) {
//                    [self addFromDate:startDate toDate:[NSDate dateWithTimeInterval:-24*60*60 sinceDate:minDay.date] inContext:context];
//                }else{
//                    [self addFromDate:startDate toDate:[NSDate dateWithTimeInterval:-24*60*60 sinceDate:minDay.date] inContext:context];
//                    [self addFromDate:[NSDate dateWithTimeInterval:24*60*60 sinceDate:maxDay.date] toDate:endDate inContext:context];
//                }
//            } else if (NSOrderedAscending==[startDate compare:maxDay.date]){
//                if ((NSOrderedAscending==[endDate compare:maxDay.date]) || (NSOrderedSame==[endDate compare:maxDay.date])){
//                    //do nothing
//                }else{
//                    [self addFromDate:[NSDate dateWithTimeInterval:24*60*60 sinceDate:maxDay.date] toDate:endDate inContext:context];
//                }
//            } else {
//                [self addFromDate:startDate toDate:endDate inContext:context];
//            }
//        }else{
//            [self addFromDate:startDate toDate:endDate inContext:context];
//        }

    }
    
    
}

+(Day *)dayTodayinContext:(NSManagedObjectContext *)context
{
    Day *day=nil;
    
    NSDate *convertDate=[[NSDate date] dateByAddingTimeInterval:[[NSTimeZone localTimeZone] secondsFromGMT]];
    NSDate *today=[NSDate dateTo12h00EUfromDate:convertDate];
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
    request.predicate=[NSPredicate predicateWithFormat:@"from2001 == %@", [NSNumber numberWithInteger:[today daysFrom2001]]];
    NSError *error;
    NSArray *match=[context executeFetchRequest:request error:&error];
    if ([match count]>0) {
        if ([[match firstObject]isKindOfClass:[Day class]]) {
            day=[match firstObject];
        }
    }
    return day;
}

-(NSInteger)numberOfTripDaysByLast:(NSInteger)numberOfDays
{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
    request.predicate=[NSPredicate predicateWithFormat:@"(from2001 >= %@) AND (from2001 <= %@) AND (tripsByDay.@count!=0)",
                       [NSNumber numberWithInteger:([self.from2001 integerValue] - numberOfDays)],
                       self.from2001];
    //request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001" ascending:YES selector:@selector(compare:)]];
    NSError *error;
    NSArray *mathes=[self.managedObjectContext executeFetchRequest:request error:&error];
    if ([mathes count]) {
        return [mathes count];
    } else return 0;

}

-(NSInteger) numberOfTripDaysCanUseFromNow
{
    NSInteger value=0;
    if ([self.last180TripDays integerValue] > 90) {
        value= 0;
        //value= 90 - [self.last180TripDays integerValue];
    }else{
        value= 90 - [self.last180TripDays integerValue];
        
        
        NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
        request.predicate=[NSPredicate predicateWithFormat:@"(from2001 >= %@) AND (from2001 <= %@)",
                           self.from2001,
                           [NSNumber numberWithInteger:([self.from2001 integerValue]+90)]
                           ];
        request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001" ascending:YES selector:@selector(compare:)]];
        NSError *error;
        NSArray *mathes=[self.managedObjectContext executeFetchRequest:request error:&error];
        if ([mathes count]) {
            
            NSInteger maxIndex=0;
            NSInteger usedTrips=0;
            NSInteger kTrip=0;
            if ([self.tripsByDay count]) {
                usedTrips=1;
                kTrip=-2;
            }
            
            for (NSInteger myId=0; myId<[mathes count]; myId++) {
                if([((Day *)[mathes objectAtIndex:myId]).tripsByDay count]){
                    usedTrips++;
                }
                if (([((Day *)[mathes objectAtIndex:myId]).last180TripDays integerValue] + myId -usedTrips) < 90) {
                    //NSLog(@"myID=%ld last180TripDays(%@) value<90(%ld) usedTrips(%ld) - %lu",(long)myId,((Day *)[mathes objectAtIndex:myId]).last180TripDays,[((Day *)[mathes objectAtIndex:myId]).last180TripDays integerValue] + myId  - usedTrips, (long)usedTrips, (unsigned long)[mathes count]);
                    maxIndex=myId+1+kTrip;
                }else{
                    myId=1000;
                }
            }
            
            value=maxIndex;
            
        }
    }
    return value;
}


-(NSDate *)dateOfLegalTripWithIntegerDays:(NSInteger)tripDays
{
    NSDate *resultDate=[self.date dateByAddingTimeInterval:180*24*60*60];
    
    NSInteger maxX=90;
   
    NSInteger freeDays=(90-[self.last180TripDays integerValue]);
    
    if (freeDays>=tripDays){
        return self.date;
    }else{
        
        NSInteger maxFrom2001=[[Day maxDayDateinContext:self.managedObjectContext] daysFrom2001];
        NSInteger repeat = (maxFrom2001-[self.from2001 integerValue])/180 + 1;
        for (int i=0; i<repeat; i++) { //first 2 years
            NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
            request.predicate=[NSPredicate predicateWithFormat:@"(from2001 >= %@) AND (from2001 < %@)",
                                [NSNumber numberWithInteger:([self.from2001 integerValue] + i*180)],
                                [NSNumber numberWithInteger:([self.from2001 integerValue] + 180 +i*180)]];
            request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001" ascending:YES selector:@selector(compare:)]];
            NSError *error;
            NSArray *mathes=[self.managedObjectContext executeFetchRequest:request error:&error];
            
            if ([mathes count]) {
                if ([[mathes firstObject] isKindOfClass:[Day class]]) {
                    for (int y=0; y<[mathes count]; y++) {
                        Day *lookingDay=(Day *)[mathes objectAtIndex:y];     //Take next day for research
                        
                        NSFetchRequest *request2=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
                        request2.predicate=[NSPredicate predicateWithFormat:@"(from2001 >= %@) AND (from2001 < %@)",
                                           lookingDay.from2001,
                                           [NSNumber numberWithInteger:([lookingDay.from2001 integerValue] + tripDays)]];
                        request2.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001" ascending:YES selector:@selector(compare:)]];
                        NSError *error2;
                        NSArray *mathes2=[self.managedObjectContext executeFetchRequest:request2 error:&error2]; //array to test if its can be nessecary day
                        
                        NSInteger okTrip=1; //future add for last180
                        NSInteger myIndex=0; //counter
                        


                        for (int z=0; z<[mathes2 count]; z++) {
                          
                            //NSLog(@"%@",((Day *)[mathes2 objectAtIndex:z]).date);
                            
                            if (![((Day *)[mathes2 objectAtIndex:z]).tripsByDay count]) {  //its not a trip day
                                //NSLog(@"NOT a trip day: %d",[((Day *)[mathes2 objectAtIndex:z]).last180TripDays integerValue] + okTrip);

                                if (([((Day *)[mathes2 objectAtIndex:z]).last180TripDays integerValue] + okTrip ) > maxX) {
                                    z=1000;
                                    myIndex=1000;
                                }else{
                                    okTrip++;
                                }
                                
                            }else { //its a trip day
                               //NSLog(@"a trip day: %d",[((Day *)[mathes2 objectAtIndex:z]).last180TripDays integerValue] );
                                if ([((Day *)[mathes2 objectAtIndex:z]).last180TripDays integerValue] + okTrip -1  > maxX) {
                                    z=1000;
                                    myIndex=1000;
                                }
                            }
                            myIndex++;
                        }
                        
                        
                        if (myIndex == tripDays) {
                            return lookingDay.date;
                        }
                        
                    }
                }
            }
        }
        
        resultDate=[Day maxDayDateinContext:self.managedObjectContext];
        
        
        
            
    }
    
    return resultDate;
}

-(NSDate *)dateOfLegalTripWithIntegerDaysVersion3:(NSInteger)tripDays
{
    NSDate *resultDate=[self.date dateByAddingTimeInterval:180*24*60*60];
    
    
    NSInteger freeDays=(90-[self.last180TripDays integerValue]);
    
    if (freeDays>=tripDays){
        return self.date;
    }else{
        
        NSInteger maxFrom2001=[[Day maxDayDateinContext:self.managedObjectContext] daysFrom2001];
        NSInteger repeat = (maxFrom2001-[self.from2001 integerValue])/180 + 1;
        for (int i=0; i<repeat; i++) { //first 2 years
            NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
            request.predicate=[NSPredicate predicateWithFormat:@"(from2001 >= %@) AND (from2001 < %@)",
                               [NSNumber numberWithInteger:([self.from2001 integerValue] + i*180)],
                               [NSNumber numberWithInteger:([self.from2001 integerValue] + 180 +i*180)]];
            request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001" ascending:YES selector:@selector(compare:)]];
            NSError *error;
            NSArray *mathes=[self.managedObjectContext executeFetchRequest:request error:&error];
            
            if ([mathes count]) {
                if ([[mathes firstObject] isKindOfClass:[Day class]]) {
                    for (int y=0; y<[mathes count]; y++) {
                        Day *lookingDay=(Day *)[mathes objectAtIndex:y];     //Take next day for research
                        
                        NSFetchRequest *request2=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
                        request2.predicate=[NSPredicate predicateWithFormat:@"(from2001 >= %@) AND (from2001 <= %@)",
                                            lookingDay.from2001,
                                            [NSNumber numberWithInteger:([lookingDay.from2001 integerValue] + tripDays)]];
                        request2.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001" ascending:YES selector:@selector(compare:)]];
                        NSError *error2;
                        NSArray *mathes2=[self.managedObjectContext executeFetchRequest:request2 error:&error2]; //array to test if its can be nessecary day
                        
                        NSInteger okDays=0;
                        NSInteger z=0;
                        
                        
                        
                        for ( z=0; z<[mathes2 count]; z++) {
                            
                            
                            
                            if (![((Day *)[mathes2 objectAtIndex:z]).tripsByDay count]) {  //its not a trip day
                                
                                if (0==z) {
                                    okDays=1;
                                }
                                if (([((Day *)[mathes2 objectAtIndex:z]).last180TripDays integerValue] + okDays ) >90) {
                                    z=1000;
                                }
                                if (0==z) {
                                    okDays=0;
                                }
                                okDays++;
                                
                                
                            }else { //its a trip day
                                if ([((Day *)[mathes2 objectAtIndex:z]).last180TripDays integerValue]  >90) {
                                    z=1000;
                                }
                            }
                        }
                        
                        
                        if ((z) == [mathes2 count]) {
                            return lookingDay.date;
                        }
                        
                    }
                }
            }
        }
        
        resultDate=[Day maxDayDateinContext:self.managedObjectContext];
        
        
        
        
    }
    
    return resultDate;
}

-(NSDate *)dateOfLegalTripWithIntegerDaysVersion2:(NSInteger)tripDays //old version
{
    NSDate *resultDate=[self.date dateByAddingTimeInterval:180*24*60*60];
    
    //NSInteger dayIndex=0;
    NSInteger freeDays=(90-[self.last180TripDays integerValue]);
    
    if (freeDays>=tripDays){
        return self.date;
    }else{
        NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
        request.predicate=[NSPredicate predicateWithFormat:@"(from2001 >= %@) AND (from2001 <= %@) AND (last180TripDays <= %@)",
                           [NSNumber numberWithInteger:([self.from2001 integerValue])],
                           [NSNumber numberWithInteger:([self.from2001 integerValue]+tripDays+180)],
                           [NSNumber numberWithInteger:(90-tripDays)]
                           ];
        request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001" ascending:YES selector:@selector(compare:)]];
        NSError *error;
        NSArray *mathes=[self.managedObjectContext executeFetchRequest:request error:&error];
        if ([mathes count]) {
            if ([[mathes firstObject] isKindOfClass:[Day class]]) {
                return ((Day *)[mathes firstObject]).date;
            }
            
        }else{ //fetch for full database
            NSFetchRequest *request2=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
            request2.predicate=[NSPredicate predicateWithFormat:@"(from2001 >= %@) AND (last180TripDays <= %@)",
                                [NSNumber numberWithInteger:([self.from2001 integerValue]+tripDays+180)],
                                [NSNumber numberWithInteger:(90-tripDays)]
                                ];
            request2.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001" ascending:YES selector:@selector(compare:)]];
            NSError *error2;
            NSArray *mathes2=[self.managedObjectContext executeFetchRequest:request error:&error2];
            if ([mathes2 count]) {
                if ([[mathes2 firstObject] isKindOfClass:[Day class]]) {
                    return ((Day *)[mathes2 firstObject]).date;
                }
            }
            
        }
    }
    
    return resultDate;
}

-(NSDate *)dateOfLegalTripWithIntegerDaysVersion1:(NSInteger)tripDays //old version
{
    NSDate *resultDate=[self.date dateByAddingTimeInterval:180*24*60*60];
    
    //NSInteger startDayNumberFrom2001=([self.from2001 integerValue] - 180);
    //NSInteger endDayNumberFrom2001=[self.from2001 integerValue];
    NSInteger dayIndex=0;
    NSInteger freeDays=(90-[self numberOfTripDaysByLast:180]);
    
    if (freeDays>=tripDays){
        return self.date;
    }else{
        dayIndex += tripDays - freeDays;
        while (dayIndex<180) {
            
            freeDays=(90-[self numberOfTripDaysByLast:(180-dayIndex)]);
            if (freeDays>=tripDays) {
                
                resultDate=[self.date dateByAddingTimeInterval:dayIndex*24*60*60];
                return resultDate;
            }
            dayIndex += tripDays - freeDays;
        }
    }
    
    return resultDate;
}

+(Day *)dayFromNumberFrom2001:(NSNumber *)numberFrom2001 inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
    request.predicate=[NSPredicate predicateWithFormat:@"from2001 == %@",numberFrom2001];
    NSError *error;
    NSArray *mathes=[context executeFetchRequest:request error:&error];
    
    if ([mathes count]) {
        return [mathes firstObject];
    }else return nil;

}

@end
