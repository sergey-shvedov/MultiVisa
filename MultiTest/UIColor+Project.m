//
//  UIColor+Project.m
//  MultiTest
//
//  Created by Administrator on 30.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "UIColor+Project.h"

@implementation UIColor (Project)
+(UIColor *)colorNeedEdit
{
    return [UIColor colorWithRed:218.0/255.0 green:188.0/255.0 blue:70.0/255.0 alpha:1.0];
}
+(UIColor *) colorNotYetEdit
{
    return [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
}
+(UIColor *) colorEdited
{
    return [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
}
////////////////////////////////////////////

+(UIColor *)colorButtonCancelBackground
{
    return [UIColor colorWithRed:255.0/255.0 green:220.0/255.0 blue:225.0/255.0 alpha:1.0];
}
+(UIColor *)colorButtonCancelBackgroundHigligted
{
    return [UIColor colorWithRed:255.0/255.0 green:58.0/255.0 blue:82.0/255.0 alpha:1.0];
}
+(UIColor *)colorButtonCancelText
{
    return [UIColor colorWithRed:227.0/255.0 green:49.0/255.0 blue:68.0/255.0 alpha:1.0];
}
+(UIColor *)colorButtonCancelTextHigligted
{
    return [UIColor whiteColor];
}
//////////////////////////////////////////////

+(UIColor *)colorButtonOkBackground
{
    return [UIColor colorWithRed:185.0/255.0 green:252.0/255.0 blue:207.0/255.0 alpha:1.0];
}
+(UIColor *)colorButtonOkBackgroundHigligted
{
    return [UIColor colorWithRed:20.0/255.0 green:240.0/255.0 blue:94.0/255.0 alpha:1.0];
}
+(UIColor *)colorButtonOkText
{
    return [UIColor colorWithRed:23.0/255.0 green:132.0/255.0 blue:44.0/255.0 alpha:1.0];
}
+(UIColor *)colorButtonOkTextHigligted
{
    return [UIColor whiteColor];
}

////////////////////////////////////////////////

+(UIColor *)colorButtonNeedEditOkBackground
{
    return [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
}
+(UIColor *)colorButtonNeedEditOkBackgroundHigligted
{
    return [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
}
+(UIColor *)colorButtonNeedEditOkText
{
    return [UIColor colorWithRed:178.0/255.0 green:178.0/255.0 blue:178.0/255.0 alpha:1.0];
}
+(UIColor *)colorButtonNeedEditOkTextHigligted
{
    return [UIColor whiteColor];
}

////////////////////////////////////////////////

+(UIColor *) colorTripView
{
     //return [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:0.5];
     return [UIColor colorWithRed:166.0/255.0 green:214.0/255.0 blue:235.0/255.0 alpha:0.5];
}

/////////////////////////////////////////////

+(UIColor *) colorVisaView
{
    return [UIColor colorWithRed:0.0/255.0 green:219.0/255.0 blue:117.0/255.0 alpha:1.0];
}
+(UIColor *) colorVisaViewText
{
    return [UIColor colorWithRed:0.0/255.0 green:178.0/255.0 blue:101.0/255.0 alpha:1.0];
}
+(UIColor *) colorVisaViewAlpha
{
    return [UIColor colorWithRed:0.0/255.0 green:219.0/255.0 blue:117.0/255.0 alpha:0.05];
}



+(UIColor *) colorPassportView
{
    return [UIColor colorWithRed:255.0/255.0 green:98.0/255.0 blue:67.0/255.0 alpha:1.0];
}
+(UIColor *) colorPassportViewText
{
    return [UIColor colorWithRed:234.0/255.0 green:46.0/255.0 blue:27.0/255.0 alpha:1.0];
}
+(UIColor *) colorPassportViewAlpha
{
    return [UIColor colorWithRed:244.0/255.0 green:55.0/255.0 blue:38.0/255.0 alpha:0.05];
}



+(UIColor *) colorTrip
{
    return [UIColor colorWithRed:16.0/255.0 green:213.0/255.0 blue:246.0/255.0 alpha:1.0];
}
+(UIColor *) colorTripText
{
    return [UIColor colorWithRed:0.0/255.0 green:171.0/255.0 blue:211.0/255.0 alpha:1.0];
}
+(UIColor *) colorTripAlpha
{
    return [UIColor colorWithRed:16.0/255.0 green:213.0/255.0 blue:246.0/255.0 alpha:0.05];
}



////////////////////////////////////////////////


+(UIColor *) colorCalendarOldDate
{
    return [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0];
}
+(UIColor *) colorCalendarNewDate
{
    return [UIColor colorWithRed:60.0/255.0 green:180.0/255.0 blue:255.0/255.0 alpha:1.0];
}






/////////////////////////////////////////////////

+(UIColor *) colorLimitUpText
{
        return [UIColor colorWithRed:255.0/255.0 green:60.0/255.0 blue:0.0/255.0 alpha:1.0];
}











/////////////////////////////////////////////////

- (UIImage *) imageFromColor
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
