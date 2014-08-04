//
//  CalendarVC.m
//  MultiTest
//
//  Created by Administrator on 12.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "CalendarVC.h"
#import "MultiDatabaseAvailability.h"
#import "CalendarTableViewController.h"
#import "Day+Create.h"
#import "TodayVC.h"
#import "DraggableTodayView.h"
#import "PassportSavedNotification.h"
#import "NSDateFormatter+Project.h"

@interface CalendarVC ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong,nonatomic) CalendarTableViewController * calendarTVC;

@property (weak, nonatomic) IBOutlet UILabel *labelDayForTodayBtn;
@property (weak, nonatomic) IBOutlet UILabel *labelMonthForTodayBtn;
@property (weak, nonatomic) IBOutlet UILabel *labelYearForTodayBtn;
@property (weak, nonatomic) IBOutlet UILabel *labelUsedDays;
@property (weak, nonatomic) IBOutlet UILabel *labelTodayString;

@property (weak, nonatomic) IBOutlet UIImageView *star;
@property (weak, nonatomic) IBOutlet UIImageView *starWhite;
@property (weak, nonatomic) IBOutlet UIImageView *starOrange;
@property (weak, nonatomic) IBOutlet UIImageView *dragIcon;
@property (weak, nonatomic) IBOutlet UIImageView *bkgImage;
@property (weak, nonatomic) IBOutlet UIImageView *bkgLaunch;

@property (weak, nonatomic) IBOutlet DraggableTodayView *draggableTodayView;
@property (strong,nonatomic) NSString *nameOfImage;

@property (strong,nonatomic) NSDateFormatter *dateFormater;
@end

@implementation CalendarVC
- (IBAction)goToCurrentDateButton:(id)sender
{
    [self updateTadayView];
    [self.calendarTVC selectCell];
}

-(NSString *)nameOfImage
{
    if (!_nameOfImage) {
        _nameOfImage=@"today";
    }
    return _nameOfImage;
}

-(NSNumber *)lookingDayFrom2001
{
    if (!_lookingDayFrom2001) {
        _lookingDayFrom2001=[Day dayTodayinContext:self.managedObjectContext].from2001;
    }
    return _lookingDayFrom2001;
}
-(void) updateTadayView
{
    if ([self.splitViewController isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *svc=(UISplitViewController *)(self.splitViewController);
        if ([[[svc viewControllers] lastObject] isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tbc=(UITabBarController *)[[svc viewControllers] lastObject];
            for (NSInteger i=0; i<[[tbc viewControllers] count]; i++)
            {
                if([[[tbc viewControllers] objectAtIndex:i] isKindOfClass:[UINavigationController class]]){
                    UINavigationController *nc=(UINavigationController *)[[tbc viewControllers] objectAtIndex:i];
                    if ([nc.topViewController isKindOfClass:[TodayVC class]]) {
                        TodayVC *todayVC=(TodayVC *)(nc.topViewController);
                        tbc.selectedViewController=nc;
                        todayVC.day=[Day dayTodayinContext:self.managedObjectContext];
                    }
                }
                
                
            }
        }
    }
}

-(void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserverForName:MultiDatabaseAvailabilityNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.managedObjectContext=note.userInfo[MultiDatabaseAvailabilityContext];
        //NSLog(@"Notification recived by VisaViewController");
    }];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    float x=0.0;
    if (self.draggableTodayView.currentX < 0.0) {
        x=self.draggableTodayView.currentX;
    }
    CGRect rect=CGRectMake(x, self.draggableTodayView.frame.origin.y, self.draggableTodayView.frame.size.width, self.draggableTodayView.frame.size.height);
    [self.draggableTodayView setFrame:rect];
}



-(void)viewDidLoad
{
    [super viewDidLoad];
    self.draggableTodayView.calendarVC=self;
}

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext=managedObjectContext;
    
    [self updateDay];
    if (![self.bkgLaunch isHidden]) {
        [UIView animateWithDuration:0.2 animations:^{
            self.bkgLaunch.alpha=0.0;
        }completion:^(BOOL finished) {
            [self performSelector:@selector(hideTopView) withObject:nil afterDelay:1.0];
        }];
    }
}
-(void) hideTopView
{
    self.bkgLaunch.hidden=YES;
}

-(NSDateFormatter *)dateFormater
{
    if (!_dateFormater) {
        NSDateFormatter *df=[NSDateFormatter multiVisaDateFormatter];
        _dateFormater=df;
    }
    return _dateFormater;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Calendar Table"]) {
        CalendarTableViewController *ctvc=(CalendarTableViewController *)[segue destinationViewController];
        self.calendarTVC=ctvc;
        ctvc.calendarVC=self;
    }
}

-(void)updateDay
{
    if (self.managedObjectContext) {
        Day *today=[Day dayTodayinContext:self.managedObjectContext];
        self.labelDayForTodayBtn.text=[NSString stringWithFormat:@"%@",today.day];
        [self.dateFormater setDateFormat:@"MMMM"];
        self.labelMonthForTodayBtn.text=[self.dateFormater stringFromDate:today.date];
        [self.dateFormater setDateFormat:@"YYYY"];
        self.labelYearForTodayBtn.text=[self.dateFormater stringFromDate:today.date];
        self.labelUsedDays.text=[NSString stringWithFormat:@"%ld/90",(long)[today.last180TripDays integerValue]];
        if ([today.last180TripDays integerValue]>90) {
            self.starWhite.alpha=0.0;
            self.starOrange.alpha=1.0;
            if ([self.nameOfImage isEqualToString:@"today"]) {
                self.nameOfImage=@"todayAlert";
                [UIView beginAnimations:@"BkgChange" context:nil];
                self.bkgImage.image=[UIImage imageNamed:self.nameOfImage];
                [UIView commitAnimations];
                
            }
        }else{
            self.starOrange.alpha=0.0;
            self.starWhite.alpha=[today.last180TripDays floatValue]/90.0;
            if ([self.nameOfImage isEqualToString:@"todayAlert"]) {
                self.nameOfImage=@"today";
                self.bkgImage.image=[UIImage imageNamed:self.nameOfImage];
            }
        }
    }
    
}

-(void)updateTable
{
    if (self.calendarTVC) {
        [self.calendarTVC.tableView reloadData];
    }
    
}

-(void)setupClosingDraggableView
{
    [UIView beginAnimations:@"setupDragView" context:nil];
    self.dragIcon.alpha=0.5;
    self.labelUsedDays.alpha=0.0;
    self.labelTodayString.alpha=0.0;
    self.star.alpha=0.0;
    self.starOrange.hidden=YES;
    self.starWhite.hidden=YES;
    [UIView commitAnimations];

}
-(void)setupOpeningDraggableView
{
    [UIView beginAnimations:@"setupDragView" context:nil];
    self.dragIcon.alpha=0.0;
    self.labelUsedDays.alpha=1.0;
    self.labelTodayString.alpha=1.0;
    self.star.alpha=1.0;
    self.starOrange.hidden=NO;
    self.starWhite.hidden=NO;
    [UIView commitAnimations];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserverForName:TripNeedUpdateTodayCalendarView object:nil queue:nil usingBlock:^(NSNotification *note) {
        //NSLog(@"TripNeedUpdateTodayCalendarView");
        [self.managedObjectContext performBlock:^{
        [self updateTable];
        [self updateDay];
        }];

    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:TripSavedNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self.managedObjectContext performBlock:^{
            [self updateTable];
            [self updateDay];
        }];
        
    }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TripNeedUpdateTodayCalendarView object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TripSavedNotification object:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
