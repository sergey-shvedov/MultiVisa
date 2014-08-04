//
//  Vehicle+Create.h
//  MultiTest
//
//  Created by Administrator on 28.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "Vehicle.h"

@interface Vehicle (Create)
+(NSArray *) allVehiclesinContext: (NSManagedObjectContext *) context;
+(BOOL)isSetinContext:(NSManagedObjectContext *)context;
+(Vehicle *)vehicleWithType:(NSString *)type inContext:(NSManagedObjectContext *)context;


@end
