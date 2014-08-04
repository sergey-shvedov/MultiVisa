//
//  User+Create.m
//  MultiTest
//
//  Created by Administrator on 08.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "User+Create.h"

@implementation User (Create)
+(User *)mainUserInContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate=[NSPredicate predicateWithFormat:@"name = %@", @"Main User"];
    NSError *error;
    NSArray *users=[context executeFetchRequest:request error:&error];
    //NSLog(@"%@",users);
    
    if ([users count] == 0) {
        User *user=[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        user.name=@"Main User";
        //NSLog(@"Create new user");
        return user;
    }else{
        //NSLog(@"User already exists: %@", ((User *)users[0]).name);
        return ((User *)users[0]);
    }

}
@end
