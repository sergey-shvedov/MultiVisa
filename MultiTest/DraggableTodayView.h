//
//  DraggableTodayView.h
//  MultiTest
//
//  Created by Administrator on 26.06.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarVC.h"

@interface DraggableTodayView : UIView
@property (nonatomic) float currentX;
@property (strong,nonatomic) CalendarVC *calendarVC;
@end
