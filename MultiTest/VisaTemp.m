//
//  VisaTemp.m
//  MultiTest
//
//  Created by Administrator on 01.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "VisaTemp.h"
#import "NSDate+Project.h"
#import "NSString+Project.h"
#import "DayWithVisa+Create.h"
#import "MultiTestAppDelegate.h"
#import "PassportSavedNotification.h"

@interface VisaTemp()
@property (strong,nonatomic) UIManagedDocument *document;
@property (strong,nonatomic) NSManagedObjectContext *saveContext;
@end

@implementation VisaTemp

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
#pragma mark - Get edditing Visa
///////////////////////////////////////////////

+(VisaTemp *) editingVisaTempCopyFromVisa:(Visa *)visa
{
    //get saveVisa to edit
    visa=(Visa *)[(((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).saveContext) objectWithID:[visa objectID]];
    
    VisaTemp *editingVisa =[[VisaTemp alloc]init];
    editingVisa.typeABC=visa.typeABC;
    editingVisa.currentNumberEntries=visa.currentNumberEntries;
    editingVisa.days=visa.days;
    editingVisa.multiEntryType=visa.multiEntryType;
    editingVisa.startDate=visa.startDate;
    editingVisa.endDate=visa.endDate;
    editingVisa.yearType=visa.yearType;
    editingVisa.inPassport=visa.inPassport;
    editingVisa.forCountry=visa.forCountry;
    editingVisa.daysByVisa=visa.daysByVisa;
    
    //////////////////////////
    
    editingVisa.isCountryNeedEdit = NO;
    editingVisa.isCountryEdited = YES;
    editingVisa.isStartDateNeedEdit = NO;
    editingVisa.isStartDateEdited = YES;
    editingVisa.isEndDateNeedEdit = NO;
    editingVisa.isEndDateEdited = YES;
    editingVisa.isVisaTypeNeedEdit = NO;
    editingVisa.isVisaTypeEdited = YES;
    editingVisa.isDaysNeedEdit = NO;
    editingVisa.isDaysEdited = YES;
    editingVisa.isPassportNeedEdit = NO;
    editingVisa.isPassportEdited = YES;
    
    if (NSOrderedDescending == [editingVisa.startDate compare:editingVisa.endDate]) {
        editingVisa.isEndDateNeedEdit = YES;
    }
    
    //NSLog(@"edited visa for country:%@",visa.startDate);

    return editingVisa;
}


+(VisaTemp *)defaultVisaTempInContext:(NSManagedObjectContext *)saveContext
{
    VisaTemp *editingVisa =[[VisaTemp alloc]init];
    editingVisa.typeABC=[NSString stringByVisaType:@2];
    editingVisa.currentNumberEntries=@0;
    editingVisa.days=@90;
    editingVisa.multiEntryType=@3;
    editingVisa.startDate=[NSDate dateTo12h00EUfromDate:[NSDate date]];
    editingVisa.endDate=[NSDate dateTo12h00EUfromDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*365]];
    editingVisa.yearType=@1.0;
    
    NSArray *passports=[Passport standartRequestResultsInContext:saveContext];
    if ([passports count])editingVisa.inPassport=(Passport *)passports[0];
    NSArray *countries=[Country standartRequestResultsInContext:saveContext];
    if([countries count])editingVisa.forCountry=(Country *)countries[0];
//#warning Need handle daysByVisa
    editingVisa.daysByVisa=nil;
    
    //////////////////////////////////
    
    editingVisa.isCountryNeedEdit = NO;
    editingVisa.isCountryEdited = NO;
    editingVisa.isStartDateNeedEdit = YES;
    editingVisa.isStartDateEdited = NO;
    editingVisa.isEndDateNeedEdit = YES;
    editingVisa.isEndDateEdited = NO;
    editingVisa.isVisaTypeNeedEdit = NO;
    editingVisa.isVisaTypeEdited = NO;
    editingVisa.isDaysNeedEdit = NO;
    editingVisa.isDaysEdited = NO;
    editingVisa.isPassportNeedEdit = NO;
    editingVisa.isPassportEdited = NO;
    
    return editingVisa;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - update Visa from edittingVisa
///////////////////////////////////////////////

-(void)updateVisa:(Visa *)visa
{
    visa.typeABC=self.typeABC;
    visa.currentNumberEntries=self.currentNumberEntries;
    visa.days=self.days;
    visa.multiEntryType=self.multiEntryType;
    visa.startDate=self.startDate;
    visa.endDate=self.endDate;
    visa.yearType=self.yearType;
    visa.inPassport=self.inPassport;
    visa.forCountry=self.forCountry;
    visa.daysByVisa=self.daysByVisa;
}

-(BOOL) isNeedToEdit
{
    if (self.isCountryNeedEdit || self.isStartDateNeedEdit || self.isEndDateNeedEdit || self.isDaysNeedEdit || self.isPassportNeedEdit) {
        return YES;
    }else return NO;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - CREATE  - DELETE - CHANGE Visa via SaveContext
///////////////////////////////////////////////

-(void)insertNewVisaInContext:(NSManagedObjectContext *)context //CREATE
{
    [self.saveContext performBlock:^{
        Visa *newVisa=[NSEntityDescription insertNewObjectForEntityForName:@"Visa" inManagedObjectContext:self.saveContext];
        [self updateVisa:newVisa];
        //#warning Need handle daysByVisa
        
        NSError *error;
        [self.saveContext save:&error]; //SAVE
        
        ///UPDATE DAYS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        [DayWithVisa updateDaysFromDate:self.startDate toDate:self.endDate withVisa:newVisa inContext:self.saveContext]; //Create DaysWithVisa
        
        [self.saveContext save:&error];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:VisaSavedNotification object:nil]; //NOTIFICATION
        
        //[context performBlock:^{ }]; //Main Thread
        
    }];
}

-(void) deleteVisa:(Visa *)visa InContext:(NSManagedObjectContext *)context //DELETE
{
    [self.saveContext performBlock:^{     

        Visa *saveVisa=(Visa *)[self.saveContext objectWithID:[visa objectID]]; //get Visa from saveContext

        [self.saveContext deleteObject:saveVisa];
        
        NSError *error;
        [self.saveContext save:&error]; //SAVE
        
        [[NSNotificationCenter defaultCenter] postNotificationName:VisaSavedNotification object:nil]; //NOTIFICATION
        
        //[context performBlock:^{ }]; //Main Thread
        
    }];
    
}

-(void)updateDaysWithVisa:(Visa *)visa inContext:(NSManagedObjectContext *)context
{
    [self.saveContext performBlock:^{
        
        if ([[self.saveContext objectWithID:[visa objectID]] isKindOfClass:[Visa class]]) {
            
            Visa *saveVisa=(Visa *)[self.saveContext objectWithID:[visa objectID]]; //get Visa from saveContext
            
            [self updateVisa:saveVisa];
            
            NSDate *oldIssueDate=[NSDate dateWithTimeInterval:0.0 sinceDate:visa.startDate];
            NSDate *oldExperationDate=[NSDate dateWithTimeInterval:0.0 sinceDate:visa.endDate];
            
            NSError *error;
            [self.saveContext save:&error];
            
            ///UPDATE DAYS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            [DayWithVisa resettingDaysWithVisa:saveVisa inContext:self.saveContext withOldIssueDate:oldIssueDate andOldExperationDate:oldExperationDate];
            
            [self.saveContext save:&error];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:VisaSavedNotification object:nil]; //NOTIFICATION
            
            //[context performBlock:^{ }]; //Main Thread
        
        }
    }];
    
}



@end




























