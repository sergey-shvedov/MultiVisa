//
//  VisaFormDaysVC.m
//  MultiTest
//
//  Created by Administrator on 06.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "VisaFormDaysVC.h"
#import "NSDate+Project.h"
#import "NSString+Project.h"

@interface VisaFormDaysVC ()
@property (weak, nonatomic) IBOutlet UIPickerView *daysPicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentType;
@property (weak, nonatomic) IBOutlet UILabel *dayRussianLabel;
@property (strong,nonatomic) NSNumber *selectedType;
@property (strong,nonatomic) NSNumber *selectedDays;
@end

@implementation VisaFormDaysVC

- (IBAction)okButton
{
    [self.navigationController popViewControllerAnimated:YES];
    self.editingVisa.days=self.selectedDays;
    //NSLog(@"Save: %@ segment AND %@ days",self.selectedType,self.selectedDays);
    self.editingVisa.multiEntryType = self.selectedType;
    self.editingVisa.typeABC=[NSString stringByVisaType:self.selectedType];
    self.editingVisa.isDaysEdited=YES;
}


#pragma mark PickerViewDelegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    //NSLog(@"Days: %lu",(unsigned long)[self.days count]);
    return [self.days count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([self.days[row] isKindOfClass:[NSNumber class]]) {
        NSString *rowDays=[NSString stringWithFormat:@"%@", (NSNumber *)(self.days[row])];
        return rowDays;
    }else return nil;

}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedDays=self.days[row];
    self.dayRussianLabel.text=[NSString stringByRussianFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue: ++row];
    
}


-(void) updateUI
{
    NSInteger row= [self.selectedDays integerValue]-1;
    NSInteger component=0;
    [self.daysPicker selectRow:row inComponent:component animated:NO];
    self.dayRussianLabel.text=[NSString stringByRussianFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue: ++row];
    self.segmentType.selectedSegmentIndex=[self.selectedType integerValue];
}

-(void) changeSegment: (id) sender
{
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        self.selectedType=[NSNumber numberWithInteger: self.segmentType.selectedSegmentIndex];
        
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}
-(void)viewDidLoad
{
    [super viewDidLoad];

    if (self.editingVisa.multiEntryType && [self.editingVisa.multiEntryType integerValue]>=0 && [self.editingVisa.multiEntryType integerValue]<=2) {
        self.selectedType=self.editingVisa.multiEntryType;
    }
    else self.selectedType=@2;
    
    NSNumber *maxDays=[NSNumber numberWithInteger:[NSDate daysFromDate:self.editingVisa.startDate toDate:self.editingVisa.endDate]];
    if (self.editingVisa.days) {
        if ([maxDays integerValue]>=90) self.selectedDays=self.editingVisa.days;
        else if ([maxDays integerValue] > 0) {
            if ([maxDays integerValue] > [self.editingVisa.days integerValue]) {
                self.selectedDays=self.editingVisa.days;
            } else self.selectedDays=maxDays;
        }
        else self.selectedDays=@90;
        //NSLog(@"MAX:%@",self.selectedDays);

    }
    else {
        if ([maxDays integerValue]>=90) self.selectedDays=@90;
        else if ([maxDays integerValue]>0) self.selectedDays=maxDays;
        else self.selectedDays=@90;
    }
    [self.segmentType addTarget:self action:@selector(changeSegment:) forControlEvents:UIControlEventValueChanged];
}

@end
