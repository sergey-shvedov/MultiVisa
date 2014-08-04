//
//  VisaFormTVC.m
//  MultiTest
//
//  Created by Administrator on 30.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "VisaFormTVC.h"
#import "VisaFormCountryVC.h"
#import "VisaFormStartDateVC.h"
#import "VisaFormEndDateVC.h"
#import "VisaFormDaysVC.h"
#import "VisaFormPassportVC.h"
#import "UIColor+Project.h"
#import "Country+Create.h"
#import "Passport+Create.h"
#import "NSDate+Project.h"
#import "NSString+Project.h"
#import "NSDateFormatter+Project.h"

@interface VisaFormTVC ()
@property (weak, nonatomic) IBOutlet UITableViewCell *countryFormCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *startFormCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *endFormCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *typeFormCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *passportFormCell;
@property (strong,nonatomic) NSString *countryCellDText;
@property (strong,nonatomic) UIImage *disclosureYellow;
@property (strong,nonatomic) UIImage *disclosureGrey;

@end

@implementation VisaFormTVC

//Setting proprties with updating UI








//END
/////////////////////////////////////////////
#pragma mark - Update UI
-(void) updateUI
{
    //Country
    self.countryFormCell.detailTextLabel.text=self.editingVisa.forCountry.titleRUS;
    if (self.editingVisa.isCountryNeedEdit) {
        self.countryFormCell.detailTextLabel.textColor=[UIColor colorNeedEdit];
        self.countryFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureYellow];
    }else if (self.editingVisa.isCountryEdited) {
        self.countryFormCell.detailTextLabel.textColor=[UIColor colorEdited];
        self.countryFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }else{
        self.countryFormCell.detailTextLabel.textColor=[UIColor colorNotYetEdit];
        self.countryFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }
    
    //Start date
    self.startFormCell.detailTextLabel.text=[NSDateFormatter multiVisaLocalizedStringFromDate:self.editingVisa.startDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    if (self.editingVisa.isStartDateNeedEdit) {
        self.startFormCell.detailTextLabel.textColor=[UIColor colorNeedEdit];
        self.startFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureYellow];
    }else if (self.editingVisa.isStartDateEdited) {
        self.startFormCell.detailTextLabel.textColor=[UIColor colorEdited];
        self.startFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }else{
        self.startFormCell.detailTextLabel.textColor=[UIColor colorNotYetEdit];
        self.startFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }
    
    //End date
    self.endFormCell.detailTextLabel.text=[NSDateFormatter multiVisaLocalizedStringFromDate:self.editingVisa.endDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    if (self.editingVisa.isEndDateNeedEdit) {
        self.endFormCell.detailTextLabel.textColor=[UIColor colorNeedEdit];
        self.endFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureYellow];
    }else if (self.editingVisa.isEndDateEdited) {
        self.endFormCell.detailTextLabel.textColor=[UIColor colorEdited];
        self.endFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }else{
        self.endFormCell.detailTextLabel.textColor=[UIColor colorNotYetEdit];
        self.endFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }
    
    //Type
    if (!self.editingVisa.isStartDateNeedEdit && !self.editingVisa.isEndDateNeedEdit) {
        if ([NSDate daysFromDate:self.editingVisa.startDate toDate:self.editingVisa.endDate] < [self.editingVisa.days integerValue]) {
            self.editingVisa.isDaysNeedEdit=YES;
        } else self.editingVisa.isDaysNeedEdit=NO;
    }
    if ([self.editingVisa.days integerValue]<90) self.typeFormCell.detailTextLabel.text=[NSString stringWithFormat:@"%@ (%@ %@)",self.editingVisa.typeABC,self.editingVisa.days,[NSString stringByRussianFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue: [self.editingVisa.days integerValue]]];
    else self.typeFormCell.detailTextLabel.text=[NSString stringWithFormat:@"%@ (90/180)",self.editingVisa.typeABC];
    if (self.editingVisa.isDaysNeedEdit) {
        self.typeFormCell.detailTextLabel.textColor=[UIColor colorNeedEdit];
        self.typeFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureYellow];
    }else if (self.editingVisa.isDaysEdited) {
        self.typeFormCell.detailTextLabel.textColor=[UIColor colorEdited];
        self.typeFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }else{
        self.typeFormCell.detailTextLabel.textColor=[UIColor colorNotYetEdit];
        self.typeFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }
    
    //Passport
    NSString *sign=@"";
    if ([self.editingVisa.inPassport.number length]) {
        sign=@"№";
    }
    
    self.passportFormCell.detailTextLabel.text=[NSString stringWithFormat:@"%@ %@%@",[NSString stringByPassportType:self.editingVisa.inPassport.type], sign, self.editingVisa.inPassport.number];
    
    if (self.editingVisa.isPassportNeedEdit) {
        self.passportFormCell.detailTextLabel.textColor=[UIColor colorNeedEdit];
        self.passportFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureYellow];
    }else if (self.editingVisa.isPassportEdited) {
        self.passportFormCell.detailTextLabel.textColor=[UIColor colorEdited];
        self.passportFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }else{
        self.passportFormCell.detailTextLabel.textColor=[UIColor colorNotYetEdit];
        self.passportFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }
    if (100==[self.editingVisa.inPassport.type integerValue]) {
        self.passportFormCell.detailTextLabel.textColor=[UIColor colorNotYetEdit];
        self.passportFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
    }
    
    //Buttons
    if (self.editingVisa.isNeedToEdit) {
        self.visaaddvc.buttonOk.isNeedEdit=YES;
    }else{
        self.visaaddvc.buttonOk.isNeedEdit=NO;
    }
    [self.visaaddvc appearButtons];
    
}



