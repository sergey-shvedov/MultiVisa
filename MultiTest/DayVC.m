//
//  DayVC.m
//  MultiTest
//
//  Created by Administrator on 13.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "DayVC.h"

@interface DayVC ()
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation DayVC

-(void) updateUI
{
    if (self.day){
        self.testLabel.text=[NSString stringWithFormat:@"%@",self.day.day];
        
    }
    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

@end
