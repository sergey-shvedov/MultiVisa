//
//  VisaFormStartDateVC.h
//  MultiTest
//
//  Created by Administrator on 04.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisaTemp.h"

@interface VisaFormStartDateVC : UIViewController
@property (nonatomic) BOOL isStartDateNeedEdit;
@property (nonatomic) BOOL isStartDateEdited;

@property (strong,nonatomic) VisaTemp *editingVisa;

@end
