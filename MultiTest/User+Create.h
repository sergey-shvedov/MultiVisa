//
//  User+Create.h
//  MultiTest
//
//  Created by Administrator on 08.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "User.h"

@interface User (Create)
+(User *) mainUserInContext:(NSManagedObjectContext *) context;
@end
