//
//  TripAddVC.h
//  MultiTest
//
//  Created by Administrator on 08.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddVC.h"
#import "User.h"
#import "Trip.h"
#import "TripTemp.h"
#import "AddButtonsActions.h"

@interface TripAddVC : AddVC <AddButtonsActions>
                            //isCreating
                            //managedObjectContext
                            //-animateAppearsButton:
@property (strong,nonatomic) User *userEditingTrip;
@property (strong,nonatomic) Trip *trip;
@property (strong,nonatomic) TripTemp *editingTrip;
@end
