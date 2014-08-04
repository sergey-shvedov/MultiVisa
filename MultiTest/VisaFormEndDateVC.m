//
//  VisaFormEndDateVC.m
//  MultiTest
//
//  Created by Administrator on 04.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "VisaFormEndDateVC.h"
#import "NSDate+Project.h"

@interface VisaFormEndDateVC ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong,nonatomic) NSDate *selectedDate;
@end

@implementation VisaFormEndDateVC

- (IBAction)okButton
{
    [self.navigationController popViewControllerAnimated:YES];
    if (NSOrderedAscending == [self.selectedDate compare:self.editingVisa.startDate]) {
        self.editingVisa.isStartDateNeedEdit=YES;
        self.editingVisa.startDate = [self.selectedDate dateByAddingTimeInterval:-60*60*24];
    }
    self.editingVisa.isEndDateEdited=YES;
    self.editingVisa.isEndDateNeedEdit=NO;
    self.editingVisa.endDate=self.selectedDate;
}

-(void) updateDate
{
    
    self.selectedDate=self.datePicker.date;
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.datePicker setCalendar:[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar]];
    if (!self.editingVisa.endDate) {
        self.selectedDate=[NSDate dateTo12h00EUfromDate:[NSDate date]];
    }else{
       self.selectedDate=self.editingVisa.endDate;
    }
    self.datePicker.date=self.selectedDate;
    [self.datePicker addTarget:self action:@selector(updateDate) forControlEvents:UIControlEventValueChanged];
}


@end
