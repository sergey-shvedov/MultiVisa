//
//  TripTemp.m
//  MultiTest
//
//  Created by Administrator on 08.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "TripTemp.h"
#import "NSDate+Project.h"
#import "User+Create.h"
#import "UserWithTrip.h"
#import "DayWithTrip+Create.h"
#import "MultiTestAppDelegate.h"
#import "PassportSavedNotification.h"
#import "Day+Create.h"

@interface TripTemp()
@property (strong,nonatomic) UIManagedDocument *document;
@property (strong,nonatomic) NSManagedObjectContext *saveContext;
@end

@implementation TripTemp


////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - CONTEXTS
///////////////////////////////////////////////
-(UIManagedDocument *)document
{
    if (!_document) {
        UIManagedDocument *document=((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).document;
        _document=document;
    }
    return _document;
}
-(NSManagedObjectContext *)saveContext
{
    if (!_saveContext) {
        NSManagedObjectContext *context=((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).saveContext;
        _saveContext=context;
    }
    return _saveContext;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Get edditing Trip
///////////////////////////////////////////////

+(TripTemp *) editingTripTempCopyFromTrip:(Trip *)trip
{
    //get saveTrip to edit
    trip=(Trip *)[(((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).saveContext) objectWithID:[trip objectID]];
    
    TripTemp *editingTrip =[[TripTemp alloc]init];
    editingTrip.title=trip.title;
    editingTrip.entryDate=trip.entryDate;
    editingTrip.outDate=trip.outDate;
    editingTrip.numberOfTravelers=trip.numberOfTravelers;
    editingTrip.type=trip.type;
    editingTrip.usersByTrip=trip.usersByTrip; // Need set with UserWithTrip in Future
    editingTrip.entryCountry=trip.entryCountry;
    editingTrip.outCountry=trip.outCountry;
    editingTrip.entryVehicle=trip.entryVehicle;
    editingTrip.outVehicle=trip.outVehicle;
    //#warning Need handle daysByTrip
    editingTrip.daysByTrip=trip.daysByTrip;
    //editingTrip.users - Need fetch request for UserWithTrip to get users
    
    editingTrip.isEntryCountryNeedEdit = NO;
    editingTrip.isEntryCountryEdited = YES;
    editingTrip.isOutCountryNeedEdit = NO;
    editingTrip.isOutCountryEdited = YES;
    editingTrip.isEntryDateNeedEdit = NO;
    editingTrip.isEntryDateEdited = YES;
    editingTrip.isOutDateNeedEdit = NO;
    editingTrip.isOutDateEdited = YES;
    editingTrip.isTitleNeedEdit = NO;
    editingTrip.isTitleEdited = YES;
    
    if (NSOrderedDescending == [editingTrip.entryDate compare:editingTrip.outDate]) {
        editingTrip.isOutDateNeedEdit = YES;
    }
    return editingTrip;
}

+(TripTemp *) defaultTripTempInContext:(NSManagedObjectContext *) saveContext
{
    TripTemp *editingTrip =[[TripTemp alloc]init];
    editingTrip.title=@"Мое путешествие";
    editingTrip.entryDate=[NSDate dateTo12h00EUfromDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*14]];;
    editingTrip.outDate=[NSDate dateTo12h00EUfromDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*28]];
    editingTrip.numberOfTravelers=@1;
    editingTrip.type=@2;
    
    editingTrip.usersByTrip=nil; //[NSSet setWithObject:[User mainUserInContext:context]]; // Need set with UserWithTrip in Future
    editingTrip.users=[NSArray arrayWithObject:[User mainUserInContext:saveContext]];
    
    NSArray *countries=[Country standartRequestResultsInContext:saveContext];
    if([countries count]){
        editingTrip.entryCountry=(Country *)countries[0];
        editingTrip.outCountry=(Country *)countries[0];
    }
    NSArray *vehicles=[Vehicle allVehiclesinContext:saveContext];
    if ([vehicles count]) {
        editingTrip.entryVehicle=(Vehicle *)vehicles[0];
        editingTrip.outVehicle=(Vehicle *)vehicles[0];
    }
    //#warning Need handle daysByTrip
    editingTrip.daysByTrip=nil;

    
    editingTrip.isEntryCountryNeedEdit = NO;
    editingTrip.isEntryCountryEdited = NO;
    editingTrip.isOutCountryNeedEdit = NO;
    editingTrip.isOutCountryEdited = NO;
    editingTrip.isEntryDateNeedEdit = YES;
    editingTrip.isEntryDateEdited = NO;
    editingTrip.isOutDateNeedEdit = YES;
    editingTrip.isOutDateEdited = NO;
    editingTrip.isTitleNeedEdit = NO;
    editingTrip.isTitleEdited = NO;
    
    return editingTrip;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - update Trip from edittingTrip
///////////////////////////////////////////////

-(void) updateTrip: (Trip *)trip
{
    trip.title=self.title;
    trip.entryDate=self.entryDate;
    trip.outDate=self.outDate;
    trip.numberOfTravelers=self.numberOfTravelers;
    trip.type=self.type;
    trip.usersByTrip=self.usersByTrip;
    trip.entryCountry=self.entryCountry;
    trip.outCountry=self.outCountry;
    trip.entryVehicle=self.entryVehicle;
    trip.outVehicle=self.outVehicle;
    trip.daysByTrip=self.daysByTrip;
}
-(BOOL)isNeedToEdit
{
    if (self.isEntryCountryNeedEdit || self.isOutCountryNeedEdit || self.isEntryDateNeedEdit || self.isOutDateNeedEdit || self.isTitleNeedEdit) return YES;
    else return NO;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - CREATE  - DELETE - CHANGE Trip via SaveContext
///////////////////////////////////////////////

-(void) insertNewTripInContext:(NSManagedObjectContext *)context //CREATE
{
    [self.saveContext performBlock:^{
     Trip *newTrip=[NSEntityDescription insertNewObjectForEntityForName:@"Trip" inManagedObjectContext:self.saveContext];
        
         NSMutableSet *newSet=[[NSMutableSet alloc]init];
    for (User *user in self.users) {
        UserWithTrip *userWithTrip= [NSEntityDescription insertNewObjectForEntityForName:@"UserWithTrip" inManagedObjectContext:self.saveContext];
        userWithTrip.whoTravel=user;
        userWithTrip.inTrip=newTrip;
        [newSet addObject:userWithTrip];
    }
    self.usersByTrip=newSet;
        
        [self updateTrip:newTrip];
        
        NSError *error;
        [self.saveContext save:&error]; //SAVE
       [context performBlock:^{
               [[NSNotificationCenter defaultCenter] postNotificationName:TripNeedUpdateTodayCalendarView object:nil]; //NOTIFICATION
       }];
       
        
        ///UPDATE DAYS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        [DayWithTrip updateDaysFromDate:self.entryDate toDate:self.outDate withTrip:newTrip inContext:self.saveContext]; //Create DaysWithTrip
        
        [self.saveContext save:&error];
        
        [context performBlock:^{
                     [[NSNotificationCenter defaultCenter] postNotificationName:TripSavedNotification object:nil]; //NOTIFICATION
        }];
        
        
        //[context performBlock:^{ }]; //Main Thread
        
    }];
}

-(void) deleteTrip:(Trip *)trip InContext:(NSManagedObjectContext *)context //DELETE
{
    [self.saveContext performBlock:^{
        
        Trip *saveTrip=(Trip *)[self.saveContext objectWithID:[trip objectID]]; //get Visa from saveContext
        NSFetchRequest *request =[NSFetchRequest fetchRequestWithEntityName:@"DayWithTrip"];
        request.predicate=[NSPredicate predicateWithFormat:@"inTrip == %@", saveTrip];
        NSError *error;
        NSArray *daysWithTrip=[self.saveContext executeFetchRequest:request error:&error];
        
        NSMutableArray *days=[daysWithTrip valueForKey:@"usedDay"];
 
        [self.saveContext deleteObject:saveTrip];
        
        NSError *error2;
        [self.saveContext save:&error2]; //SAVE
        
        ///////////////////////////////////
        [context performBlock:^{
               [[NSNotificationCenter defaultCenter] postNotificationName:TripNeedUpdateTodayCalendarView object:nil]; //NOTIFICATION
        }];
       
        
        
        for (Day *day in days)
        {
            //Day *day=dayWithTrip.usedDay;
            
            //90/180 rule
            
            NSFetchRequest *request2 =[NSFetchRequest fetchRequestWithEntityName:@"Day"];
            request2.predicate=[NSPredicate predicateWithFormat:@"from2001>=%@ && from2001<%@",day.from2001, [NSNumber numberWithInteger:([day.from2001 integerValue]+180)]];
            request2.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001"ascending:YES selector:@selector(compare:)]];
            NSError *error2;
            NSArray *last180days=[self.saveContext executeFetchRequest:request2 error:&error2];
            for (Day *lastDay in last180days)
            {
                lastDay.last180TripDays=[NSNumber numberWithInteger:([lastDay.last180TripDays integerValue] - 1)];
            }
            
            //[self.saveContext deleteObject:dayWithTrip];
        }
        
        ///////////////////////////////////////////
        [self.saveContext save:&error]; //SAVE
        
        [context performBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:TripSavedNotification object:nil]; //NOTIFICATION
        }];

        
        //[context performBlock:^{ }]; //Main Thread
        
    }];
    
}

-(void) updateDaysWithTrip:(Trip *)trip inContext:(NSManagedObjectContext *)context
{

    [self.saveContext performBlock:^{
        
        if ([[self.saveContext objectWithID:[trip objectID]] isKindOfClass:[Trip class]]) {
            
            Trip *saveTrip=(Trip *)[self.saveContext objectWithID:[trip objectID]]; //get Trip from saveContext
            
            [self updateTrip:saveTrip];
            
            NSDate *oldIssueDate=[NSDate dateWithTimeInterval:0.0 sinceDate:trip.entryDate];
            NSDate *oldExperationDate=[NSDate dateWithTimeInterval:0.0 sinceDate:trip.outDate];
            
            NSError *error;
            [self.saveContext save:&error];
            
            [context performBlock:^{
                     [[NSNotificationCenter defaultCenter] postNotificationName:TripNeedUpdateTodayCalendarView object:nil]; //NOTIFICATION
            }];
            
            
            
            ///UPDATE DAYS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            [DayWithTrip resettingDaysWithTrip:saveTrip inContext:self.saveContext withOldIssueDate:oldIssueDate andOldExperationDate:oldExperationDate];
            
            [self.saveContext save:&error];
            [context performBlock:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:TripSavedNotification object:nil]; //NOTIFICATION
            }];
            
            
            //[context performBlock:^{ }]; //Main Thread
            
        }
    }];
}




@end
