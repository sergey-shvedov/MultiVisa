//
//  TripFormTitleVC.h
//  MultiTest
//
//  Created by Administrator on 08.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripTemp.h"

@interface TripFormTitleVC : UIViewController <UITextFieldDelegate>
@property (strong,nonatomic) TripTemp *editingTrip;
@end
