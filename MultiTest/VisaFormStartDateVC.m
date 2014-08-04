//
//  VisaFormStartDateVC.m
//  MultiTest
//
//  Created by Administrator on 04.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "VisaFormStartDateVC.h"
#import "NSDate+Project.h"

@interface VisaFormStartDateVC ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong,nonatomic) NSDate *selectedDate;
@end

@implementation VisaFormStartDateVC
- (IBAction)okButton
{
    [self.navigationController popViewControllerAnimated:YES];
    if (NSOrderedDescending == [self.selectedDate compare:self.editingVisa.endDate]) {
        self.editingVisa.isEndDateNeedEdit=YES;
        self.editingVisa.endDate = [self.selectedDate dateByAddingTimeInterval:60*60*24];
    }
    self.editingVisa.isStartDateEdited=YES;
    self.editingVisa.isStartDateNeedEdit=NO;
    self.editingVisa.startDate=self.selectedDate;
}

-(void) updateDate
{

    self.selectedDate=self.datePicker.date;
    //NSLog(@"DATE: %@",self.editingVisa.startDate);
    //NSLog(@"DATE CHANGED: %@",[NSDate dateTo12h00EUfromDate:self.editingVisa.startDate]);
    //NSLog(@"DATE BETWEEN: %ld",(long)[NSDate daysFromDate:self.editingVisa.startDate toDate:self.editingVisa.endDate]);

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.datePicker setCalendar:[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar]];
    if (!self.editingVisa.startDate) {
        self.selectedDate=[NSDate dateTo12h00EUfromDate:[NSDate date]];
    }else{
        self.selectedDate=self.editingVisa.startDate;
    }
    self.datePicker.date=self.selectedDate;
    [self.datePicker addTarget:self action:@selector(updateDate) forControlEvents:UIControlEventValueChanged];
}

@end
