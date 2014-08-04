//
//  MultiTestAppDelegate.m
//  MultiTest
//
//  Created by Administrator on 27.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "MultiTestAppDelegate.h"
#import "User+Create.h"
#import "Passport+Create.h"
#import "Country+Create.h"
#import "Vehicle+Create.h"
#import "MultiDatabaseAvailability.h"
#import "CONST.h"
#import "NSString+Project.h"
#import "NSDate+Project.h"
#import "Day+Create.h"
#import "CalendarVC.h"


@interface MultiTestAppDelegate()
@property (strong, nonatomic) NSManagedObjectContext *multiDatabaseContext;
@property BOOL isModelReady;
@end



@implementation MultiTestAppDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Getters of Contexts
///////////////////////////////////////////////

-(NSManagedObjectContext *)fetchContext  //for expensive calculations
{
    if (!_fetchContext) {
        if (self.document.documentState == UIDocumentStateNormal) {
            if (self.multiDatabaseContext) {
                NSManagedObjectContext *fetchContext=[[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
                [fetchContext setParentContext:self.multiDatabaseContext];
                _fetchContext=fetchContext;
            }
            
        }
    }
    return _fetchContext;
}
-(NSManagedObjectContext *)saveContext //for expensive database changes
{
    if (!_saveContext) {
        if (self.document.documentState == UIDocumentStateNormal) {
            if (self.multiDatabaseContext) {
                NSManagedObjectContext *saveContext=[[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
                [saveContext setParentContext:self.multiDatabaseContext];
                _saveContext=saveContext;
            }
            
        }
    }
    return _saveContext;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Launching
///////////////////////////////////////////////

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    /////////////////////////////////////////// Open DataBase
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSString *documentName=@"MultiVisa";
    NSURL *url=[documentsDirectory URLByAppendingPathComponent:documentName];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:[url path]];
    
    if (fileExists) {// DataBase already exists
        self.document=[[UIManagedDocument alloc] initWithFileURL:url];
        NSLog(@"File exists: %@",self.document.fileURL);
        [self.document openWithCompletionHandler:^(BOOL success) {
            if (success) {
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Point for enter // Open user DataBase
                [self documentIsReady];
                [self sendNotificationToViewsWithContext:self.multiDatabaseContext];
            }
        }];
    }else{// Copy DataBase
        NSLog(@"File not exists");

        NSURL* urlBundle = [[NSBundle mainBundle] bundleURL];
        urlBundle = [urlBundle URLByAppendingPathComponent:@"MultiVisaCopy"];
        
        BOOL fileBundleExists = [[NSFileManager defaultManager] fileExistsAtPath:[urlBundle path]];
        if (fileBundleExists) {
            NSLog(@"Bundle exists");
            
            NSError *error;
            if ([[NSFileManager defaultManager] copyItemAtURL:urlBundle toURL:url error:&error]) {
                self.document=[[UIManagedDocument alloc] initWithFileURL:url];
                [self.document openWithCompletionHandler:^(BOOL success) {
                    if (success) {
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Point for enter // Copy the database from bundle
                        [self documentIsReady];
                        [self sendNotificationToViewsWithContext:self.multiDatabaseContext];
                    }
                    
                }];
            }else{//copy error - create new DataBase (Very Very Expensive Thing!)
                self.document=[[UIManagedDocument alloc] initWithFileURL:url];
                [self.document saveToURL:self.document.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
                    if (success) {
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Point for enter // Creating new one
                        [self documentIsReady];
                        [self prepareMyModelForWorkingWithContext:self.multiDatabaseContext];
                        [self sendNotificationToViewsWithContext:self.multiDatabaseContext];
                    }
                }];
            }
    
        }else{//There are no ready database or file to copy - create new DataBase (Very Very Expensive Thing!)
            self.document=[[UIManagedDocument alloc] initWithFileURL:url];
            [self.document saveToURL:self.document.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
                if (success) {
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Point for enter // Creating new one
                    [self documentIsReady];
                    [self prepareMyModelForWorkingWithContext:self.multiDatabaseContext];
                    [self sendNotificationToViewsWithContext:self.multiDatabaseContext];
                }
            }];
        }
    }
    return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Creating and Saving Contexts
///////////////////////////////////////////////

-(void) documentIsReady // Create contexts
{
    if (self.document.documentState == UIDocumentStateNormal) {
        NSManagedObjectContext *context = self.document.managedObjectContext;
        self.multiDatabaseContext=context;
        self.isModelReady=NO;
      
        
        if (self.fetchContext) {
            NSLog(@"FetchContext is ready");
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(contextDidSaveFetchContext:)
                                                         name:NSManagedObjectContextDidSaveNotification
                                                       object:[self fetchContext]];
        }
        if (self.saveContext) {
            NSLog(@"SaveContext is ready");
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(contextDidSaveSaveContext:)
                                                         name:NSManagedObjectContextDidSaveNotification
                                                       object:[self saveContext]];
        }
    
    }
}

