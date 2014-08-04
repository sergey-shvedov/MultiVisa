//
//  Week+Create.m
//  MultiTest
//
//  Created by Administrator on 10.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "Week+Create.h"
#import "NSDate+Project.h"
#import "Day+Create.h"

@implementation Week (Create)
+(Week *) minWeekinContext: (NSManagedObjectContext *) context
{
    Week *minWeek = nil;
    NSFetchRequest *request2=[NSFetchRequest fetchRequestWithEntityName:@"Week"];
    request2.predicate=[NSPredicate predicateWithFormat:@"from2001==min(from2001)"];
    NSError *error;
    NSArray *match2=[context executeFetchRequest:request2 error:&error];
    if ([match2 count]>0) {
        if ([[match2 firstObject] isKindOfClass:[Week class]]) {
            minWeek=[match2 firstObject];
        }
    }
    return minWeek;
}
+(Week *) maxWeekinContext: (NSManagedObjectContext *) context
{
    Week *maxWeek = nil;
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Week"];
    request.predicate=[NSPredicate predicateWithFormat:@"from2001==max(from2001)"];
    NSError *error;
    NSArray *match=[context executeFetchRequest:request error:&error];
    if ([match count]>0) {
        if ([[match firstObject] isKindOfClass:[Week class]]) {
            maxWeek=[match firstObject];
        }
    }
    return maxWeek;
}
+(void)insertWeekNumber:(NSInteger)number WithMonday:(NSDate *)date inContext:(NSManagedObjectContext *)context
{
    NSCalendar *gregorian=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [gregorian setFirstWeekday:2];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth;
    NSDateComponents *comp =[gregorian components:unitFlags fromDate:date];
    NSDateComponents *compEndWeek =[gregorian components:unitFlags fromDate:[NSDate dateWithTimeInterval:6*24*60*60 sinceDate:date]];
    
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Week"];
    request.predicate=[NSPredicate predicateWithFormat:@"from2001 == %@",[NSNumber numberWithInteger:number]];
    NSError *error;
    NSArray *match=[context executeFetchRequest:request error:&error];
    if (!match || [match count]>0) {
          //error
    }else
    {
        Week *week=[NSEntityDescription insertNewObjectForEntityForName:@"Week" inManagedObjectContext:context];
        week.from2001=[NSNumber numberWithInteger:number];
        week.mainMonth=[NSNumber numberWithInteger:[comp month]];
        week.numberFromMonthBeginner=[NSNumber numberWithInteger:[compEndWeek weekOfMonth]];
        for (int i=0; i<7; i++) {
            NSDate *iDate=[NSDate dateWithTimeInterval:i*(24*60*60) sinceDate:date];
            
            NSFetchRequest *request2=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
            request2.predicate=[NSPredicate predicateWithFormat:@"from2001 == %@",[NSNumber numberWithInteger:[iDate daysFrom2001]]];
            NSError *error;
            NSArray *match2=[context executeFetchRequest:request2 error:&error];
            if (!match2 || [match2 count]>0) {
                //error
            }else{
                Day *day=[NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:context];
                NSDateComponents *components =[gregorian components:unitFlags fromDate:iDate];
                day.date=iDate;
                day.year=[NSNumber numberWithInteger:[components year]];
                day.month=[NSNumber numberWithInteger:[components month]];
                day.day=[NSNumber numberWithInteger:[components day]];
                day.weekDay=[NSNumber numberWithInteger:[components weekday]];
                day.from2001=[NSNumber numberWithInteger:[iDate daysFrom2001]];
                day.inWeek=week;
                //NSLog(@"Day Added:%@",day);
            }
            
        }
        //NSLog(@"Week:%@",week);
    }

}
@end
