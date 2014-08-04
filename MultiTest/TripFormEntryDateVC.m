//
//  TripFormEntryDateVC.m
//  MultiTest
//
//  Created by Administrator on 08.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "TripFormEntryDateVC.h"
#import "NSDate+Project.h"

@interface TripFormEntryDateVC ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong,nonatomic) NSDate *selectedDate;
@end

@implementation TripFormEntryDateVC
- (IBAction)okButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    if (NSOrderedDescending == [self.selectedDate compare:self.editingTrip.outDate]) {
        self.editingTrip.isOutDateNeedEdit=YES;
        self.editingTrip.outDate = [self.selectedDate dateByAddingTimeInterval:60*60*24];
    }
    self.editingTrip.isEntryDateEdited=YES;
    self.editingTrip.isEntryDateNeedEdit=NO;
    self.editingTrip.entryDate=self.selectedDate;
}

-(void) updateDate
{
    self.selectedDate=self.datePicker.date;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.datePicker setCalendar:[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar]];
    if (!self.editingTrip.entryDate) {
        self.selectedDate=[NSDate dateTo12h00EUfromDate:[NSDate date]];
    }else{
        self.selectedDate=self.editingTrip.entryDate;
    }
    self.datePicker.date=self.selectedDate;
    [self.datePicker addTarget:self action:@selector(updateDate) forControlEvents:UIControlEventValueChanged];
}


@end
