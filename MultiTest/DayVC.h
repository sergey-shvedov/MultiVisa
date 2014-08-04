//
//  DayVC.h
//  MultiTest
//
//  Created by Administrator on 13.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Day.h"

@interface DayVC : UIViewController
@property (strong,nonatomic) Day *day;


-(void) updateUI;
@end
