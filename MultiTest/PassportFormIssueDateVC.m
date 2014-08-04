//
//  PassportFormIssueDateVC.m
//  MultiTest
//
//  Created by Administrator on 09.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "PassportFormIssueDateVC.h"
#import "NSDate+Project.h"

@interface PassportFormIssueDateVC ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong,nonatomic) NSDate *selectedDate;
@end

@implementation PassportFormIssueDateVC
- (IBAction)okButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    if (NSOrderedDescending == [self.selectedDate compare:self.editingPassport.experationDate]) {
        self.editingPassport.isExperationDateNeedEdit=YES;
        self.editingPassport.experationDate = [self.selectedDate dateByAddingTimeInterval:60*60*24*365*10];
    }
    self.editingPassport.isIssueDateEdited=YES;
    self.editingPassport.isIssueDateNeedEdit=NO;
    self.editingPassport.issueDate=self.selectedDate;
}

-(void) updateDate
{
    self.selectedDate=self.datePicker.date;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.datePicker setCalendar:[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar]];
    if (!self.editingPassport.issueDate) {
        self.selectedDate=[NSDate dateTo12h00EUfromDate:[NSDate date]];
    }else{
        self.selectedDate=self.editingPassport.issueDate;
    }
    self.datePicker.date=self.selectedDate;
    [self.datePicker addTarget:self action:@selector(updateDate) forControlEvents:UIControlEventValueChanged];
}



@end
