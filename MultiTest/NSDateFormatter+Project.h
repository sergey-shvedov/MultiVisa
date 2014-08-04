//
//  NSDateFormatter+Project.h
//  MultiTest
//
//  Created by Administrator on 06.07.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Project)
+ (NSString *)multiVisaLocalizedStringFromDate:(NSDate *)date dateStyle:(NSDateFormatterStyle)dstyle timeStyle:(NSDateFormatterStyle)tstyle;
+ (NSDateFormatter *)multiVisaDateFormatter;
@end
