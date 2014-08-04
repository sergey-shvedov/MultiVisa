//
//  DraggableTodayView.m
//  MultiTest
//
//  Created by Administrator on 26.06.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "DraggableTodayView.h"

@interface  DraggableTodayView()
@property float xTouch;

@property BOOL isDragging;
@end

@implementation DraggableTodayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"RESPONDER: %@",self.nextResponder);
    [self.nextResponder touchesBegan:touches withEvent:event];
}
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.superview];
    if (!self.isDragging) {
        self.xTouch=location.x;
        self.isDragging=YES;
    }
    
       [UIView beginAnimations:@"Dragging A DraggableView" context:nil];
    if ((location.x-self.xTouch) > 0.0) {
        self.frame = CGRectMake(0.0, self.frame.origin.y,
                            self.frame.size.width, self.frame.size.height);
    }else{
        self.frame = CGRectMake(location.x-self.xTouch, self.frame.origin.y,
                                self.frame.size.width, self.frame.size.height);
    }
    
    [UIView commitAnimations];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.isDragging=NO;
    if (self.frame.origin.x < -50.0) {
        [UIView beginAnimations:@"Dragging A DraggableView" context:nil];
        self.frame = CGRectMake(-275.0, self.frame.origin.y,
                                self.frame.size.width, self.frame.size.height);
        [UIView commitAnimations];
        self.currentX=self.frame.origin.x;
        if ([self.calendarVC isKindOfClass:[CalendarVC class]]) {
            [self.calendarVC setupClosingDraggableView];
        }
    }else{
        [UIView beginAnimations:@"Dragging A DraggableView" context:nil];
        self.frame = CGRectMake(0.0, self.frame.origin.y,
                                self.frame.size.width, self.frame.size.height);
        [UIView commitAnimations];
        self.currentX=0.0;
        if ([self.calendarVC isKindOfClass:[CalendarVC class]]) {
            [self.calendarVC setupOpeningDraggableView];
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
