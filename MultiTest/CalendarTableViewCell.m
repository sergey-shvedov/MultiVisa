//
//  CalendarTableViewCell.m
//  MultiTest
//
//  Created by Administrator on 27.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "CalendarTableViewCell.h"
#import "Day+Create.h"
#import "Day.h"
#import "UIColor+Project.h"
#import "NSDateFormatter+Project.h"

@interface CalendarTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *day1;
@property (weak, nonatomic) IBOutlet UIButton *day2;
@property (weak, nonatomic) IBOutlet UIButton *day3;
@property (weak, nonatomic) IBOutlet UIButton *day4;
@property (weak, nonatomic) IBOutlet UIButton *day5;
@property (weak, nonatomic) IBOutlet UIButton *day6;
@property (weak, nonatomic) IBOutlet UIButton *day7;
@property (weak, nonatomic) IBOutlet UIView *viewMonth;
@property (weak, nonatomic) IBOutlet UILabel *labelMonth;
@property (weak, nonatomic) IBOutlet UILabel *labelYear;

@property (nonatomic) BOOL isRotate;
@property (strong,nonatomic) NSDateFormatter *dateFormater;
@property (strong,nonatomic) NSArray *bkgImages;
@property (strong,nonatomic) NSArray *bkgOldImages;
@property (strong,nonatomic) NSArray *bkgAlertImages;
@property (strong,nonatomic) NSArray *bkgAlertEmptyImages;
@property (weak,nonatomic) UIImage *bkgTodayImage;
@property (weak,nonatomic) UIImage *bkgTodayTripImage;
@property (weak,nonatomic) UIImage *bkgTodayAlertImage;

@end

@implementation CalendarTableViewCell

-(NSDateFormatter *)dateFormater
{
    if (!_dateFormater) {
        NSDateFormatter *df=[NSDateFormatter multiVisaDateFormatter];
        _dateFormater=df;
    }
    return _dateFormater;
}
-(NSArray *)bkgImages
{
    if (!_bkgImages){
        
        NSMutableArray *array=[[NSMutableArray alloc]init];
        
        for (int i=0; i<7; i++) {
            UIImage *newImage=[UIImage imageNamed:@"bkgTrip"];
            if ([array count]<8 && newImage) {
                [array addObject:newImage];
            }
        }
        _bkgImages=[NSArray arrayWithArray:array];
    }
    return _bkgImages;

}
-(NSArray *)bkgOldImages
{
    if (!_bkgOldImages){
        
        NSMutableArray *array=[[NSMutableArray alloc]init];
        
        for (int i=0; i<7; i++) {
            UIImage *newImage=[UIImage imageNamed:@"bkgTripOld"];
            if ([array count]<8 && newImage) {
                [array addObject:newImage];
            }
        }
        _bkgOldImages=[NSArray arrayWithArray:array];
    }
    return _bkgOldImages;
    
}
-(NSArray *)bkgAlertImages
{
    if (!_bkgAlertImages){
        
        NSMutableArray *array=[[NSMutableArray alloc]init];
        
        for (int i=0; i<7; i++) {
            UIImage *newImage=[UIImage imageNamed:@"bkgTripAlert2"];
            if ([array count]<8 && newImage) {
                [array addObject:newImage];
            }
        }
        _bkgAlertImages=[NSArray arrayWithArray:array];
    }
    return _bkgAlertImages;
    
}
-(NSArray *)bkgAlertEmptyImages
{
    if (!_bkgAlertEmptyImages){
        
        NSMutableArray *array=[[NSMutableArray alloc]init];
        
        for (int i=0; i<7; i++) {
            UIImage *newImage=[UIImage imageNamed:@"bkgTripAlertEmptyC"];
            if ([array count]<8 && newImage) {
                [array addObject:newImage];
            }
        }
        _bkgAlertEmptyImages=[NSArray arrayWithArray:array];
    }
    return _bkgAlertEmptyImages;
    
}
-(UIImage*) bkgTodayImage
{
    if (!_bkgTodayImage) {
        _bkgTodayImage=[UIImage imageNamed:@"calendarToday"];
    }
    return _bkgTodayImage;
}
-(UIImage *) bkgTodayTripImage
{
    if (!_bkgTodayTripImage) {
        _bkgTodayTripImage=[UIImage imageNamed:@"bkgTripToday"];
    }
    return _bkgTodayTripImage;
}
-(UIImage *) bkgTodayAlertImage
{
    if (!_bkgTodayAlertImage) {
        _bkgTodayAlertImage=[UIImage imageNamed:@"bkgTripAlertToday2"];
    }
    return _bkgTodayAlertImage;
}

///////////////////////////////////////////////////////////////////////////////////////

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////

