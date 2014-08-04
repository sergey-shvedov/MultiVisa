//
//  TestCDTVC.h
//  MultiTest
//
//  Created by Administrator on 03.06.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import "User.h"

@interface TestCDTVC : CoreDataTableViewController

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) User *user;

@end
