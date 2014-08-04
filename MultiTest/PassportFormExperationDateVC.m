//
//  PassportFormExperationDateVC.m
//  MultiTest
//
//  Created by Administrator on 09.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "PassportFormExperationDateVC.h"
#import "NSDate+Project.h"

@interface PassportFormExperationDateVC ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong,nonatomic) NSDate *selectedDate;
@end

@implementation PassportFormExperationDateVC
- (IBAction)okButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    if (NSOrderedAscending == [self.selectedDate compare:self.editingPassport.issueDate]) {
        self.editingPassport.isIssueDateNeedEdit=YES;
        self.editingPassport.issueDate = [self.selectedDate dateByAddingTimeInterval:-60*60*24*365*10];
    }
    self.editingPassport.isExperationDateEdited=YES;
    self.editingPassport.isExperationDateNeedEdit=NO;
    self.editingPassport.experationDate=self.selectedDate;
}

-(void) updateDate
{
    self.selectedDate=self.datePicker.date;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.datePicker setCalendar:[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar]];
    
    if (!self.editingPassport.experationDate) {
        self.selectedDate=[NSDate dateTo12h00EUfromDate:[NSDate date]];
    }else{
        self.selectedDate=self.editingPassport.experationDate;
    }
  
    self.datePicker.date=self.selectedDate;
    [self.datePicker addTarget:self action:@selector(updateDate) forControlEvents:UIControlEventValueChanged];
}


@end
