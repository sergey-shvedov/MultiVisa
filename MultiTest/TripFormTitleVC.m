//
//  TripFormTitleVC.m
//  MultiTest
//
//  Created by Administrator on 08.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "TripFormTitleVC.h"

@interface TripFormTitleVC ()
@property (weak, nonatomic) IBOutlet UITextField *textfieldTitle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentType;
@property (strong,nonatomic) NSNumber *selectedType;
@property (strong,nonatomic) NSString *selectedText;
@end

@implementation TripFormTitleVC
- (IBAction)okButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    self.editingTrip.type = self.selectedType;
    if ([self.selectedText length]) {
        self.editingTrip.title=self.selectedText;
        self.editingTrip.isTitleEdited=YES;
        self.editingTrip.isTitleNeedEdit=NO;
    }
    

}



#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.selectedText=self.textfieldTitle.text;
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
    self.textfieldTitle.delegate=self;
    if (self.editingTrip.type && [self.editingTrip.type integerValue]>=0 && [self.editingTrip.type integerValue]<=2) {
        self.selectedType=self.editingTrip.type;
    }else self.selectedType=@2;
    [self.segmentType addTarget:self action:@selector(changeSegment:) forControlEvents:UIControlEventValueChanged];
    if (self.editingTrip.isTitleEdited) {
        self.textfieldTitle.text=self.editingTrip.title;
    }
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
