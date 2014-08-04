//
//  NSString+Project.h
//  MultiTest
//
//  Created by Administrator on 06.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Project)
+(NSString *) stringByRussianFor1: (NSString *) stringFor1 for2to4: (NSString *) stringFor2to4 for5up: (NSString *) stringFor5up withValue: (NSInteger) value;
+(NSString *) stringByVisaType: (NSNumber *) typeNumber;
+(NSString *) stringByPassportType: (NSNumber *) typeNumber;
@end
