//
//  CalendarVC.h
//  MultiTest
//
//  Created by Administrator on 12.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"


@interface CalendarVC : UIViewController
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) User *user;
@property (strong,nonatomic) NSNumber *lookingDayFrom2001;

-(void) updateTable;
-(void) updateDay;

-(void)setupClosingDraggableView;
-(void)setupOpeningDraggableView;
@end
