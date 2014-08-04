//
//  VisaFormDaysVC.h
//  MultiTest
//
//  Created by Administrator on 06.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisaTemp.h"
#import "NSString+Project.h"

@interface VisaFormDaysVC : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic) BOOL isVisaTypeNeedEdit;
@property (nonatomic) BOOL isVisaTypeEdited;
@property (nonatomic) BOOL isDaysNeedEdit;
@property (nonatomic) BOOL isDaysEdited;

@property (strong,nonatomic) NSArray *days;

@property (strong,nonatomic) VisaTemp *editingVisa;


@end