- (void)contextDidSaveFetchContext:(NSNotification *)notification //Synchronization changes in fetchContext with other contexts
{

    [self.multiDatabaseContext performBlock:^{
        NSError *error;
        [self.multiDatabaseContext save:&error];
        [self.saveContext performBlock:^{
            [self.saveContext reset];
        }];
    }];
}

- (void)contextDidSaveSaveContext:(NSNotification *)notification //Synchronization changes in saveContext with other contexts
{
    
    [self.multiDatabaseContext performBlock:^{
        NSError *error;
        [self.multiDatabaseContext save:&error];
        [self.fetchContext performBlock:^{
            [self.fetchContext reset];
        }];
    }];

}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - New DataBase
///////////////////////////////////////////////

-(void)prepareMyModelForWorkingWithContext:(NSManagedObjectContext *)context
{
    
//#warning custom User & Country create
//USER settings
    if ([User mainUserInContext:context]) {
        NSLog(@"Main User is ready");
    }
//Main Passport settings
    if ([Passport mainPassportInContext:context]) {
        NSLog(@"Main Passport is ready");
    }
    
//VEHICLE settings

    //Vehicle
    if ([Vehicle isSetinContext:context]) {
        NSLog(@"vehicles are ready");
        [self countrySetupInContext:context];
    }else{
        NSLog(@"vehicles need to set");
        NSArray *vehicles = [Vehicle allVehiclesinContext:context];
        NSLog(@"Setted %lu vehicles. Start to save.",(unsigned long)[vehicles count]);
        [self.document saveToURL:self.document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"Vehicles saved");
                [self countrySetupInContext:context];         //DOCUMENT SAVED
                [self sendNotificationToViewsWithContext:context];
            }
        }];
    }
}
//COUNTRY settings
-(void) countrySetupInContext:(NSManagedObjectContext *)context
{
    [self testDays:context];
    
    if ([Country setupMainCountryInContext:context]) {
        NSLog(@"Shengen country is ready:");
    }else{
        NSLog(@"Shengen country is not set");
    }
    if ([Country setupAllCountriesInContext:context]) {
        NSLog(@"All country are set:");
    }
}

-(void) testDays:(NSManagedObjectContext *)context
{
    NSDate *date1=[NSDate dateWithTimeIntervalSinceNow:-60*60*24*365];
    NSDate *date2=[NSDate dateWithTimeIntervalSinceNow:60*60*24*1000];
    [Day insertDaysFromDate:date1 toDate:date2 inContext:context];
}

-(void) sendNotificationToViewsWithContext:(NSManagedObjectContext *)context
{
    //Post Notification - all necessary settings are done - with my context
    NSDictionary *userInfo=context ? @{MultiDatabaseAvailabilityContext: context} : nil ;
    [[NSNotificationCenter defaultCenter] postNotificationName:MultiDatabaseAvailabilityNotification object:self userInfo:userInfo];
    self.isModelReady=YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - AppDelegate
///////////////////////////////////////////////

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    if ([self.window.rootViewController isKindOfClass:[UISplitViewController class]]){
    
        UISplitViewController *svc= (UISplitViewController *)self.window.rootViewController;
        
        if ([[[svc viewControllers] firstObject] isKindOfClass:[CalendarVC class]]) {
            CalendarVC *cvc=(CalendarVC *)[[svc viewControllers] firstObject];
            [cvc updateDay];
            [cvc updateTable];
        }

    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
