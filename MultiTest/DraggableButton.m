//
//  DraggableButton.m
//  MultiTest
//
//  Created by Administrator on 26.06.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "DraggableButton.h"

@interface DraggableButton()
@property BOOL isDragging;
@end

@implementation DraggableButton


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //NSLog(@"RESPONDER: %@",self.nextResponder);
    [self.nextResponder touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.isDragging=YES;
    [self.nextResponder touchesMoved:touches withEvent:event];
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nextResponder touchesEnded:touches withEvent:event];
    if (!self.isDragging) {
        [super touchesEnded:touches withEvent:event];
    }else{
        [super touchesCancelled:touches withEvent:event];
    }
    
    self.isDragging=NO;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
