//
//  VisaAddVC.h
//  MultiTest
//
//  Created by Administrator on 30.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Visa.h"
#import "AddVC.h"
#import "VisaTemp.h"

@interface VisaAddVC : AddVC <AddButtonsActions>
                           //isCreating
                           //managedObjectContext
                           //-animateAppearsButton:
@property (strong,nonatomic) User *userEditingVisa;
@property (strong,nonatomic) Visa *visa;
@property (strong,nonatomic) VisaTemp *editingVisa;

@end