//
//  VisaFormCountryVC.m
//  MultiTest
//
//  Created by Administrator on 30.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "VisaFormCountryVC.h"
#import "Country+Create.h"
#import "VisaAddVC.h"

@interface VisaFormCountryVC ()
@property (weak, nonatomic) IBOutlet UIPickerView *countryPicker;
@property (strong,nonatomic) Country *selectedCountry;
@end

@implementation VisaFormCountryVC
#pragma mark UI Stuff
- (IBAction)okButton {
    [self.navigationController popViewControllerAnimated:YES];
    self.editingVisa.forCountry=self.selectedCountry;
    self.editingVisa.isCountryEdited=YES;
}

-(void) updateUI
{
    NSInteger row=[self.selectedCountry rowOfCountryArray:self.countries];
    NSInteger component=0;
    
    [self.countryPicker selectRow:row inComponent:component animated:NO];
}


#pragma mark DID - WILL Stuff

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.countryPicker.dataSource=self;
//    self.countryPicker.delegate=self;
//    self.source=[NSMutableArray arrayWithArray:self.countries];
    [self updateUI];
    
}
-(void)viewDidLoad
{
    self.selectedCountry=self.editingVisa.forCountry;
    [super viewDidLoad];
    

}


#pragma mark Setting

-(void)setCounties:(NSArray *)countries{
    _countries=countries;
    [self updateUI];
}


#pragma mark PickerView Delegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //NSLog(@"COUNT COUNTRIES, %i",(int)[self.countries count]);
    return [self.countries count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([self.countries[row] isKindOfClass:[Country class]]) {
        Country *rowCountry=(Country *)self.countries[row];
        //NSLog(@"rowCountry:%@",rowCountry.titleRUS);
        return rowCountry.titleRUS;
    }else return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedCountry=self.countries[row];
    //NSLog(@"ROW:%ld",(long)row);
}






@end
