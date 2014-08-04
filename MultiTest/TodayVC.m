//
//  TodayVC.m
//  MultiTest
//
//  Created by Administrator on 12.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "TodayVC.h"
#import "DayVC.h"
#import "DayWithTrip.h"
#import "Trip.h"
#import "Passport.h"
#import "Visa.h"
#import "Country.h"
#import "DayWithPassport.h"
#import "Day+Create.h"
#import "NSString+Project.h"
#import "NSDate+Project.h"
#import "UIColor+Project.h"
#import "MultiDatabaseAvailability.h"
#import "MultiTestAppDelegate.h"
#import "PassportSavedNotification.h"
#import "CalendarVC.h"
#import "NSDateFormatter+Project.h"

@interface TodayVC ()

//Hider
@property (weak, nonatomic) IBOutlet UIView *superHider;


//TOP views
@property (weak, nonatomic) IBOutlet UILabel *labelRoundDay;
@property (weak, nonatomic) IBOutlet UILabel *labelRoundMonth;
@property (weak, nonatomic) IBOutlet UILabel *labelRoundWeekday;
@property (weak, nonatomic) IBOutlet UILabel *labelBackDay;
@property (weak, nonatomic) IBOutlet UILabel *labelUsedDays;
@property (weak, nonatomic) IBOutlet UILabel *labelUsedDaysWord;
@property (weak, nonatomic) IBOutlet UILabel *labelUsedDays90;
@property (weak, nonatomic) IBOutlet UIView *viewTrips;

//PASSPORT views
@property (weak, nonatomic) IBOutlet UIView *viewPassports;
@property (weak, nonatomic) IBOutlet UILabel *labelPassportDay;
@property (weak, nonatomic) IBOutlet UILabel *labelPassportDayWord;
@property (weak, nonatomic) IBOutlet UILabel *labelPassportEndDate;
@property (weak, nonatomic) IBOutlet UILabel *labelNoPassport;
@property (weak, nonatomic) IBOutlet UIView *viewShowPassportData;
@property (weak, nonatomic) IBOutlet UITableView *tablePassports;
@property (weak, nonatomic) IBOutlet UILabel *labelTimePassport;

//VISA views
@property (weak, nonatomic) IBOutlet UIView *viewVisas;
@property (weak, nonatomic) IBOutlet UILabel *ladelVisaDay;
@property (weak, nonatomic) IBOutlet UILabel *labelVisaDayWord;
@property (weak, nonatomic) IBOutlet UILabel *labelVisaEndDate;
@property (weak, nonatomic) IBOutlet UILabel *labelNoVisa;
@property (weak, nonatomic) IBOutlet UIView *viewShowVisaData;
@property (weak, nonatomic) IBOutlet UITableView *tableVisas;
@property (weak, nonatomic) IBOutlet UILabel *labelTimeVisa;

//TRIP views  //view parts for hidden
@property (weak, nonatomic) IBOutlet UIView *viewTripDaysLeft; //Left Part1
@property (weak, nonatomic) IBOutlet UIView *viewTripVisaDaysLeft; //Left Part2
@property (weak, nonatomic) IBOutlet UIView *viewTripInfo; //Right
@property (weak, nonatomic) IBOutlet UIView *viewTripDays2; //Left Full
@property (weak, nonatomic) IBOutlet UIView *viewHiddenTripDaysFull;
@property (weak, nonatomic) IBOutlet UIView *viewHiddenTripDays;
@property (weak, nonatomic) IBOutlet UILabel *labelTimeTrip;

@property (weak, nonatomic) IBOutlet UILabel *labelTripDaysLeft; //Fase A
@property (weak, nonatomic) IBOutlet UILabel *labelTripDaysLeftWord;
@property (weak, nonatomic) IBOutlet UILabel *labelTripDaysLeftDate;

@property (weak, nonatomic) IBOutlet UILabel *labelTripVisaDaysLeft; //Fase B Part 1
@property (weak, nonatomic) IBOutlet UILabel *labelTripVisaDaysLeftWord;
@property (weak, nonatomic) IBOutlet UILabel *labelTripVisaDaysLeftDate;

@property (weak, nonatomic) IBOutlet UILabel *labelTripDays2Left; //Fase B Part 2
@property (weak, nonatomic) IBOutlet UILabel *labelTripDays2LeftWord;
@property (weak, nonatomic) IBOutlet UILabel *labelTripDays2Date;

@property (weak, nonatomic) IBOutlet UIStepper *stepper;  //Stepper Zone
@property (weak, nonatomic) IBOutlet UILabel *labelStepperDays;
@property (weak, nonatomic) IBOutlet UILabel *labelStepper2weeks;
@property (weak, nonatomic) IBOutlet UILabel *labelStepper1month;

////////////////////  Addition

@property (weak, nonatomic) IBOutlet UIView *additionViewTopAlert; //Alert Top Orange Background
@property (strong, nonatomic) UIBarButtonItem *leftToday; //Top left Button "Today"
@property (weak, nonatomic) IBOutlet UIImageView *imageInEU; //Topr Right "IN EU" image


///////////////////// Backgrounds

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage; //top backgrounds for the round graph with the set of images
@property (weak, nonatomic) UIImage *bkgLightBlue;
@property (weak, nonatomic) UIImage *bkgBlue;
@property (weak, nonatomic) UIImage *bkgOrange;
@property (weak, nonatomic) UIImage *bkgGray;
@property (weak, nonatomic) UIImage *bkgBGraylue;
@property (weak, nonatomic) UIImage *bkgGrayOrange;
@property (weak, nonatomic) IBOutlet UIView *bkgEUlineView; //DIDNT USE NOW - top line for EU status

