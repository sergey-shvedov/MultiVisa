//
//  VisaFormTVC.h
//  MultiTest
//
//  Created by Administrator on 30.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Visa.h"
#import "VisaAddVC.h"
#import "Country.h"
#import "VisaTemp.h"

@interface VisaFormTVC : UITableViewController
@property (strong,nonatomic) Visa *visa;
@property (strong,nonatomic) VisaTemp *editingVisa;
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContect;
@property (strong,nonatomic) NSManagedObjectContext *saveContect;
@property BOOL isCreating;


@property (nonatomic,strong) VisaAddVC *visaaddvc;
//@property (nonatomic,strong) Country *selectedCountry;

@end
