//
//  PassportFormTypeVC.h
//  MultiTest
//
//  Created by Administrator on 09.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassportTemp.h"

@interface PassportFormTypeVC : UIViewController <UITextFieldDelegate>

@property (strong,nonatomic) PassportTemp *editingPassport;

@end
