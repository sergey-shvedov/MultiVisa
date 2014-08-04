//
//  VisaFormPassportVC.m
//  MultiTest
//
//  Created by Administrator on 07.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "VisaFormPassportVC.h"
#import "Passport+Create.h"

@interface VisaFormPassportVC ()
@property (weak, nonatomic) IBOutlet UIPickerView *pasportPicker;
@property (strong,nonatomic) Passport *selectedPassport;
@end

@implementation VisaFormPassportVC
#pragma mark UI Stuff
- (IBAction)okButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    self.editingVisa.inPassport=self.selectedPassport;
    self.editingVisa.isPassportEdited=YES;
}




-(void) updateUI
{
    NSInteger row=[self.selectedPassport rowOfPassportArray:self.passports];
    NSInteger component=0;
    
    [self.pasportPicker selectRow:row inComponent:component animated:NO];
}


#pragma mark DID - WILL Stuff

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
    
}
-(void)viewDidLoad
{
    if (self.editingVisa.inPassport) {
        self.selectedPassport=self.editingVisa.inPassport;
    }else{
        if ([[self.passports objectAtIndex:0] isKindOfClass:[Passport class]]) {
            self.selectedPassport=[self.passports objectAtIndex:0];
        }
    }
    self.selectedPassport=self.editingVisa.inPassport;
    [super viewDidLoad];
    
    
}


#pragma mark Setting




#pragma mark PickerView Delegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.passports count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([self.passports[row] isKindOfClass:[Passport class]]) {
        Passport *rowPassport=(Passport *)self.passports[row];
        return [NSString stringWithFormat:@"%@ №%@",rowPassport.type,rowPassport.number];
    }else return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedPassport=self.passports[row];
}


@end
