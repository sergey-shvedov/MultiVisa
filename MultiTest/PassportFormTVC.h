//
//  PassportFormTVC.h
//  MultiTest
//
//  Created by Administrator on 09.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Passport.h"
#import "PassportTemp.h"
#import "PassportAddVC.h"

@interface PassportFormTVC : UITableViewController
@property (strong,nonatomic) Passport *passport;
@property (strong,nonatomic) PassportTemp *editingPassport;
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContect;
@property BOOL isCreating;

@property (nonatomic,strong) PassportAddVC *passportaddvc;
@end
