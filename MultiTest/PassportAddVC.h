//
//  PassportAddVC.h
//  MultiTest
//
//  Created by Administrator on 09.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "AddVC.h"
#import "User.h"
#import "Passport.h"
#import "PassportTemp.h"

@interface PassportAddVC : AddVC <AddButtonsActions, UIAlertViewDelegate>
                                //isCreating
                                //managedObjectContext
                                //-animateAppearsButton:
@property (strong,nonatomic) User *userEditingPassport;
@property (strong,nonatomic) Passport *passport;
@property (strong,nonatomic) PassportTemp *editingPassport;
@end
