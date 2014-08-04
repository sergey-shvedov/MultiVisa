//
//  VisaFormCountryVC.h
//  MultiTest
//
//  Created by Administrator on 30.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Visa.h"
#import "VisaTemp.h"

@interface VisaFormCountryVC : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic) BOOL isCountryNeedEdit;
@property (nonatomic) BOOL isCountryEdited;
@property (strong,nonatomic) NSArray *countries;
@property (strong,nonatomic) VisaTemp *editingVisa;
//@property (nonatomic,retain) NSMutableArray *source;
@end
