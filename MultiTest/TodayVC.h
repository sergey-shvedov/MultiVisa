//
//  TodayVC.h
//  MultiTest
//
//  Created by Administrator on 12.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Day.h"

@interface TodayVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) Day *day;
@property (strong,nonatomic) NSString *test;

-(void) updateUI;
-(void) updateSpinnersCenter;
-(void) activatePassportSpinner;
-(void) activateVisaSpinner;
@end
