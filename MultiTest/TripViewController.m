//
//  TripViewController.m
//  MultiTest
//
//  Created by Administrator on 29.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "TripViewController.h"
#import "MultiDatabaseAvailability.h"
#import "TripsCDTVC.h"
#import "Trip.h"
#import "NSDate+Project.h"
#import "TripAddVC.h"
#import "UIColor+Project.h"
#import "MultiTestAppDelegate.h"

@interface TripViewController ()
@property (strong,nonatomic) TripsCDTVC* tripsCDTVC;
@end

@implementation TripViewController
- (IBAction)addTestTrip {
//    if (self.managedObjectContext) {
//        Trip *trip =[NSEntityDescription insertNewObjectForEntityForName:@"Trip" inManagedObjectContext:self.managedObjectContext];
//        trip.title=@"Валенсия";
//        trip.entryDate=[NSDate dateTo12h00EUfromDate:[NSDate dateWithTimeIntervalSinceNow:-60*60*24*((int)(arc4random()%100))]];
//        trip.outDate=[NSDate dateTo12h00EUfromDate:[NSDate dateWithTimeIntervalSinceNow:-60*60*24*((int)(arc4random()%100))]];
//        trip.numberOfTravelers=@1;
//        
//        NSError *error;
//        NSFetchRequest *request2=[NSFetchRequest fetchRequestWithEntityName:@"Country"];
//        NSArray *mathes2=[self.managedObjectContext executeFetchRequest:request2 error:&error];
//        
//        trip.entryCountry=[mathes2 firstObject];
//        trip.outCountry=[mathes2 firstObject];
//        NSLog(@"Added Trip");
//    }
}

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext=managedObjectContext;
    self.tripsCDTVC.managedObjectContext=self.managedObjectContext;
}
-(void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserverForName:MultiDatabaseAvailabilityNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.managedObjectContext=note.userInfo[MultiDatabaseAvailabilityContext];
        //NSLog(@"Notification recived by TripViewController");
    }];
}
-(void)setUser:(User *)user
{
    _user=user;
    self.title=[NSString stringWithFormat:@"Поездки: %@",self.user.name];
    self.tripsCDTVC.user=self.user;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[TripsCDTVC class]]) {
        TripsCDTVC *tcdtvc=segue.destinationViewController;
        tcdtvc.managedObjectContext=self.managedObjectContext;
        tcdtvc.user=self.user;
        self.tripsCDTVC=tcdtvc;
        //NSLog(@"Prerared for TripsCDTVC");
    }else{
        [super prepareForSegue:segue sender:sender];
    }
    if ([segue.identifier isEqualToString:@"Add Trip"]) {
        if ([segue.destinationViewController isKindOfClass:[TripAddVC class]]) {
            TripAddVC *tripAVC = segue.destinationViewController;
            tripAVC.userEditingTrip=self.user;
            tripAVC.managedObjectContext=self.managedObjectContext;
            
            NSManagedObjectContext *saveContext=((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).saveContext; //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>SAVE CONTEXT
            tripAVC.editingTrip=[TripTemp defaultTripTempInContext:saveContext];
            tripAVC.isCreating=YES;
            //NSLog(@"TRIPAVC is Creating");
        }
    }
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"testTabTripUp"];
    //self.navigationController.navigationBar.barTintColor = [UIColor colorTripAlpha];
    //self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorTripText]}];
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
