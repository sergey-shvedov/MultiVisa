//
//  NSDateFormatter+Project.m
//  MultiTest
//
//  Created by Administrator on 06.07.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "NSDateFormatter+Project.h"

@implementation NSDateFormatter (Project)
+(NSString *)multiVisaLocalizedStringFromDate:(NSDate *)date dateStyle:(NSDateFormatterStyle)dstyle timeStyle:(NSDateFormatterStyle)tstyle
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:dstyle];
    [dateFormatter setTimeStyle:tstyle];
    [dateFormatter setCalendar:[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar]];
    [dateFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"ru_RU"]];
    return [dateFormatter stringFromDate:date];
}
+(NSDateFormatter *)multiVisaDateFormatter
{
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    [df setCalendar:[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar]];
    [df setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"ru_RU"]];
    return df;
}
@end
