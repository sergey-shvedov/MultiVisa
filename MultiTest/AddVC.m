 //
//  AddVC.m
//  MultiTest
//
//  Created by Administrator on 01.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "AddVC.h"
#import "CONST.h"
#import "UIColor+Project.h"
#import "FormButton.h"
#import "TodayVC.h"
#import "CalendarVC.h"
#import "MultiTestAppDelegate.h"

@interface AddVC ()



@end

@implementation AddVC
-(TodayVC *) todayVC
{
    if (!_todayVC) {
        if ([self.presentingViewController isKindOfClass:[UISplitViewController class]]) {
            UISplitViewController *svc=(UISplitViewController *)(self.presentingViewController);
            if ([[[svc viewControllers] lastObject] isKindOfClass:[UITabBarController class]]) {
                UITabBarController *tbc=(UITabBarController *)[[svc viewControllers] lastObject];
                for (NSInteger i=0; i<[[tbc viewControllers] count]; i++)
                {
                    if([[[tbc viewControllers] objectAtIndex:i] isKindOfClass:[UINavigationController class]]){
                        UINavigationController *nc=(UINavigationController *)[[tbc viewControllers] objectAtIndex:i];
                        if ([nc.topViewController isKindOfClass:[TodayVC class]]) {
                            TodayVC *todayVC=(TodayVC *)(nc.topViewController);
                            _todayVC=todayVC;
                        }
                    }
                }
            }
        }
    }
    return _todayVC;
}

-(UIManagedDocument *)document
{
    if (!_document) {
        UIManagedDocument *document=((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).document;
        _document=document;
    }
    return _document;
}
-(void) updateTodayView
{
    if ([self.presentingViewController isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *svc=(UISplitViewController *)(self.presentingViewController);
        if ([[[svc viewControllers] lastObject] isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tbc=(UITabBarController *)[[svc viewControllers] lastObject];
            for (NSInteger i=0; i<[[tbc viewControllers] count]; i++)
            {
                if([[[tbc viewControllers] objectAtIndex:i] isKindOfClass:[UINavigationController class]]){
                    UINavigationController *nc=(UINavigationController *)[[tbc viewControllers] objectAtIndex:i];
                    if ([nc.topViewController isKindOfClass:[TodayVC class]]) {
                        TodayVC *todayVC=(TodayVC *)(nc.topViewController);
                        [((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).saveContext performBlock:^{ //SAVECONTEXT
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [todayVC updateUI];
                            });
                        }];
                        
                    }
                }
            }
        }
    }
}



-(void)updateCalendarView
{
    if ([self.presentingViewController isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *svc=(UISplitViewController *)(self.presentingViewController);
        if ([[[svc viewControllers] firstObject] isKindOfClass:[CalendarVC class]]) {
            CalendarVC *cvc=(CalendarVC *)[[svc viewControllers] firstObject];
            [((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).saveContext performBlock:^{ //SAVECONTEXT
                dispatch_async(dispatch_get_main_queue(), ^{
                    [cvc updateTable];
                    [cvc updateDay];
                });
            }];
        }
    }
}


-(void) animateAppearsButton: (UIButton *) button
{
    button.alpha=0.0;
    button.hidden=NO;
    [UIView animateWithDuration:BUTTON_APPEAR_DURATION animations:^{
        button.alpha=1.0;
    }];
}

-(void) dismissButtons
{
    self.buttonOk.hidden=YES;
    self.buttonCancel.hidden=YES;
}
-(void) appearButtons
{
    [self animateAppearsButton:self.buttonOk];
    [self animateAppearsButton:self.buttonCancel];
}


-(void) createButtonOk
{
    FormButton *button=[FormButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(275.0, 120.0, 265.0, 44.0)];
    
    if (self.isCreating) {
        [button setText:@"Создать" withIsNeedEdit:YES ansIsCancel:NO];
        //[button setTitle:@"Создать" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickOKForCreate:) forControlEvents:UIControlEventTouchUpInside];
    }else{

        [button setText:@"Сохранить" withIsNeedEdit:NO ansIsCancel:NO];
        //[button setTitle:@"Сохранить" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickOKForSave:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    self.buttonOk=button;
    [self.view addSubview:self.buttonOk];

    /*self.buttonOk=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonOk setFrame:CGRectMake(275.0, 125.0, 265.0, 44.0)];
    
    if (self.isCreating) {
        [self.buttonOk setTitle:@"Создать" forState:UIControlStateNormal];
    }else{
        [self.buttonOk setTitle:@"Сохранить" forState:UIControlStateNormal];
    }
    self.buttonOk.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [self.buttonOk setBackgroundColor:[UIColor colorButtonOkBackground]];
    [self.buttonOk setBackgroundImage:([[UIColor colorButtonOkBackgroundHigligted] imageFromColor]) forState:UIControlStateHighlighted];
    [self.buttonOk setTitleColor:[UIColor colorButtonOkText] forState:UIControlStateNormal];
    [self.buttonOk setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.view addSubview:self.buttonOk];*/

}
-(void) clickOKForCreate: (id) sender
{
    
}
-(void) clickOKForSave: (id) sender
{
    
}
-(void) clickCancel:(id) sender
{
    
}
-(void) createButtonCancel
{
    
    FormButton *button=[FormButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0.0, 120.0, 265.0, 44.0)];
    [button setText:@"Отменить" withIsNeedEdit:NO ansIsCancel:YES];
 
        //[button setTitle:@"Отменить" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];

    self.buttonCancel=button;
    [self.view addSubview:self.buttonCancel];
    
    /*self.buttonCancel=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonCancel setFrame:CGRectMake(0.0, 125.0, 265.0, 44.0)];
    
    if (self.isCreating) {
        [self.buttonCancel setTitle:@"Отменить" forState:UIControlStateNormal];
        
    }else{
        [self.buttonCancel setTitle:@"Отменить" forState:UIControlStateNormal];
    }
    self.buttonCancel.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [self.buttonCancel setBackgroundColor:[UIColor colorButtonCancelBackground]];
    [self.buttonCancel setBackgroundImage:([[UIColor colorButtonCancelBackgroundHigligted] imageFromColor]) forState:UIControlStateHighlighted];
    [self.buttonCancel setTitleColor:[UIColor colorButtonCancelText] forState:UIControlStateNormal];
    [self.buttonCancel setTitleColor:[UIColor colorButtonCancelTextHigligted] forState:UIControlStateHighlighted];
    [self.view addSubview:self.buttonCancel];*/
    
}


-(void) createTestButtton
{
    FormButton *newButton = [FormButton buttonWithType:UIButtonTypeCustom];
    [newButton setFrame:CGRectMake(0.0, 200.0, 265.0, 44.0)];
    [newButton.textLabel setText:@"Создать"];
    newButton.isNeedEdit=NO;
    newButton.isCancel=NO;
    self.buttonTest=newButton;
    [self.view addSubview:self.buttonTest];
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self createButtonCancel];
    [self createButtonOk];
    //[self createTestButtton];
}

- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

@end