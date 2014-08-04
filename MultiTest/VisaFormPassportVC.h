//
//  VisaFormPassportVC.h
//  MultiTest
//
//  Created by Administrator on 07.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisaTemp.h"

@interface VisaFormPassportVC : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic) BOOL isPassportNeedEdit;
@property (nonatomic) BOOL isPassportEdited;
@property (strong,nonatomic) NSArray *passports;
@property (strong,nonatomic) VisaTemp *editingVisa;
@end