/////////////////////////////////////////////
#pragma mark - Prepare For Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"Visa Country Form"]) {
        if ([segue.destinationViewController isKindOfClass:[VisaFormCountryVC class]]) {
            
            VisaFormCountryVC *vfcVC=(VisaFormCountryVC *)segue.destinationViewController;

            vfcVC.editingVisa=self.editingVisa;
            
            NSFetchRequest *request=[Country standartRequest];
            NSError *error;
            
            NSArray *mathes= [self.saveContect executeFetchRequest:request error:&error];
            
            if (mathes) {
                vfcVC.countries=mathes;
            }
            [self.visaaddvc dismissButtons];
        }
    }
    if ([segue.identifier isEqualToString:@"Visa StartDate Form"]) {
        if ([segue.destinationViewController isKindOfClass:[VisaFormStartDateVC class]]) {
            
            VisaFormStartDateVC *vfsdVC=(VisaFormStartDateVC *)segue.destinationViewController;

            vfsdVC.editingVisa=self.editingVisa;
            

            [self.visaaddvc dismissButtons];
        }
    }
    if ([segue.identifier isEqualToString:@"Visa EndDate Form"]) {
        if ([segue.destinationViewController isKindOfClass:[VisaFormEndDateVC class]]) {
            
            VisaFormEndDateVC *vfedVC=(VisaFormEndDateVC *)segue.destinationViewController;

            vfedVC.editingVisa=self.editingVisa;
            
            
            [self.visaaddvc dismissButtons];
        }
    }
    if ([segue.identifier isEqualToString:@"Visa Type Form"]) {
        if ([segue.destinationViewController isKindOfClass:[VisaFormDaysVC class]]) {
            
            VisaFormDaysVC *vfdVC= (VisaFormDaysVC *)segue.destinationViewController;
            vfdVC.editingVisa=self.editingVisa;
            
            NSInteger number=90;
            if (([NSDate daysFromDate:self.editingVisa.startDate toDate:self.editingVisa.endDate] < number) && ([NSDate daysFromDate:self.editingVisa.startDate toDate:self.editingVisa.endDate] > 0)) {
                number = [NSDate daysFromDate:self.editingVisa.startDate toDate:self.editingVisa.endDate];
            }
            
            NSMutableArray *days = [[NSMutableArray alloc] init];
            for (int i=0; i<number; i++) {
                [days insertObject:[NSNumber numberWithInt:(i+1)] atIndex:i];
            }
            
            vfdVC.days=days;


            [self.visaaddvc dismissButtons];
        }
    }
    if ([segue.identifier isEqualToString:@"Visa Passport Form"]) {
        if ([segue.destinationViewController isKindOfClass:[VisaFormPassportVC class]]) {
            
            VisaFormPassportVC *vfpVC=(VisaFormPassportVC *)segue.destinationViewController;
            vfpVC.editingVisa=self.editingVisa;
            
            
            NSArray *mathes= [Passport standartRequestResultsInContext:self.saveContect];
            
            if (mathes) {
                vfpVC.passports=mathes;
            }
            [self.visaaddvc dismissButtons];
        }
    }
   
    
}



/////////////////////////////////////////////
#pragma mark - DID-WILL Methods
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isCreating) {
        [self resetTextToCreating];
    }
    [self updateUI];
    //NSLog(@"ViewWillAppear");
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
    //Hidden Passport if...
//    if (1 == [[Passport standartRequestResultsInContext:self.saveContect] count]) {
//        self.passportFormCell.hidden=YES;
//    } else self.passportFormCell.hidden=NO;

    self.passportFormCell.hidden=YES; //Do not need for now, Lets hide
    
    //Settings for editing visa
    if (!self.isCreating)[self prepareForEditVisa];
    self.disclosureYellow=[UIImage imageNamed:@"yellow_disclosure"];
    self.disclosureGrey=[UIImage imageNamed:@"grey_disclosure"];
}

/////////////////////////////////////////////

-(void)awakeFromNib
{
    //NSLog(@"awakeFromNib VisaFormTVC");
}
-(void) resetTextToCreating
{
    
}


-(void)prepareForEditVisa
{
    
}

@end
