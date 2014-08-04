//
//  AddButtonsActions.h
//  MultiTest
//
//  Created by Administrator on 08.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddButtonsActions <NSObject>
-(void) clickCancel:(id) sender;
-(void) clickOKForCreate: (id) sender;
-(void) clickOKForSave: (id) sender;
@end
