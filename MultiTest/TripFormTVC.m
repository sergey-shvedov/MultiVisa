//
//  TripFormTVC.m
//  MultiTest
//
//  Created by Administrator on 08.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "TripFormTVC.h"
#import "TripFormEntryCountyVC.h"
#import "TripFormEntryDateVC.h"
#import "TripFormOutCountyVC.h"
#import "TripFormOutDateVC.h"
#import "TripFormTitleVC.h"
#import "Country+Create.h"
#import "UIColor+Project.h"
#import "NSDateFormatter+Project.h"

@interface TripFormTVC ()
@property (weak, nonatomic) IBOutlet UITableViewCell *entryCountryFormCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *entryDateFormCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *outCountryFormCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *outDateFormCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *titleFormCell;

@property (strong,nonatomic) UIImage *disclosureYellow;
@property (strong,nonatomic) UIImage *disclosureGrey;
@end

@implementation TripFormTVC
/////////////////////////////////////////////
#pragma mark - Update UI


-(void) updateUI
{
    //Entry Country
    self.entryCountryFormCell.detailTextLabel.text=self.editingTrip.entryCountry.titleRUS;
    if (self.editingTrip.isEntryCountryNeedEdit) {
        self.entryCountryFormCell.detailTextLabel.textColor=[UIColor colorNeedEdit];
        self.entryCountryFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureYellow];
    }else if (self.editingTrip.isEntryCountryEdited) {
        self.entryCountryFormCell.detailTextLabel.textColor=[UIColor colorEdited];
        self.entryCountryFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }else{
        self.entryCountryFormCell.detailTextLabel.textColor=[UIColor colorNotYetEdit];
        self.entryCountryFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }
    
    //Entry date
    self.entryDateFormCell.detailTextLabel.text=[NSDateFormatter multiVisaLocalizedStringFromDate:self.editingTrip.entryDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    if (self.editingTrip.isEntryDateNeedEdit) {
        self.entryDateFormCell.detailTextLabel.textColor=[UIColor colorNeedEdit];
        self.entryDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureYellow];
    }else if (self.editingTrip.isEntryDateEdited) {
        self.entryDateFormCell.detailTextLabel.textColor=[UIColor colorEdited];
        self.entryDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }else{
        self.entryDateFormCell.detailTextLabel.textColor=[UIColor colorNotYetEdit];
        self.entryDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }
    
    //Out Country
    self.outCountryFormCell.detailTextLabel.text=self.editingTrip.outCountry.titleRUS;
    if (self.editingTrip.isOutCountryNeedEdit) {
        self.outCountryFormCell.detailTextLabel.textColor=[UIColor colorNeedEdit];
        self.outCountryFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureYellow];
    }else if (self.editingTrip.isOutCountryEdited) {
        self.outCountryFormCell.detailTextLabel.textColor=[UIColor colorEdited];
        self.outCountryFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }else{
        self.outCountryFormCell.detailTextLabel.textColor=[UIColor colorNotYetEdit];
        self.outCountryFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }
    
    //Out date
    self.outDateFormCell.detailTextLabel.text=[NSDateFormatter multiVisaLocalizedStringFromDate:self.editingTrip.outDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    if (self.editingTrip.isOutDateNeedEdit) {
        self.outDateFormCell.detailTextLabel.textColor=[UIColor colorNeedEdit];
        self.outDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureYellow];
    }else if (self.editingTrip.isOutDateEdited) {
        self.outDateFormCell.detailTextLabel.textColor=[UIColor colorEdited];
        self.outDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }else{
        self.outDateFormCell.detailTextLabel.textColor=[UIColor colorNotYetEdit];
        self.outDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }
    
    //Title
    self.titleFormCell.detailTextLabel.text=self.editingTrip.title;
    if (self.editingTrip.isTitleNeedEdit) {
        self.titleFormCell.detailTextLabel.textColor=[UIColor colorNeedEdit];
        self.titleFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureYellow];
    }else if (self.editingTrip.isTitleEdited) {
        self.titleFormCell.detailTextLabel.textColor=[UIColor colorEdited];
        self.titleFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }else{
        self.titleFormCell.detailTextLabel.textColor=[UIColor colorNotYetEdit];
        self.titleFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }
    
    
    
    //Buttons
    if (self.editingTrip.isNeedToEdit) {
        self.tripaddvc.buttonOk.isNeedEdit=YES;
    }else{
        self.tripaddvc.buttonOk.isNeedEdit=NO;
    }
    [self.tripaddvc appearButtons];
}

/////////////////////////////////////////////
#pragma mark - Prepare For Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Trip EntryCountry Form"]) {
        if ([segue.destinationViewController isKindOfClass:[TripFormEntryCountyVC class]]) {
            
            TripFormEntryCountyVC *tfecVC=(TripFormEntryCountyVC *)segue.destinationViewController;
            
            tfecVC.editingTrip=self.editingTrip;
            
            NSArray *mathes= [Country standartRequestResultsInContext:self.saveContect];
            
            if (mathes) {
                tfecVC.countries=mathes;
                //NSLog(@"prepareForSegue: Trip EntryCountry Form");
            }
            [self.tripaddvc dismissButtons];
            
        }
    }
    
    if ([segue.identifier isEqualToString:@"Trip EntryDate Form"]) {
        if ([segue.destinationViewController isKindOfClass:[TripFormEntryDateVC class]]) {
            TripFormEntryDateVC *tfedVC=(TripFormEntryDateVC *)segue.destinationViewController;
            tfedVC.editingTrip=self.editingTrip;
            [self.tripaddvc dismissButtons];
        }
    }
    
    if ([segue.identifier isEqualToString:@"Trip OutCountry Form"]) {
        if ([segue.destinationViewController isKindOfClass:[TripFormOutCountyVC class]]) {
            
            TripFormOutCountyVC *tfocVC=(TripFormOutCountyVC *)segue.destinationViewController;
            
            tfocVC.editingTrip=self.editingTrip;
            
            NSArray *mathes= [Country standartRequestResultsInContext:self.saveContect];
            
            if (mathes) {
                tfocVC.countries=mathes;
                //NSLog(@"prepareForSegue: Trip OutCountry Form");
            }
            [self.tripaddvc dismissButtons];
            
        }
    }
    
    if ([segue.identifier isEqualToString:@"Trip OutDate Form"]) {
        if ([segue.destinationViewController isKindOfClass:[TripFormOutDateVC class]]) {
            TripFormOutDateVC *tfodVC=(TripFormOutDateVC *)segue.destinationViewController;
            tfodVC.editingTrip=self.editingTrip;
            [self.tripaddvc dismissButtons];
        }
    }
    
    if ([segue.identifier isEqualToString:@"Trip Title Form"]) {
        if ([segue.destinationViewController isKindOfClass:[TripFormTitleVC class]]) {
            TripFormTitleVC *tftVC=(TripFormTitleVC *)segue.destinationViewController;
            tftVC.editingTrip=self.editingTrip;
            [self.tripaddvc dismissButtons];
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
