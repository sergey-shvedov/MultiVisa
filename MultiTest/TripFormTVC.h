//
//  TripFormTVC.h
//  MultiTest
//
//  Created by Administrator on 08.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trip.h"
#import "TripTemp.h"
#import "TripAddVC.h"

@interface TripFormTVC : UITableViewController
@property (strong,nonatomic) Trip *trip;
@property (strong,nonatomic) TripTemp *editingTrip;
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContect;
@property (strong,nonatomic) NSManagedObjectContext *saveContect;
@property BOOL isCreating;

@property (nonatomic,strong) TripAddVC *tripaddvc;
@end
