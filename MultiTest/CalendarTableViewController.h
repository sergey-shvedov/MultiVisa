//
//  CalendarTableViewController.h
//  MultiTest
//
//  Created by Administrator on 27.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import <UIKit/UIKit.h>
#import "User.h"
#import "CalendarVC.h"

@interface CalendarTableViewController : CoreDataTableViewController

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) User *user;
@property (strong,nonatomic) CalendarVC *calendarVC;
@property (strong,nonatomic) NSNumber *lookingDayFrom2001;

-(void) selectCell;

@end
