//
//  Passport+Create.h
//  MultiTest
//
//  Created by Administrator on 01.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "Passport.h"

@interface Passport (Create)
+(Passport *) mainPassportInContext:(NSManagedObjectContext *)context;
+(NSFetchRequest *) standartRequest;
+(NSArray *) standartRequestResultsInContext:(NSManagedObjectContext *) context;
-(NSInteger)rowOfPassportArray:(NSArray *)passports;
@end
