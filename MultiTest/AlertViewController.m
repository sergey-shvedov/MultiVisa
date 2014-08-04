//
//  AlertViewController.m
//  MultiTest
//
//  Created by Administrator on 29.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "AlertViewController.h"
#import "MultiDatabaseAvailability.h"
#import "AlertsCDTVC.h"
#import "TestCDTVC.h"


@interface AlertViewController ()
@property (strong,nonatomic) AlertsCDTVC *alertsCDTVC;
@property (strong,nonatomic) TestCDTVC *testCDTVC;
@end

@implementation AlertViewController

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext=managedObjectContext;
    self.alertsCDTVC.managedObjectContext=self.managedObjectContext;
    self.testCDTVC.managedObjectContext=self.managedObjectContext;
}
-(void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserverForName:MultiDatabaseAvailabilityNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.managedObjectContext=note.userInfo[MultiDatabaseAvailabilityContext];
        //NSLog(@"Notification recived by AlertViewController");
    }];
}
-(void)setUser:(User *)user
{
    _user=user;
    self.title=[NSString stringWithFormat:@"Предупреждения: %@",self.user.name];
    self.alertsCDTVC.user=self.user;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[AlertsCDTVC class]]) {
        AlertsCDTVC *acdtvc=segue.destinationViewController;
        acdtvc.managedObjectContext=self.managedObjectContext;
        acdtvc.user=self.user;
        self.alertsCDTVC=acdtvc;
        //NSLog(@"Prerared for AlertsCDTVC");
    }else{
        [super prepareForSegue:segue sender:sender];
    }

        
     if ([segue.identifier isEqualToString:@"Embed Test Table"]) {
        
        //if ([segue.destinationViewController isKindOfClass:[TestCDTVC class]]) {
         
        TestCDTVC *tcdtvc=segue.destinationViewController;
        tcdtvc.managedObjectContext=self.managedObjectContext;
        tcdtvc.user=self.user;
        self.testCDTVC=tcdtvc;
        //NSLog(@"Prerared for TestCDTVC");
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
