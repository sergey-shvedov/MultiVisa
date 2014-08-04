//
//  VisaViewController.m
//  MultiTest
//
//  Created by Administrator on 29.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "VisaViewController.h"
#import "MultiDatabaseAvailability.h"
#import "VisasCDTVC.h"
#import "Visa.h"
#import "VisaAddVC.h"
#import "VisaTemp.h"
#import "UIColor+Project.h"
#import "MultiTestAppDelegate.h"

@interface VisaViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong,nonatomic) VisasCDTVC *visasCDTVC;
@end

@implementation VisaViewController
- (IBAction)addTestVisa {
    if(self.managedObjectContext)
    {

    }
}

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext=managedObjectContext;
    self.visasCDTVC.managedObjectContext=self.managedObjectContext;
}
-(void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserverForName:MultiDatabaseAvailabilityNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.managedObjectContext=note.userInfo[MultiDatabaseAvailabilityContext];
        //NSLog(@"Notification recived by VisaViewController");
    }];
}
-(void)setUser:(User *)user
{
    _user=user;
    self.title=[NSString stringWithFormat:@"Визы: %@",self.user.name];
    self.visasCDTVC.user=self.user;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[VisasCDTVC class]]) {
        VisasCDTVC *vcdtvc=segue.destinationViewController;
        vcdtvc.managedObjectContext=self.managedObjectContext;
        vcdtvc.user=self.user;
        self.visasCDTVC=vcdtvc;
        //NSLog(@"Prerared for VisasCDTVC");
    }else{
        [super prepareForSegue:segue sender:sender];
    }
    if ([segue.identifier isEqualToString:@"Add Visa"]) {
        if ([segue.destinationViewController isKindOfClass:[VisaAddVC class]]) {
            VisaAddVC *visaAVC = segue.destinationViewController;
            visaAVC.userEditingVisa=self.user;
            visaAVC.managedObjectContext=self.managedObjectContext;
            
            NSManagedObjectContext *saveContext=((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).saveContext; //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>SAVE CONTEXT
            visaAVC.editingVisa=[VisaTemp defaultVisaTempInContext:saveContext];
            visaAVC.isCreating=YES;
            //NSLog(@"VISAAVC is Creating");
        }
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"testTabVisaUp3"];
    //self.navigationController.navigationBar.translucent = YES;
    //self.navigationController.navigationBar.barTintColor = [UIColor colorVisaViewAlpha];

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorVisaViewText]}];
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