///////////////////// Spinners

@property (strong,nonatomic) UIActivityIndicatorView *spinnerLeftPart;
@property (strong,nonatomic) UIActivityIndicatorView *spinnerLeftPart2;
@property (strong,nonatomic) UIActivityIndicatorView *spinnerLeftFull;
@property (strong,nonatomic) UIActivityIndicatorView *spinnerRight;

@property (strong,nonatomic) UIActivityIndicatorView *spinnerPassport;


/////////////////////

@property (strong,nonatomic) NSDateFormatter *dateFormater;

@property (strong,nonatomic) NSArray *passportArray;
@property (strong,nonatomic) NSArray *visaArray;


///////////////////// contetxs

@property (strong,nonatomic) NSManagedObjectContext *saveContext;
@property (strong,nonatomic) NSManagedObjectContext *fetchContext;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation TodayVC

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Contexts
///////////////////////////////////////////////

-(void)setSaveContext:(NSManagedObjectContext *)saveContext
{
    _saveContext=saveContext;
}
-(void)setFetchContext:(NSManagedObjectContext *)fetchContext
{
    _fetchContext=fetchContext;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Get Notification and set context
///////////////////////////////////////////////
-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext=managedObjectContext;
    
   
    
}


-(void)awakeFromNib
{
    //NSLog(@"AwakeFromNib");
    [[NSNotificationCenter defaultCenter] addObserverForName:MultiDatabaseAvailabilityNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.managedObjectContext=note.userInfo[MultiDatabaseAvailabilityContext];
        self.saveContext=((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).saveContext;
        self.fetchContext=((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).fetchContext;
        //self.passportsCDTVC.managedObjectContext=self.managedObjectContext;
        //NSLog(@"Notification recived by PassportViewController");
        [self updateUI];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:PassportSavedNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self updateNotificationPassport];
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:VisaSavedNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self updateNotificationVisa];
    }];
    

}