-(void)layoutSubviews
{
    //Get DAYs from week class to Array   //Get buttons to Array
    NSSortDescriptor *myDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"from2001" ascending:YES];
    NSArray *sorted = [self.week.days sortedArrayUsingDescriptors:[NSArray arrayWithObject:myDescriptor]];
    NSArray *buttons =@[self.day1,self.day2,self.day3,self.day4,self.day5,self.day6,self.day7];
    
    
    //Set backgrounds and fonts for buttons
    UIFont *new=[UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0];
    UIFont *newToday=[UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0];
    UIFont *old=[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20.0];
    //UIFont *forTrip=[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0];
    
    for (int i=0; i<7; i++) {
        //Set Title for button
        [[buttons objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%@",((Day *)sorted[i]).day] forState:UIControlStateNormal];
        
//#warning delete:
        //[[buttons objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%@",((Day *)sorted[i]).last180TripDays] forState:UIControlStateHighlighted];
        
        //k - background color "koefficient"
        float k = 1.0 - [((Day *)sorted[i]).day floatValue]/400.0;
        UIColor *standartColor=[UIColor colorWithRed:k green:k blue:k alpha:1.0];
        
        if ([[sorted objectAtIndex:i] isKindOfClass:[Day class]]){
            Day *day=(Day *)sorted[i];
            if ([day.last180TripDays integerValue] > 90 ){////////////////////////Set background color if alert
                
                UIColor *alertColor=[UIColor colorWithRed:k green:k blue:(k-0.1) alpha:1.0];
                
                if ([day.tripsByDay count] > 0) {                              //IS A TRIP ALERT DAY
                    if (self.todayFrom2001 && [[buttons objectAtIndex:i] isKindOfClass:[UIButton class]]){//FOR TIME
                        
                        UIButton *button=(UIButton *)[buttons objectAtIndex:i];
                        [button setBackgroundColor:alertColor];
                        
                        if ([day.from2001 integerValue] < self.todayFrom2001) {
                            [button setTitleColor:[UIColor colorCalendarOldDate] forState:UIControlStateNormal];
                            [button.titleLabel setFont:old];
                            if ([self.bkgAlertImages[i] isKindOfClass:[UIImage class]]) {
                                [button setBackgroundImage:self.bkgAlertImages[i] forState:UIControlStateNormal];
                            }
                            if ([day.from2001 integerValue] == self.lookingDayFrom2001) {
                                [button setBackgroundImage:[UIImage imageNamed:@"bkgAlertLooking"] forState:UIControlStateNormal];
                            }
                            
                        }else if ([day.from2001 integerValue] == self.todayFrom2001){
                            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            [button.titleLabel setFont:newToday];
                            [button setBackgroundImage:self.bkgTodayAlertImage forState:UIControlStateNormal];
                            
                        }else{
                            [button setTitleColor:[UIColor colorCalendarNewDate] forState:UIControlStateNormal];
                            [button.titleLabel setFont:new];
                            if ([self.bkgAlertImages[i] isKindOfClass:[UIImage class]]) {
                                [button setBackgroundImage:self.bkgAlertImages[i] forState:UIControlStateNormal];
                            }
                            if ([day.from2001 integerValue] == self.lookingDayFrom2001) {
                                [button setBackgroundImage:[UIImage imageNamed:@"bkgAlertLookingNew"] forState:UIControlStateNormal];
                            }
                        }
                    }
                    
                }else{                                                       //IS ALERT NOT A TRIP DAY
                    if (self.todayFrom2001 && [[buttons objectAtIndex:i] isKindOfClass:[UIButton class]]){//FOR TIME
                        
                        UIButton *button=(UIButton *)[buttons objectAtIndex:i];
                        [button setBackgroundColor:alertColor];
                        [button setBackgroundImage:nil forState:UIControlStateNormal];
                        
                        if ([day.from2001 integerValue] < self.todayFrom2001) {
                            [button setTitleColor:[UIColor colorCalendarOldDate] forState:UIControlStateNormal];
                            [button.titleLabel setFont:old];
                            if ([day.from2001 integerValue] == self.lookingDayFrom2001) {
                                [button setBackgroundImage:[UIImage imageNamed:@"bkgLookingOld"] forState:UIControlStateNormal];
                            }
                            
                        }else if ([day.from2001 integerValue] == self.todayFrom2001){
                            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            [button.titleLabel setFont:newToday];
                            [button setBackgroundImage:self.bkgTodayImage forState:UIControlStateNormal];
                            
                        }else{
                            [button setTitleColor:[UIColor colorCalendarNewDate] forState:UIControlStateNormal];
                            [button.titleLabel setFont:new];
                            if ([day.from2001 integerValue] == self.lookingDayFrom2001) {
                                [button setBackgroundImage:[UIImage imageNamed:@"bkgLooking"] forState:UIControlStateNormal];
                            }
                            
                        }
                    }
                }
                
            }else{////////////////////////////////////////////////////////////Set background color if NOT alert
                
                if ([day.tripsByDay count] > 0) {                            //IS A TRIP DAY
                    if (self.todayFrom2001 && [[buttons objectAtIndex:i] isKindOfClass:[UIButton class]]){//FOR TIME
                        
                        UIButton *button=(UIButton *)[buttons objectAtIndex:i];
                        [button setBackgroundColor:standartColor];
                        
                        if ([day.from2001 integerValue] < self.todayFrom2001) {
                            [button setTitleColor:[UIColor colorCalendarOldDate] forState:UIControlStateNormal];
                            [button.titleLabel setFont:old];
                            if ([self.bkgImages[i] isKindOfClass:[UIImage class]]) {
                                [button setBackgroundImage:self.bkgImages[i] forState:UIControlStateNormal];
                            }
                            if ([day.from2001 integerValue] == self.lookingDayFrom2001) {
                                [button setBackgroundImage:[UIImage imageNamed:@"bkgTripLookingOld"] forState:UIControlStateNormal];
                            }
                            
                        }else if ([day.from2001 integerValue] == self.todayFrom2001){
                            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            [button.titleLabel setFont:newToday];
                            [button setBackgroundImage:self.bkgTodayTripImage forState:UIControlStateNormal];
                            
                        }else{
                            [button setTitleColor:[UIColor colorCalendarNewDate] forState:UIControlStateNormal];
                            [button.titleLabel setFont:new];
                            if ([self.bkgImages[i] isKindOfClass:[UIImage class]]) {
                                [button setBackgroundImage:self.bkgImages[i] forState:UIControlStateNormal];
                            }
                            if ([day.from2001 integerValue] == self.lookingDayFrom2001) {
                                [button setBackgroundImage:[UIImage imageNamed:@"bkgTripLooking"] forState:UIControlStateNormal];
                            }
                            
                        }
                    }
                    
                }else{                                                       //IS NOT A TRIP DAY
                    if (self.todayFrom2001 && [[buttons objectAtIndex:i] isKindOfClass:[UIButton class]]){//FOR TIME
                        
                        UIButton *button=(UIButton *)[buttons objectAtIndex:i];
                        [button setBackgroundColor:standartColor];
                        [button setBackgroundImage:nil forState:UIControlStateNormal];
                        
                        if ([day.from2001 integerValue] < self.todayFrom2001) {
                            [button setTitleColor:[UIColor colorCalendarOldDate] forState:UIControlStateNormal];
                            [button.titleLabel setFont:old];
                            if ([day.from2001 integerValue] == self.lookingDayFrom2001) {
                                [button setBackgroundImage:[UIImage imageNamed:@"bkgLookingOld"] forState:UIControlStateNormal];
                            }
                            
                        }else if ([day.from2001 integerValue] == self.todayFrom2001){
                            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            [button.titleLabel setFont:newToday];
                            [button setBackgroundImage:self.bkgTodayImage forState:UIControlStateNormal];
                            
                        }else{
                            [button setTitleColor:[UIColor colorCalendarNewDate] forState:UIControlStateNormal];
                            [button.titleLabel setFont:new];
                            if ([day.from2001 integerValue] == self.lookingDayFrom2001) {
                                [button setBackgroundImage:[UIImage imageNamed:@"bkgLooking"] forState:UIControlStateNormal];
                            }
                            
                        }
                    }
                    
                }
            }
            

            
        }
    }
    

    
    self.labelMonth.text= [[self.dateFormater standaloneMonthSymbols] objectAtIndex: ([self.week.mainMonth integerValue]-1)];
    if (1 == [self.week.mainMonth integerValue]){
        NSInteger myYear=[(((Day *)sorted[6]).year) integerValue]%100;
        if (myYear<10) {
            self.labelMonth.text=[NSString stringWithFormat:@"%@'0%ld", self.labelMonth.text, (long)myYear];
        }else{
        self.labelMonth.text=[NSString stringWithFormat:@"%@'%ld", self.labelMonth.text, (long)myYear];
        }
    }
    if (1 == [self.week.numberFromMonthBeginner integerValue]) {
        self.labelYear.text=[NSString stringWithFormat:@"%ld",(long)[((Day *)sorted[6]).year integerValue]];
        //if (1 == [((Day *)sorted[6]).month integerValue]){
        //     self.labelYear.textColor=[UIColor yellowColor];
        // }else self.labelYear.textColor=[UIColor whiteColor];
        self.labelYear.textColor=[UIColor whiteColor];
        
    }else self.labelYear.text=@"";
    
    
    if (!self.isRotate) {
        self.labelMonth.transform=CGAffineTransformRotate(self.labelMonth.transform, M_PI*1.5);
        self.labelYear.transform=CGAffineTransformRotate(self.labelYear.transform, M_PI*1.5);
        
        self.isRotate=YES;
    }
    
    [self.labelYear setFrame:CGRectMake(0.0, 0.0 , 10.0, 40.0)];
    [self.labelMonth setFrame:CGRectMake(5.0, 80.0-40.0*[self.week.numberFromMonthBeginner integerValue] , 20.0, 120.0)];
    
    
    

}


@end
