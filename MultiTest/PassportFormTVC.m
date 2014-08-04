//
//  PassportFormTVC.m
//  MultiTest
//
//  Created by Administrator on 09.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "PassportFormTVC.h"
#import "UIColor+Project.h"
#import "NSString+Project.h"
#import "PassportFormIssueDateVC.h"
#import "PassportFormExperationDateVC.h"
#import "PassportFormTypeVC.h"
#import "NSDateFormatter+Project.h"

@interface PassportFormTVC ()
@property (weak, nonatomic) IBOutlet UITableViewCell *issueDateFormCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *experationDateFormCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *typeFormCell;


@property (strong,nonatomic) UIImage *disclosureYellow;
@property (strong,nonatomic) UIImage *disclosureGrey;
@end

@implementation PassportFormTVC

/////////////////////////////////////////////
#pragma mark - Update UI


-(void) updateUI
{

    
    //Entry date
    self.issueDateFormCell.detailTextLabel.text=[NSDateFormatter multiVisaLocalizedStringFromDate:self.editingPassport.issueDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    if (self.editingPassport.isIssueDateNeedEdit) {
        self.issueDateFormCell.detailTextLabel.textColor=[UIColor colorNeedEdit];
        self.issueDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureYellow];
    }else if (self.editingPassport.isIssueDateEdited) {
        self.issueDateFormCell.detailTextLabel.textColor=[UIColor colorEdited];
        self.issueDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }else{
        self.issueDateFormCell.detailTextLabel.textColor=[UIColor colorNotYetEdit];
        self.issueDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }
    

    
    //Out date
    self.experationDateFormCell.detailTextLabel.text=[NSDateFormatter multiVisaLocalizedStringFromDate:self.editingPassport.experationDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    if (self.editingPassport.isExperationDateNeedEdit) {
        self.experationDateFormCell.detailTextLabel.textColor=[UIColor colorNeedEdit];
        self.experationDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureYellow];
    }else if (self.editingPassport.isExperationDateEdited) {
        self.experationDateFormCell.detailTextLabel.textColor=[UIColor colorEdited];
        self.experationDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }else{
        self.experationDateFormCell.detailTextLabel.textColor=[UIColor colorNotYetEdit];
        self.experationDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }
    
    //Type
    
    self.typeFormCell.detailTextLabel.text=[NSString stringByPassportType:self.editingPassport.type];
    if (self.editingPassport.isTypeNeedEdit) {
        self.typeFormCell.detailTextLabel.textColor=[UIColor colorNeedEdit];
        self.typeFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureYellow];
    }else if (self.editingPassport.isTypeEdited) {
        self.typeFormCell.detailTextLabel.textColor=[UIColor colorEdited];
        self.typeFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }else{
        self.typeFormCell.detailTextLabel.textColor=[UIColor colorNotYetEdit];
        self.typeFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }
    
    
    
    //Buttons
    if (self.editingPassport.isNeedToEdit) {
        self.passportaddvc.buttonOk.isNeedEdit=YES;
    }else{
        self.passportaddvc.buttonOk.isNeedEdit=NO;
    }
    [self.passportaddvc appearButtons];
}

/////////////////////////////////////////////
#pragma mark - Prepare For Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    
    if ([segue.identifier isEqualToString:@"Passport IssueDate Form"]) {
        if ([segue.destinationViewController isKindOfClass:[PassportFormIssueDateVC class]]) {
            PassportFormIssueDateVC *pfidVC=(PassportFormIssueDateVC *)segue.destinationViewController;
            pfidVC.editingPassport=self.editingPassport;
            [self.passportaddvc dismissButtons];
        }
    }
    
    
    if ([segue.identifier isEqualToString:@"Passport ExperationDate Form"]) {
        if ([segue.destinationViewController isKindOfClass:[PassportFormExperationDateVC class]]) {
            PassportFormExperationDateVC *pfedVC=(PassportFormExperationDateVC *)segue.destinationViewController;
            pfedVC.editingPassport=self.editingPassport;
        
            [self.passportaddvc dismissButtons];
        }
    }
    
    if ([segue.identifier isEqualToString:@"Passport Type Form"]) {
        if ([segue.destinationViewController isKindOfClass:[PassportFormTypeVC class]]) {
            PassportFormTypeVC *pftVC=(PassportFormTypeVC *)segue.destinationViewController;
            pftVC.editingPassport=self.editingPassport;
            [self.passportaddvc dismissButtons];
        }
    }
}

/////////////////////////////////////////////
#pragma mark - DID-WILL Methods
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    //Hidden navigation bar separator
    if ([self.navigationController.navigationBar isKindOfClass:[UINavigationBar class]]) {
        
        UINavigationBar *navigationBar=self.navigationController.navigationBar;
        [navigationBar setBackgroundImage:[UIImage new]
                           forBarPosition:UIBarPositionAny
                               barMetrics:UIBarMetricsDefault];
        navigationBar.shadowImage=[UIImage imageNamed:@"barButtonShadowWhiteImage"];
    }
    //Hidde Cells here...
    
    
    //Settings for editing trip
    self.disclosureYellow=[UIImage imageNamed:@"yellow_disclosure"];
    self.disclosureGrey=[UIImage imageNamed:@"grey_disclosure"];
}



@end
