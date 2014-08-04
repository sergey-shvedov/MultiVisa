//
//  AddVC.h
//  MultiTest
//
//  Created by Administrator on 01.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormButton.h"
#import "AddButtonsActions.h"
#import "TodayVC.h"

@interface AddVC : UIViewController <AddButtonsActions>

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property BOOL isCreating;
@property (strong,nonatomic) FormButton *buttonOk;
@property (strong,nonatomic) FormButton *buttonCancel;
@property (strong,nonatomic) FormButton *buttonTest;

@property (strong,nonatomic) TodayVC *todayVC;
@property (strong,nonatomic) UIManagedDocument *document;

-(void) updateTodayView;
-(void) updateCalendarView;

-(void) animateAppearsButton: (UIButton *) button;

-(void) appearButtons;
-(void) dismissButtons;
-(void) clickCancel:(id) sender;
-(void) clickOKForCreate: (id) sender;
-(void) clickOKForSave: (id) sender;


@end
