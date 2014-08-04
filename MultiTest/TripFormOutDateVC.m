//
//  TripFormOutDateVC.m
//  MultiTest
//
//  Created by Administrator on 08.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "TripFormOutDateVC.h"
#import "NSDate+Project.h"

@interface TripFormOutDateVC ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong,nonatomic) NSDate *selectedDate;
@end

@implementation TripFormOutDateVC
- (IBAction)okButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    if (NSOrderedAscending == [self.selectedDate compare:self.editingTrip.entryDate]) {
        self.editingTrip.isEntryDateNeedEdit=YES;
        self.editingTrip.entryDate = [self.selectedDate dateByAddingTimeInterval:-60*60*24];
    }
    self.editingTrip.isOutDateEdited=YES;
    self.editingTrip.isOutDateNeedEdit=NO;
    self.editingTrip.outDate=self.selectedDate;
}

-(void) updateDate
{
    self.selectedDate=self.datePicker.date;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.datePicker setCalendar:[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar]];
    if (!self.editingTrip.outDate) {
        self.selectedDate=[NSDate dateTo12h00EUfromDate:[NSDate date]];
    }else{
        self.selectedDate=self.editingTrip.outDate;
    }
    self.datePicker.date=self.selectedDate;
    [self.datePicker addTarget:self action:@selector(updateDate) forControlEvents:UIControlEventValueChanged];
}


@end
