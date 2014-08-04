//
//  Vehicle+Create.m
//  MultiTest
//
//  Created by Administrator on 28.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "Vehicle+Create.h"

@implementation Vehicle (Create)

#define VEHICLE_TYPE_AIR @"Air"
#define VEHICLE_TYPE_CAR @"Car"
#define VEHICLE_TYPE_SEA @"Sea"
#define VEHICLE_TYPE_FOOT @"Foot"


+(NSArray *)allVehiclesinContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Vehicle"];
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES selector:@selector(compare:)]];
    NSError *error;
    NSArray *matches=[context executeFetchRequest:request error:&error];
    
    if (!matches) {
        //error
        return  nil;
    } else if (![matches count])
    {
        //create new
        Vehicle *tempVehicle0 =[NSEntityDescription insertNewObjectForEntityForName:@"Vehicle" inManagedObjectContext:context ];
        tempVehicle0.type=VEHICLE_TYPE_AIR;
        tempVehicle0.id=@0;
        Vehicle *tempVehicle1 =[NSEntityDescription insertNewObjectForEntityForName:@"Vehicle" inManagedObjectContext:context ];
        tempVehicle1.type=VEHICLE_TYPE_CAR;
        tempVehicle1.id=@1;
        Vehicle *tempVehicle2 =[NSEntityDescription insertNewObjectForEntityForName:@"Vehicle" inManagedObjectContext:context ];
        tempVehicle2.type=VEHICLE_TYPE_SEA;
        tempVehicle2.id=@2;
        Vehicle *tempVehicle3 =[NSEntityDescription insertNewObjectForEntityForName:@"Vehicle" inManagedObjectContext:context ];
        tempVehicle3.type=VEHICLE_TYPE_FOOT;
        tempVehicle3.id=@3;
        
        //NSLog(@"Created all vehicles");
        return  @[tempVehicle0,tempVehicle1,tempVehicle2,tempVehicle3];
    } else if([matches[0] isKindOfClass:[Vehicle class]]){
        if (([matches count] == 4) &&
            ([((Vehicle *)matches[0]).type isEqual: VEHICLE_TYPE_AIR]) &&
            ([((Vehicle *)matches[1]).type isEqual: VEHICLE_TYPE_CAR]) &&
            ([((Vehicle *)matches[2]).type isEqual: VEHICLE_TYPE_SEA]) &&
            ([((Vehicle *)matches[3]).type isEqual: VEHICLE_TYPE_FOOT])
            ){
            //NSLog(@"All Vehicles already exists:");
            return  matches;
        }else return nil;
    } else
    {
        //error
        return  nil;
    }
    
}
+(BOOL)isSetinContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Vehicle"];
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES selector:@selector(compare:)]];
    NSError *error;
    NSArray *matches=[context executeFetchRequest:request error:&error];
    if ([matches count] == 4) return YES;
    else return NO;

}

+(Vehicle *)vehicleWithType:(NSString *)type inContext:(NSManagedObjectContext *)context
{
    Vehicle *vehicle=nil;
    
    if ([type length]) {
        NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Vehicle"];
        request.predicate=[NSPredicate predicateWithFormat:@"type = %@", type];
        
        NSError *error;
        NSArray *matches=[context executeFetchRequest:request error:&error];
        
        if (!matches || [matches count]>1) {
            //Error
        }else if (![matches count]){
            //Create new one
            vehicle = [NSEntityDescription insertNewObjectForEntityForName:@"Vehicle" inManagedObjectContext:context];
            vehicle.type=type;
        }else{
            //return already exists
            vehicle=[matches lastObject];
        }
    }
    return vehicle;
}

/*+(NSArray *)allVehiclesInContext:(NSManagedObjectContext *)context
{
    NSArray *vehicles=nil;
    if ([[self class] createAllVehiclesinContext:context]){
        NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Vehicle"];
        request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES selector:@selector(compare:)]];
        NSError *error;
        NSArray *mathes=[context executeFetchRequest:request error:&error];
        if (mathes){
            if (0 == [mathes count]){
                //create error
            }else if (4 == [mathes count]){
                vehicles=mathes;
            }else{
                //count error
            }
        } else {
            //fetch error
        }
    }
    return vehicles;
}*/

@end
