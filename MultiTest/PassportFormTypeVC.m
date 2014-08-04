//
//  PassportFormTypeVC.m
//  MultiTest
//
//  Created by Administrator on 09.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "PassportFormTypeVC.h"

@interface PassportFormTypeVC ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentType;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNumber;
@property (strong,nonatomic) NSNumber *selectedType;
@property (strong,nonatomic) NSString *selectedText;
@end

@implementation PassportFormTypeVC
- (IBAction)okButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    self.editingPassport.type = self.selectedType;
    if ([self.selectedText length]) {
        self.editingPassport.number= self.selectedText;
        self.editingPassport.isTypeNeedEdit=NO;
    }
    self.editingPassport.isTypeEdited=YES;
}



#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.selectedText=self.textFieldNumber.text;
}
///////////////////////////////////




-(void) changeSegment: (id) sender
{
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        self.selectedType=[NSNumber numberWithInteger: self.segmentType.selectedSegmentIndex];
        
    }
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.textFieldNumber.delegate=self;
    if (self.editingPassport.type && [self.editingPassport.type integerValue]>=0 && [self.editingPassport.type integerValue]<=1) {
        self.selectedType=self.editingPassport.type;
    }else self.selectedType=@1;
    [self.segmentType addTarget:self action:@selector(changeSegment:) forControlEvents:UIControlEventValueChanged];
    if (self.editingPassport.isTypeEdited) {
        self.textFieldNumber.text=[NSString stringWithFormat:@"%@",self.editingPassport.number];
    }
    //NSLog(@"SEGMENT:%@",self.selectedType);
    self.selectedText=nil;
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}
-(void) updateUI
{
    self.segmentType.selectedSegmentIndex=[self.selectedType integerValue];
}



@end
