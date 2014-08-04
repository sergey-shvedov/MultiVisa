//
//  PassportViewController.m
//  MultiTest
//
//  Created by Administrator on 29.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "PassportViewController.h"
#import "PassportsCDTVCViewController.h"
#import "MultiDatabaseAvailability.h"
#import "PassportAddVC.h"
#import "PassportTemp.h"
#import "UIColor+Project.h"
#import "MultiTestAppDelegate.h"

@interface PassportViewController ()
@property (strong,nonatomic) PassportsCDTVCViewController *passportsCDTVC;
@end

@implementation PassportViewController




-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext=managedObjectContext;
    self.passportsCDTVC.managedObjectContext=self.managedObjectContext;
}
-(void)awakeFromNib
{
    //NSLog(@"AwakeFromNib");
    [[NSNotificationCenter defaultCenter] addObserverForName:MultiDatabaseAvailabilityNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.managedObjectContext=note.userInfo[MultiDatabaseAvailabilityContext];
        //self.passportsCDTVC.managedObjectContext=self.managedObjectContext;
        //NSLog(@"Notification recived by PassportViewController");
    }];
}
-(void)setUser:(User *)user
{
    _user=user;
    self.title=[NSString stringWithFormat:@"Паспорта: %@",self.user.name];
    self.passportsCDTVC.user=self.user;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[PassportsCDTVCViewController class]]) {
        PassportsCDTVCViewController *pcdtvc=segue.destinationViewController;
        pcdtvc.managedObjectContext=self.managedObjectContext;
        pcdtvc.user=self.user;
        self.passportsCDTVC=pcdtvc;
        //NSLog(@"Prerared for passportsCDTVC");
    }else{
        [super prepareForSegue:segue sender:sender];
    }
    if ([segue.identifier isEqualToString:@"Add Passport"]) {
        if ([segue.destinationViewController isKindOfClass:[PassportAddVC class]]) {
            PassportAddVC *passportAVC = (PassportAddVC *)(segue.destinationViewController);
            passportAVC.userEditingPassport=self.user;
            passportAVC.managedObjectContext=self.managedObjectContext;
            NSManagedObjectContext *saveContext=((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).saveContext; //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>SAVE CONTEXT
            passportAVC.editingPassport=[PassportTemp defaultPassportTempInContext:saveContext];
            passportAVC.isCreating=YES;
            //NSLog(@"PassportAVC is Creating");
        }
    }

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"testTabPassport2Up2"];
    //tabBarItem
    //self.navigationController.navigationBar.barTintColor = [UIColor colorPassportViewAlpha];
    //self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorPassportViewText]}];
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
