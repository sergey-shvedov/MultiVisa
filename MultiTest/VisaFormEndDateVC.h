//
//  VisaFormEndDateVC.h
//  MultiTest
//
//  Created by Administrator on 04.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisaTemp.h"

@interface VisaFormEndDateVC : UIViewController
@property (nonatomic) BOOL isEndDateNeedEdit;
@property (nonatomic) BOOL isEndDateEdited;

@property (strong,nonatomic) VisaTemp *editingVisa;
@end
