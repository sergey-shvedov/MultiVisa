//
//  MultiTestAppDelegate.h
//  MultiTest
//
//  Created by Administrator on 27.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiTestAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIManagedDocument *document;



///////////////////// Addition expensive FetchContext & SaveContext


@property (strong,nonatomic) NSManagedObjectContext *fetchContext;
@property (strong,nonatomic) NSManagedObjectContext *saveContext;


@end
