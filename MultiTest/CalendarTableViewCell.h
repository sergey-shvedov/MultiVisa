//
//  CalendarTableViewCell.h
//  MultiTest
//
//  Created by Administrator on 27.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Week.h"


@interface CalendarTableViewCell : UITableViewCell


@property (strong,nonatomic) Week* week;
@property (nonatomic) NSInteger todayFrom2001;
@property (nonatomic) NSInteger lookingDayFrom2001;

@end
