//
//  NSDate+Project.m
//  MultiTest
//
//  Created by Administrator on 06.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "NSDate+Project.h"

@implementation NSDate (Project)
+(NSDate *) dateTo12h00EUfromDate:(NSDate *)currentDate
{
    if (!currentDate) {
        currentDate=[NSDate date];
    }
    //[currentDate timeIntervalSinceReferenceDate];
    NSCalendar *gregorian=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    NSDate *newDate;
    [gregorian rangeOfUnit:NSDayCalendarUnit startDate:&newDate interval:NULL forDate:currentDate];
    newDate=[newDate dateByAddingTimeInterval:12*60*60];
    return newDate;
}
+(NSDate *)dayToday
{
    NSDate *convertDate=[[NSDate date] dateByAddingTimeInterval:[[NSTimeZone localTimeZone] secondsFromGMT]];
    NSDate *today=[NSDate dateTo12h00EUfromDate:convertDate];
    return today;
}

+(NSInteger) daysFromDate: (NSDate *) date1 toDate: (NSDate *) date2
{
    NSCalendar *gregorian=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    NSDateComponents *difference = [gregorian components:NSDayCalendarUnit fromDate:[NSDate dateTo12h00EUfromDate: date1] toDate:[NSDate dateTo12h00EUfromDate: date2] options:0];
    
    return ([difference day]+1);
}
-(NSInteger)daysFrom2001
{
    return (int)[self timeIntervalSinceReferenceDate]/(int)(60*60*24);
}
-(NSInteger)weeksFrom2001
{
    return (int)[self timeIntervalSinceReferenceDate]/(int)(60*60*24*7);
}
@end
