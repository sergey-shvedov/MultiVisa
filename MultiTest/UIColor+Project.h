//
//  UIColor+Project.h
//  MultiTest
//
//  Created by Administrator on 30.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Project)
+(UIColor *) colorNeedEdit;
+(UIColor *) colorNotYetEdit;
+(UIColor *) colorEdited;

+(UIColor *) colorButtonCancelBackground;
+(UIColor *) colorButtonCancelBackgroundHigligted;
+(UIColor *) colorButtonCancelText;
+(UIColor *) colorButtonCancelTextHigligted;

+(UIColor *) colorButtonOkBackground;
+(UIColor *) colorButtonOkBackgroundHigligted;
+(UIColor *) colorButtonOkText;
+(UIColor *) colorButtonOkTextHigligted;

+(UIColor *) colorButtonNeedEditOkBackground;
+(UIColor *) colorButtonNeedEditOkBackgroundHigligted;
+(UIColor *) colorButtonNeedEditOkText;
+(UIColor *) colorButtonNeedEditOkTextHigligted;

+(UIColor *) colorTripView;

+(UIColor *) colorVisaView;
+(UIColor *) colorVisaViewText;
+(UIColor *) colorVisaViewAlpha;

+(UIColor *) colorPassportView;
+(UIColor *) colorPassportViewText;
+(UIColor *) colorPassportViewAlpha;

+(UIColor *) colorTrip;
+(UIColor *) colorTripText;
+(UIColor *) colorTripAlpha;

+(UIColor *) colorCalendarOldDate;
+(UIColor *) colorCalendarNewDate;

+(UIColor *) colorLimitUpText;

- (UIImage *) imageFromColor;
@end
