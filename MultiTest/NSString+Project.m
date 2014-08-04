//
//  NSString+Project.m
//  MultiTest
//
//  Created by Administrator on 06.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "NSString+Project.h"

@implementation NSString (Project)
+(NSString *)stringByRussianFor1:(NSString *)stringFor1 for2to4:(NSString *)stringFor2to4 for5up:(NSString *)stringFor5up withValue:(NSInteger)value
{
    NSString *result =nil;

    if ( value > 100 ) {
        value = value%100;
    }
    if ( value>10 && value<=20) {
        return stringFor5up;
    }
    if ( value > 20) {
        value = value%10;
    }
        if ( 0 == value ) return stringFor5up;
        else if ( 1 == value ) return stringFor1;
        else if ( value>1 && value<5 ) return stringFor2to4;
        else return stringFor5up;
    return result;
}
+(NSString *) stringByVisaType: (NSNumber *) typeNumber
{
    NSString *result =nil;
    NSInteger i=[typeNumber integerValue];
    if (0==i) {
        result=@"Однократная";
    } else if (1==i) {
        result=@"Двухкратная";
    } else if (i>1) {
        result=@"Многократная";
    }
    return result;
}
+(NSString *)stringByPassportType:(NSNumber *)typeNumber
{
    NSString *result =nil;
    NSInteger i=[typeNumber integerValue];
    //NSLog(@"i= %li",(long)i);
    if (0==i) {
        result=@"Обычный";
    }else if (1==i) {
        result=@"Биометрический";
    } else if (i==100) {
        result=@"По-умолчанию";
    }else{
        result=@"Неопределен";
    }
    return result;
}
@end