-(void) updateNotificationPassport
{
    [self setupPassportArray];
    [self updatePassportsWithIndex:0];
    [self.spinnerPassport stopAnimating];
}
-(void) updateNotificationVisa
{
    [self setupVisaArray];
    [self updateVisasWithIndex:0];
    //[self.spinnerPassport stopAnimating];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Setter DAY /getter dateformater
///////////////////////////////////////////////
-(void)setDay:(Day *)day
{
    _day=day;
    //[self setupPassportArrayQueue];
    [self setupPassportArray];
    [self setupVisaArray];
    [self updateUI];
    [self calendarMark];
}
-(void)calendarMark
{
    if ([self.splitViewController isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *svc=(UISplitViewController *)(self.splitViewController);
        if ([[[svc viewControllers] firstObject] isKindOfClass:[CalendarVC class]]) {
            CalendarVC *cvc=(CalendarVC *)[[svc viewControllers] firstObject];
            cvc.lookingDayFrom2001=self.day.from2001;
            [cvc updateTable];
        }
    }

}
-(NSDateFormatter *)dateFormater
{
    if (!_dateFormater) {
        NSDateFormatter *df=[NSDateFormatter multiVisaDateFormatter];
        _dateFormater=df;
    }
    return _dateFormater;
}



////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Getters of Backgrounds
///////////////////////////////////////////////
-(UIImage *) bkgLightBlue
{
    if (!_bkgLightBlue) {
        UIImage *new=[UIImage imageNamed:@"todayBkgLightBlue"];
        _bkgLightBlue=new;
    }
    return _bkgLightBlue;
}
-(UIImage *) bkgBlue
{
    if (!_bkgLightBlue) {
        UIImage *new=[UIImage imageNamed:@"todayBkgBlue"];
        _bkgLightBlue=new;
    }
    return _bkgLightBlue;
}
-(UIImage *) bkgOrange
{
    if (!_bkgLightBlue) {
        UIImage *new=[UIImage imageNamed:@"todayBkgOrange"];
        _bkgLightBlue=new;
    }
    return _bkgLightBlue;
}
-(UIImage *) bkgGray
{
    if (!_bkgLightBlue) {
        UIImage *new=[UIImage imageNamed:@"todayBkgGray"];
        _bkgLightBlue=new;
    }
    return _bkgLightBlue;
}
-(UIImage *) bkgGrayBlue
{
    if (!_bkgLightBlue) {
        UIImage *new=[UIImage imageNamed:@"todayBkgGrayBlue"];
        _bkgLightBlue=new;
    }
    return _bkgLightBlue;
}
-(UIImage *) bkgGrayOrange
{
    if (!_bkgLightBlue) {
        UIImage *new=[UIImage imageNamed:@"todayBkgGrayOrange"];
        _bkgLightBlue=new;
    }
    return _bkgLightBlue;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Getters of Spinners
///////////////////////////////////////////////

-(UIActivityIndicatorView *)spinnerLeftPart
{
    if (!_spinnerLeftPart) {
        UIActivityIndicatorView *spinner=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.frame=CGRectMake(0.0, 0.0, 40.0, 40.0);
        _spinnerLeftPart=spinner;
    }
    return _spinnerLeftPart;
}
-(UIActivityIndicatorView *)spinnerLeftPart2
{
    if (!_spinnerLeftPart2) {
        UIActivityIndicatorView *spinner=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.frame=CGRectMake(0.0, 0.0, 40.0, 40.0);
        _spinnerLeftPart2=spinner;
    }
    return _spinnerLeftPart2;
}
-(UIActivityIndicatorView *)spinnerLeftFull
{
    if (!_spinnerLeftFull) {
        UIActivityIndicatorView *spinner=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.frame=CGRectMake(0.0, 0.0, 40.0, 40.0);
        _spinnerLeftFull=spinner;
    }
    return _spinnerLeftFull;
}
-(UIActivityIndicatorView *)spinnerRight
{
    if (!_spinnerRight) {
        UIActivityIndicatorView *spinner=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.frame=CGRectMake(0.0, 0.0, 40.0, 40.0);
        _spinnerRight=spinner;
    }
    return _spinnerRight;
}
-(UIActivityIndicatorView *)spinnerPassport
{
    if (!_spinnerPassport) {
        UIActivityIndicatorView *spinner=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.frame=CGRectMake(0.0, 0.0, 40.0, 40.0);
        _spinnerPassport=spinner;
    }
    return _spinnerPassport;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Change backgrounds and set titles for time labels
///////////////////////////////////////////////
-(void) changeBackgroundImage
{
    if (self.day) {
        if (NSOrderedAscending==[self.day.date compare:[NSDate dayToday]]) { //PastTime
            self.labelTimeTrip.text=@"В Европе можно было находиться непрерывно:";
            self.labelTimeVisa.text=@"была действителена еще:";
            self.labelTimePassport.text=@"был действителен еще:";
            
            if ([self.day.last180TripDays integerValue] > 90) {
                self.backgroundImage.image =nil;
                [self.backgroundImage setImage:self.bkgGrayOrange];
                self.labelTimeTrip.text=@"Вы превысили максимальные сроки пребывания в Европе:";
            } else if ([self.day.tripsByDay count]>0){
                self.backgroundImage.image =nil;
                [self.backgroundImage setImage:self.bkgGrayBlue];
            } else {
                self.backgroundImage.image =nil;
                self.backgroundImage.image =self.bkgGray;
            }

        }else{ //Future time
            self.labelTimeTrip.text=@"В Европе можно находиться непрерывно:";
            self.labelTimeVisa.text=@"действителена еще:";
            self.labelTimePassport.text=@"действителен еще:";
            
            if ([self.day.last180TripDays integerValue] > 90) {
                self.backgroundImage.image =nil;
                [self.backgroundImage setImage:self.bkgOrange];
                self.labelTimeTrip.text=@"Вы можете превысить максимальные сроки пребывания в Европе:";
            } else if ([self.day.tripsByDay count]>0){
                self.backgroundImage.image =nil;
                [self.backgroundImage setImage:self.bkgBlue];
            } else {
                self.backgroundImage.image =nil;
                [self.backgroundImage setImage:self.bkgLightBlue];
            }
        }
        
        self.backgroundImage.alpha=0.4;   // Animation for appear
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundImage.alpha=0.9;
        }];

        
        if ([self.day.tripsByDay count]>0) {
            self.imageInEU.hidden=NO;
        } else self.imageInEU.hidden=YES;
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - IB Actions
///////////////////////////////////////////////
-(void) buttonToday: (id) sender  //custop top left "today" button (from viewdidload)
{
    self.day=[Day dayTodayinContext:self.managedObjectContext];
}
- (IBAction)leftRoundButton:(id)sender
{
    [self changeDayWithInteger:-1];
}
- (IBAction)rightRoundButton:(id)sender
{
    [self changeDayWithInteger:1];
}
- (IBAction)changeStepper:(id)sender
{
    self.labelStepperDays.text=[NSString stringWithFormat:@"%d %@ с %@",
                                (int)self.stepper.value, [NSString stringByRussianFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:self.stepper.value],
                                [self.labelStepperDays.text substringWithRange:NSMakeRange([self.labelStepperDays.text length]-8, 8)]];
    [self updateFetchRightStepper];
}

-(void) changeDayWithInteger:(NSInteger) delta
{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
    request.predicate=[NSPredicate predicateWithFormat:@"from2001 == %@",
                       [NSNumber numberWithInteger:([self.day.from2001 integerValue]+delta)]
                       ];

    NSError *error;
    NSArray *mathes=[self.day.managedObjectContext executeFetchRequest:request error:&error];
    if ([mathes count]==1) {
        if ([[mathes firstObject]isKindOfClass:[Day class]]) {
            self.day=(Day *)[mathes firstObject];
        }
    }
}

-(void) updateStepperView
{
    int value= (int)self.stepper.value;
    self.labelStepperDays.text=[NSString stringWithFormat:@"%d %@ с %@",
                                value,
                                [NSString stringByRussianFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:value],
                                [NSDateFormatter multiVisaLocalizedStringFromDate:[self.day dateOfLegalTripWithIntegerDays:value] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
    self.labelStepper2weeks.text=[NSString stringWithFormat:@"2 недели с %@", [NSDateFormatter multiVisaLocalizedStringFromDate:[self.day dateOfLegalTripWithIntegerDays:14] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
    self.labelStepper1month.text=[NSString stringWithFormat:@"1 месяц с %@", [NSDateFormatter multiVisaLocalizedStringFromDate:[self.day dateOfLegalTripWithIntegerDays:30] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
}

-(void) updateStepperViewQueue
{
    //int value= (int)self.stepper.value;
    Day *searchDay=(Day *)[self.fetchContext objectWithID:[self.day objectID]]; //Fetch CONTEXT
    NSString *string2weeks=[NSDateFormatter multiVisaLocalizedStringFromDate:[searchDay dateOfLegalTripWithIntegerDays:14] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    NSString *string1month=[NSDateFormatter multiVisaLocalizedStringFromDate:[searchDay dateOfLegalTripWithIntegerDays:30] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.labelStepper2weeks.text=[NSString stringWithFormat:@"2 недели с %@", string2weeks];
        self.labelStepper1month.text=[NSString stringWithFormat:@"1 месяц с %@", string1month];
    });
    
}

-(void) updateStepperViewQueueOnlyStepper: (int) value
{
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.labelStepperDays.text=[NSString stringWithFormat:@"%d %@ с %@",
//                                    value, [NSString stringByRussianFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:value],
//                                    [self.labelStepperDays.text substringWithRange:NSMakeRange([self.labelStepperDays.text length]-8, 8)]];
//    });
    
    NSString *stringDays=[NSDateFormatter multiVisaLocalizedStringFromDate:[self.day dateOfLegalTripWithIntegerDays:value] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (value == (int)self.stepper.value) {
                    self.labelStepperDays.text=[NSString stringWithFormat:@"%d %@ с %@",
                                    value,
                                    [NSString stringByRussianFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:value],
                                    stringDays];
        }

    });
    

}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Setup arrays for Tables (Passport, Visa)
///////////////////////////////////////////////
-(void) setupPassportArray
{
    
    if (self.day) {
        
        NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"DayWithPassport"];
        request.predicate=[NSPredicate predicateWithFormat:@"usedDay == %@", self.day];
        request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"inPassport.experationDate" ascending:NO selector:@selector(compare:)]];
        NSError *error;
        NSArray *results=[self.managedObjectContext executeFetchRequest:request error:&error];
        self.passportArray=[results valueForKey:@"inPassport"];
        
        //NSLog(@"Passport Array: %@",self.passportArray);
        
        [self.tablePassports reloadData];
    }
}


-(void) setupVisaArray
{
    if (self.day) {
        
        NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"DayWithVisa"];
        request.predicate=[NSPredicate predicateWithFormat:@"usedDay == %@", self.day];
        request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"inVisa.endDate" ascending:NO selector:@selector(compare:)]];
        NSError *error;
        NSArray *results=[self.managedObjectContext executeFetchRequest:request error:&error];
        self.visaArray=[results valueForKey:@"inVisa"];
        
        //NSLog(@"Visa Array: %@",self.visaArray);
        
        [self.tableVisas reloadData];
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Tables Delegate Methods (Passport, Visa)
///////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableVisas]) {
        return [self.visaArray count];
    }else if ([tableView isEqual:self.tablePassports]){
        return [self.passportArray count];
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    
    if ([tableView isEqual:self.tableVisas]) {
        static NSString *CellIdentifier = @"СellVisaToday";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        Visa *visa=nil;
        if ([[self.visaArray objectAtIndex:indexPath.row] isKindOfClass:[Visa class]]){
            visa=(Visa *)[self.visaArray objectAtIndex:indexPath.row];
        }
        if (3==[visa.multiEntryType integerValue]) {
            cell.textLabel.text=[NSString stringWithFormat:@"%@", visa.forCountry.titleRUS];
        }else{
            cell.textLabel.text=[NSString stringWithFormat:@"%@ (%@)", visa.forCountry.titleRUS, visa.typeABC];
        }
        
        
    }else if ([tableView isEqual:self.tablePassports]){
        
        static NSString *CellIdentifier = @"СellPassportToday";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        Passport *passport=nil;
        if ([[self.passportArray objectAtIndex:indexPath.row] isKindOfClass:[Passport class]]){
            passport=(Passport *)[self.passportArray objectAtIndex:indexPath.row];
        }
        
        if ([passport.number length]) {
            cell.textLabel.text=[NSString stringWithFormat:@"%@ №%@",[NSString stringByPassportType:passport.type] , passport.number];
        } else cell.textLabel.text=[NSString stringWithFormat:@"%@ (выдан: %@)",[NSString stringByPassportType:passport.type],
                                    [NSDateFormatter multiVisaLocalizedStringFromDate:passport.issueDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableVisas]) {
        [self updateVisasWithIndex:indexPath.row];
        [self.tableVisas deselectRowAtIndexPath:indexPath animated:YES];
    }else if ([tableView isEqual:self.tablePassports]){
        [self updatePassportsWithIndex:indexPath.row];
        //[self updatePassportsinQueueWithIndex:indexPath.row]; Queue way
        [self.tablePassports deselectRowAtIndexPath:indexPath animated:YES];
    }
}

//////////////////////////End Table


////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UPDATE UI
///////////////////////////////////////////////

-(void) updateUI
{
    if (!self.day){
        self.day=[Day dayTodayinContext:self.managedObjectContext];
    }
    //"Сегодня" button + Title
    if (self.day==[Day dayTodayinContext:self.managedObjectContext]){
        self.navigationItem.leftBarButtonItem=nil;
        [self setTitle:[NSString stringWithFormat: @"Сегодня: %@",[NSDateFormatter multiVisaLocalizedStringFromDate:self.day.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]]];
        [self.navigationController.tabBarItem setTitle:@"Отчет дня"];
        
    } else {
        self.navigationItem.leftBarButtonItem = self.leftToday;
        [self setTitle:[NSString stringWithFormat: @"Отчет дня: %@",[NSDateFormatter multiVisaLocalizedStringFromDate:self.day.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]]];
        [self.navigationController.tabBarItem setTitle:@"Отчет дня"];
        
    }
    //Background
    
    [self changeBackgroundImage];
    
    
    
    if (self.day){
        self.labelRoundDay.text=[NSString stringWithFormat:@"%@",self.day.day];
        [self.dateFormater setDateFormat:@"MMMM YYYY г."];
        self.labelRoundMonth.text=[self.dateFormater stringFromDate:self.day.date];
        [self.dateFormater setDateFormat:@"EEEE"];
        self.labelRoundWeekday.text=[self.dateFormater stringFromDate:self.day.date];
        self.labelBackDay.text=[NSDateFormatter multiVisaLocalizedStringFromDate:[self.day.date dateByAddingTimeInterval:-180*24*60*60] dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
        
        //NSInteger tripDays=[self.day numberOfTripDaysByLast:180];
        NSInteger tripDays=[self.day.last180TripDays integerValue];
        
        //Alert With limit excess
        if (tripDays>90) {
            self.additionViewTopAlert.hidden=NO;
            [self setTitle:[NSString stringWithFormat: @"%@: Нарушение!",[NSDateFormatter multiVisaLocalizedStringFromDate:self.day.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]]];
            [self.navigationController.tabBarItem setTitle:@"Отчет дня"];
            [self.labelUsedDays setTextColor:[UIColor colorLimitUpText]];
            //[self.labelUsedDaysWord setTextColor:[UIColor colorLimitUpText]];
            [self.labelUsedDays setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:58.0]];
            //[self.labelUsedDaysWord setFont:[UIFont fontWithName:@"HelveticaNeue-Regular" size:17.0]];
            [self.labelUsedDays90 setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:26.0]];
            
        }else{
            if (!self.additionViewTopAlert.isHidden) {
                self.additionViewTopAlert.hidden=YES;
                [self setTitle:[NSString stringWithFormat: @"Отчет дня: %@",[NSDateFormatter multiVisaLocalizedStringFromDate:self.day.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]]];
                [self.navigationController.tabBarItem setTitle:@"Отчет дня"];
                
                
                [self.labelUsedDays setTextColor:[UIColor blackColor]];
                //[self.labelUsedDaysWord setTextColor:[UIColor blackColor]];
                [self.labelUsedDays setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:58.0]];
                //[self.labelUsedDaysWord setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17.0]];
                [self.labelUsedDays90 setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:26.0]];
            }
        }
        
        self.labelUsedDays.text=[NSString stringWithFormat:@"%lu",(unsigned long)tripDays];
        self.labelUsedDaysWord.text=[NSString stringByRussianFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:tripDays];
        
        //TRIPS in graphic view
        
        NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
        request.predicate=[NSPredicate predicateWithFormat:@"(from2001 >= %@) AND (from2001 <= %@) AND (tripsByDay.@count!=0)",
                           [NSNumber numberWithInt:[self.day.from2001 intValue]-180],
                           self.day.from2001];
        NSError *error;
        NSArray *mathes=[self.day.managedObjectContext executeFetchRequest:request error:&error];
        
        NSMutableSet *tripsPast180Days=[[NSMutableSet alloc]init];
        for (Day* day in mathes)
        {
            if ([day.tripsByDay count]) {
                for (DayWithTrip *dayWithTrip in day.tripsByDay)
                {
                    [tripsPast180Days addObject:dayWithTrip.inTrip];
                }
            }
        }
        
        
        NSArray *trips=[tripsPast180Days sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"entryDate" ascending:YES selector:@selector(compare:)]]];
        
        //Creating views
        
        [self.viewTrips.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        NSInteger x=1;
        NSInteger x1=0;
        NSInteger x2=0;
        for (Trip *trip in trips)
        {
            NSInteger start=[NSDate daysFromDate:self.day.date toDate:trip.entryDate];
            NSInteger end=[NSDate daysFromDate:self.day.date toDate:trip.outDate];
            
            if (((start+179)<0) || ((start+179)<x)){
                x1=x;
            }else{
                x1=(start+179);
            }
            
            if ((end+180)>180){
                x2=180;
            }else if ((end+180)<x){
                x2=x;
                
            }else{
                x2=(end+180);
            }
            x=x2;
            
            //NSLog(@"VIEW: %ld: %ld",(long)x1,(long)x2);
            //NSLog(@"start: %ld  end: %ld",(long)start,(long)end);
            
            UIView *tripView=[[UIView alloc] initWithFrame:CGRectMake(x1*2.0, 25.0, 2.0*(x2-x1), 5.0)];
            [tripView setBackgroundColor:[UIColor colorTripView]];
            [self.viewTrips addSubview:tripView];
            
            if ((x2-x1)>9){
                UIImageView *tripPlane=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dayplane"]];
                [tripPlane setFrame:CGRectMake(x1*2.0, 5.0, 22.0, 22.0)];
                [self.viewTrips addSubview:tripPlane];
            }
            
            
        }
        
        
        
        //update passsports
        
        [self updatePassportsWithIndex:0];
        [self updateVisasWithIndex:0];
        [self updateTrips];
        

        
        [self updateSpinnersCenter];
        [self updateFetchUI];
        
        
        if (!self.superHider.isHidden) {
            [UIView animateWithDuration:0.5 animations:^{
                self.superHider.alpha=0.0;
            }completion:^(BOOL finished) {
                [self performSelector:@selector(hideTopView) withObject:nil afterDelay:0.5];
            }];
            
            
        }
    }
}
-(void) hideTopView
{
    self.superHider.hidden=YES;
}

/////////////////////////
#pragma mark update Visa & Passport views
/////////////////////////
-(void) updatePassportsWithIndex: (NSInteger) myIndex
{
    self.viewPassports.layer.borderColor=[UIColor colorPassportView].CGColor;
    self.viewPassports.layer.borderWidth=1.0;
    
    if ([self.passportArray count]) {
        
        self.viewShowPassportData.hidden=NO;
        self.labelNoPassport.hidden=YES;
        if (myIndex<[self.passportArray count]) {
            if ([[self.passportArray objectAtIndex:myIndex] isKindOfClass:[Passport class]]) {
                Passport *passport=(Passport *)[self.passportArray objectAtIndex:myIndex];
                NSInteger leftDays=[NSDate daysFromDate:self.day.date toDate:passport.experationDate]-1;
                if (leftDays<500){
                self.labelPassportDay.text=[NSString stringWithFormat:@"%ld",(long)leftDays];
                self.labelPassportDayWord.text=[NSString stringByRussianFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:leftDays];
                }else{
                    self.labelPassportDay.text=[NSString stringWithFormat:@"%ld",(long)(leftDays/365)];
                    self.labelPassportDayWord.text=[NSString stringByRussianFor1:@"год" for2to4:@"года" for5up:@"лет" withValue:(leftDays/365)];
                }
                self
                .labelPassportEndDate.text=[NSString stringWithFormat:@"до %@",[NSDateFormatter multiVisaLocalizedStringFromDate:passport.experationDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle]];
            }
            
        }
        
    } else{
        self.viewShowPassportData.hidden=YES;
        self.labelNoPassport.hidden=NO;
        self.labelNoPassport.text=@"На выбранную дату нет действующего загранпаспорта";
    }
    
    //[self.spinnerPassport stopAnimating];
    
}

-(void) updateVisasWithIndex: (NSInteger) myIndex
{
    self.viewVisas.layer.borderColor=[UIColor colorVisaView].CGColor;
    self.viewVisas.layer.borderWidth=1.0;
    
    if ([self.visaArray count]) {
        
        self.viewShowVisaData.hidden=NO;
        self.labelNoVisa.hidden=YES;
        if (myIndex<[self.visaArray count]) {
            if ([[self.visaArray objectAtIndex:myIndex] isKindOfClass:[Visa class]]) {
                Visa *visa=(Visa *)[self.visaArray objectAtIndex:myIndex];
                NSInteger leftDays=[NSDate daysFromDate:self.day.date toDate: visa.endDate]-1;
                if (leftDays<500){
                    self.ladelVisaDay.text=[NSString stringWithFormat:@"%ld",(long)leftDays];
                    self.labelVisaDayWord.text=[NSString stringByRussianFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:leftDays];
                }else{
                    self.ladelVisaDay.text=[NSString stringWithFormat:@"%ld",(long)(leftDays/365)];
                    self.labelVisaDayWord.text=[NSString stringByRussianFor1:@"год" for2to4:@"года" for5up:@"лет" withValue:(leftDays/365)];
                }

                self
                .labelVisaEndDate.text=[NSString stringWithFormat:@"до %@",[NSDateFormatter multiVisaLocalizedStringFromDate:visa.endDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle]];
            }
            
        }
        
    } else{
        self.viewShowVisaData.hidden=YES;
        self.labelNoVisa.hidden=NO;
        self.labelNoVisa.text=@"На выбранную дату нет действующих виз";
    }
    
}





-(void) updateTrips //border of views
{
    
    self.viewTripDaysLeft.layer.borderColor=[UIColor colorTrip].CGColor; //Left Part1
    self.viewTripDaysLeft.layer.borderWidth=1.0;
    
    self.viewTripVisaDaysLeft.layer.borderColor=[UIColor colorTrip].CGColor; //Left Part2
    self.viewTripVisaDaysLeft.layer.borderWidth=1.0;
    
    self.viewTripDays2.layer.borderColor=[UIColor colorTrip].CGColor; //Left Full
    self.viewTripDays2.layer.borderWidth=1.0;
    
    self.viewTripInfo.layer.borderColor=[UIColor colorTrip].CGColor; //Right
    self.viewTripInfo.layer.borderWidth=1.0;

}

-(void) setupSpinners
{
    [self.viewTripDaysLeft addSubview:self.spinnerLeftPart]; //Left Part1
    [self.viewTripVisaDaysLeft addSubview:self.spinnerLeftPart2]; //Left Part2
    [self.viewTripDays2 addSubview:self.spinnerLeftFull]; //Left Full
    [self.viewTripInfo addSubview:self.spinnerRight]; //Right
    
    [self.viewPassports addSubview:self.spinnerPassport];
    
    
}
-(void) updateSpinnersCenter
{
    self.spinnerLeftPart.center = CGPointMake(self.viewTripDaysLeft.bounds.size.width/2, self.viewTripDaysLeft.bounds.size.height/2); //Left Part
    self.spinnerLeftPart2.center = CGPointMake(self.viewTripVisaDaysLeft.bounds.size.width/2, self.viewTripVisaDaysLeft.bounds.size.height/2); //Left Part2
    self.spinnerLeftFull.center = CGPointMake(self.viewTripDays2.bounds.size.width/2, self.viewTripDays2.bounds.size.height/2); //Left Full
    self.spinnerRight.center = CGPointMake(self.viewTripInfo.bounds.size.width/2, self.viewTripInfo.bounds.size.height/2); //Right
    
    self.spinnerPassport.center = CGPointMake(self.viewPassports.bounds.size.width/2, self.viewPassports.bounds.size.height/2);

}



-(void) updateTripDaysLeft
{
    //NSInteger value=(90-[self.day numberOfTripDaysByLast:180]); //old version
    NSInteger value=[self.day numberOfTripDaysCanUseFromNow];
    NSString *left=[NSString stringWithFormat:@"%ld", (long)value];
    NSString *leftWord=[NSString stringByRussianFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:value];
    NSInteger myT=0;
    if (![self.day.tripsByDay count]) {  //Kostyl
        myT=1;
    }
    if (0==value && 1==myT) {
        myT=0;
    }
    NSString *leftDate=[NSString stringWithFormat:@"до %@", [NSDateFormatter multiVisaLocalizedStringFromDate:
                                                                          [self.day.date dateByAddingTimeInterval:(value -myT)*24*60*60] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
    NSString *leftDateLong=[NSString stringWithFormat:@"до %@", [NSDateFormatter multiVisaLocalizedStringFromDate:
                                                             [self.day.date dateByAddingTimeInterval:(value -myT)*24*60*60] dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle]];
    
    self.labelTripDaysLeft.text=left;
    self.labelTripDaysLeftWord.text= leftWord;
    self.labelTripDaysLeftDate.text= leftDate;
 
    self.labelTripDays2Left.text=left;
    self.labelTripDays2LeftWord.text= leftWord;
    self.labelTripDays2Date.text= leftDateLong;
    
}

-(void) updateTripVisaDaysLeft
{
    NSInteger leftDays=0;
    NSInteger value=(90-[self.day numberOfTripDaysByLast:180]);\
    
    if ([self.visaArray count]) {
        

        
        if ([[self.visaArray objectAtIndex:0] isKindOfClass:[Visa class]]) {
            Visa *visa=(Visa *)[self.visaArray objectAtIndex:0];
            leftDays=[NSDate daysFromDate:self.day.date toDate: visa.endDate]-1;
        }
        
        if (value<=leftDays){
            
            self.viewHiddenTripDays.hidden=NO;
            self.viewHiddenTripDaysFull.hidden=YES;
            
        }else{
            
            self.viewHiddenTripDays.hidden=YES;
            self.viewHiddenTripDaysFull.hidden=NO;
            
            self.labelTripVisaDaysLeft.text=[NSString stringWithFormat:@"%ld", (long)leftDays];
            self.labelTripVisaDaysLeftWord.text=[NSString stringByRussianFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:leftDays];
            self.labelTripVisaDaysLeftDate.text=[NSString stringWithFormat:@"до %@", [NSDateFormatter multiVisaLocalizedStringFromDate:
                                                                                      [self.day.date dateByAddingTimeInterval:leftDays*24*60*60]
                                                                                                                    dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
        }
        
    } else {
        
        self.viewHiddenTripDays.hidden=NO;
        self.viewHiddenTripDaysFull.hidden=YES;

        
    }
    
    
    

}

-(void) updateTripDaysLeftNew
{
    //Fetch Context
    
    NSInteger value=[(Day *)[self.fetchContext objectWithID:[self.day objectID]] numberOfTripDaysCanUseFromNow];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *left=[NSString stringWithFormat:@"%ld", (long)value];
        NSString *leftWord=[NSString stringByRussianFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:value];
        NSInteger myT=0;
        if (![self.day.tripsByDay count]) {  //Kostyl
            myT=1;
        }
        if (0==value && 1==myT) {
            myT=0;
        }
        NSString *leftDate=[NSString stringWithFormat:@"до %@", [NSDateFormatter multiVisaLocalizedStringFromDate:
                                                                 [self.day.date dateByAddingTimeInterval:(value -myT)*24*60*60] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
        NSString *leftDateLong=[NSString stringWithFormat:@"до %@", [NSDateFormatter multiVisaLocalizedStringFromDate:
                                                                     [self.day.date dateByAddingTimeInterval:(value -myT)*24*60*60] dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle]];
        
        self.labelTripDaysLeft.text=left;
        self.labelTripDaysLeftWord.text= leftWord;
        self.labelTripDaysLeftDate.text= leftDate;
        
        self.labelTripDays2Left.text=left;
        self.labelTripDays2LeftWord.text= leftWord;
        self.labelTripDays2Date.text= leftDateLong;
        
        
        NSInteger leftDays=0;
        
        if ([self.visaArray count]) {
            
            
            
            if ([[self.visaArray objectAtIndex:0] isKindOfClass:[Visa class]]) {
                Visa *visa=(Visa *)[self.visaArray objectAtIndex:0];
                leftDays=[NSDate daysFromDate:self.day.date toDate: visa.endDate]-1;
            }
            
            if (value<=leftDays){
                
                self.viewHiddenTripDays.hidden=NO;
                self.viewHiddenTripDaysFull.hidden=YES;
                
            }else{
                
                self.viewHiddenTripDays.hidden=YES;
                self.viewHiddenTripDaysFull.hidden=NO;
                
                self.labelTripVisaDaysLeft.text=[NSString stringWithFormat:@"%ld", (long)leftDays];
                self.labelTripVisaDaysLeftWord.text=[NSString stringByRussianFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:leftDays];
                self.labelTripVisaDaysLeftDate.text=[NSString stringWithFormat:@"до %@", [NSDateFormatter multiVisaLocalizedStringFromDate:
                                                                                          [self.day.date dateByAddingTimeInterval:leftDays*24*60*60]
                                                                                                                        dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
            }
            
        } else {
            
            self.viewHiddenTripDays.hidden=NO;
            self.viewHiddenTripDaysFull.hidden=YES;
    
        }
        
    });
    
}

-(void) updateFetchUI
{
    [self updateFetchLeft];
    [self updateFetchRight];
}

-(void) updateFetchLeft
{
    [self updateSpinnersCenter];
    
    [self.spinnerLeftFull startAnimating];
    [self.spinnerLeftPart startAnimating];
    [self.spinnerLeftPart2 startAnimating];
    
    [self.labelTripDaysLeft setAlpha:0.5];
    [self.labelTripDaysLeftWord setAlpha:0.5];
    [self.labelTripVisaDaysLeft setAlpha:0.5];
    [self.labelTripVisaDaysLeftWord setAlpha:0.5];
    [self.labelTripDays2Left setAlpha:0.5];
    [self.labelTripDays2LeftWord setAlpha:0.5];
    
    void (^leftBlock)(Day *)=^(Day *dayB){
        if ([dayB isEqual:self.day]) {
            [self updateTripDaysLeftNew];
            if ([dayB isEqual:self.day]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.spinnerLeftFull stopAnimating];
                    [self.spinnerLeftPart stopAnimating];
                    [self.spinnerLeftPart2 stopAnimating];
                    
                    [self.labelTripDaysLeft setAlpha:1.0];
                    [self.labelTripDaysLeftWord setAlpha:1.0];
                    [self.labelTripVisaDaysLeft setAlpha:1.0];
                    [self.labelTripVisaDaysLeftWord setAlpha:1.0];
                    [self.labelTripDays2Left setAlpha:1.0];
                    [self.labelTripDays2LeftWord setAlpha:1.0];
                });
            }
        }
    };
    
    Day* tempDay=self.day;
    
    [self.fetchContext performBlock:^{
        leftBlock(tempDay);
    }];
    
//    dispatch_async(self.leftQueue, ^{
//        leftBlock(tempDay);
//    
//    
//    });
    
}

-(void) updateFetchRight
{
    [self updateSpinnersCenter];
    
    [self.spinnerRight startAnimating];
    
    void (^rightBlock)(Day *)=^(Day *dayB){
        if ([dayB isEqual:self.day]) {
            [self updateStepperViewQueue];
            if ([dayB isEqual:self.day]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    

                });
            }
        }
    };
    
    Day* tempDay=self.day;
    [self.fetchContext performBlock:^{
        rightBlock(tempDay);
    }];
//    dispatch_async(self.rightQueue, ^{
//        rightBlock(tempDay);
//        
//        
//    });
    
    [self updateFetchRightStepper];
    
}
-(void) updateFetchRightStepper
{
    [self updateSpinnersCenter];
    
    [self.spinnerRight startAnimating];
    
    [self.labelStepperDays setAlpha:0.5];
    [self.labelStepper2weeks setAlpha:0.5];
    [self.labelStepper1month setAlpha:0.5];
    
    void (^rightStepperBlock)(Day *, double)=^(Day *dayB, double stepperValue){
        if ([dayB isEqual:self.day]) {
            if (stepperValue == self.stepper.value) {
                [self updateStepperViewQueueOnlyStepper:(int) stepperValue];
                if ([dayB isEqual:self.day]) {
                    if (stepperValue == self.stepper.value) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [self.labelStepperDays setAlpha:1.0];
                            [self.labelStepper2weeks setAlpha:1.0];
                            [self.labelStepper1month setAlpha:1.0];
                            
                            [self.spinnerRight stopAnimating];
                        });
                    }
                }
            }
            
        }
    };
    
    Day* tempDay=self.day;
    double valueTemp=self.stepper.value;
    
    [self.fetchContext performBlock:^{
       rightStepperBlock(tempDay, valueTemp);
    }];
//    dispatch_async(self.rightQueue, ^{
//        rightStepperBlock(tempDay, valueTemp);
//        
//        
//    });
    
}



-(void)activatePassportSpinner
{
    [self updateSpinnersCenter];
    [self.spinnerPassport startAnimating];
}

-(void)activateVisaSpinner
{
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - View Did Load
///////////////////////////////////////////////

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"testTabDayUp"];
    [self.navigationController.tabBarItem setTitle:@"Отчет дня"];

    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeSystem]; // Top left "Today"
    [button setImage:[UIImage imageNamed:@"testBarToday"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonToday:)forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Сегодня" forState:UIControlStateNormal];
    [button sizeToFit];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.leftToday=barButton;
    
    //Setup spinners
    [self setupSpinners];
    

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateSpinnersCenter];
    

    
}
-(void)viewDidDisappear:(BOOL)animated
{
//#warning RemoveObservers
    [super viewDidDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:NSManagedObjectContextDidSaveNotification
//                                                  object:[self managedObjectContext]];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
