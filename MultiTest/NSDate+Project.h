//
//  NSDate+Project.h
//  MultiTest
//
//  Created by Administrator on 06.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Project)

+(NSDate *) dateTo12h00EUfromDate:(NSDate *)currentDate;
+(NSDate *) dayToday;
+(NSInteger) daysFromDate: (NSDate *) date1 toDate: (NSDate *) date2;
-(NSInteger) daysFrom2001;
-(NSInteger) weeksFrom2001;
//+(NSString *) monthOfIndex;
@end
