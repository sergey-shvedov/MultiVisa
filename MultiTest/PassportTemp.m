//
//  PassportTemp.m
//  MultiTest
//
//  Created by Administrator on 09.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "PassportTemp.h"
#import "Passport+Create.h"
#import "NSDate+Project.h"
#import "DayWithPassport+Create.h"
#import "MultiTestAppDelegate.h"
#import "PassportSavedNotification.h"


@interface PassportTemp()

@property (strong,nonatomic) UIManagedDocument *document;
@property (strong,nonatomic) NSManagedObjectContext *saveContext;


@end


@implementation PassportTemp

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
#pragma mark - Get edditing Passport
///////////////////////////////////////////////

+(PassportTemp *) editingPassportTempCopyFromPassport:(Passport *)passport
{
    //get savePassport to edit
    passport=(Passport *)[(((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).saveContext) objectWithID:[passport objectID]];
    
    PassportTemp *editingPassport=[[PassportTemp alloc] init];
    editingPassport.number=passport.number;
    editingPassport.type=passport.type;
    editingPassport.isFingerprinting=passport.isFingerprinting;
    editingPassport.issueDate=passport.issueDate;
    editingPassport.experationDate=passport.experationDate;
    editingPassport.whoOwn=passport.whoOwn;
    editingPassport.visas=passport.visas;
    editingPassport.daysByPassport=passport.daysByPassport;
    
    editingPassport.isIssueDateNeedEdit = NO;
    editingPassport.isIssueDateEdited = YES;
    editingPassport.isExperationDateNeedEdit = NO;
    editingPassport.isExperationDateEdited = YES;
    editingPassport.isTypeNeedEdit = NO;
    editingPassport.isTypeEdited = YES;
    
    if (NSOrderedDescending == [editingPassport.issueDate compare:editingPassport.experationDate]) {
        editingPassport.isExperationDateNeedEdit = YES;
    }
    return editingPassport;
}

+(PassportTemp *) defaultPassportTempInContext:(NSManagedObjectContext *) saveContext
{
    PassportTemp *editingPassport=[[PassportTemp alloc]init];
    editingPassport.number=@"";
    editingPassport.type=@1; //biometric
    editingPassport.isFingerprinting=@0;
    editingPassport.issueDate=[NSDate dateTo12h00EUfromDate:[NSDate date]];
    editingPassport.experationDate=[NSDate dateTo12h00EUfromDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*3650]];
    editingPassport.whoOwn=[User mainUserInContext:saveContext];
    editingPassport.visas=nil;
    editingPassport.daysByPassport=nil;
    
    editingPassport.isIssueDateNeedEdit = YES;
    editingPassport.isIssueDateEdited = NO;
    editingPassport.isExperationDateNeedEdit = YES;
    editingPassport.isExperationDateEdited = NO;
    editingPassport.isTypeNeedEdit = NO;
    editingPassport.isTypeEdited = NO;
    
    return editingPassport;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - update Passport from edittingPassport
///////////////////////////////////////////////

-(void) updatePassport:(Passport *)passport
{
    passport.number=self.number;
    passport.type=self.type;
    passport.isFingerprinting=self.isFingerprinting;
    passport.issueDate=self.issueDate;
    passport.experationDate=self.experationDate;
    passport.whoOwn=self.whoOwn;
    passport.visas=self.visas;
    passport.daysByPassport=self.daysByPassport;
}

-(BOOL) isNeedToEdit
{
    if (self.isIssueDateNeedEdit || self.isExperationDateNeedEdit || self.isTypeNeedEdit) {
        return YES;
    }else return NO;
    
}
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - CREATE  - DELETE - CHANGE Passport via SaveContext
///////////////////////////////////////////////

-(void) insertNewPassportInContext:(NSManagedObjectContext *)context //CREATE
{
    //#warning Need to handle .daysByPassport
    [self.saveContext performBlock:^{
        Passport *newPassport=[NSEntityDescription insertNewObjectForEntityForName:@"Passport" inManagedObjectContext:self.saveContext];
        [self updatePassport:newPassport];
        
        NSError *error;
        [self.saveContext save:&error]; //SAVE
        
        ///UPDATE DAYS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        [DayWithPassport updateDaysFromDate:self.issueDate toDate:self.experationDate withPassport:newPassport inContext:self.saveContext];
        
        [self.saveContext save:&error];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:PassportSavedNotification object:nil]; //NOTIFICATION
        
        //[context performBlock:^{ }]; //Main Thread
    
    }];

    
}

-(void) deletePassport: (Passport *) passport InContext:(NSManagedObjectContext *)context //DELETE
{
    [self.saveContext performBlock:^{
        
        //Set Passport's visas to default passport
        Passport *mainPassport = [Passport mainPassportInContext:self.saveContext];
        Passport *savePassport=(Passport *)[self.saveContext objectWithID:[passport objectID]];
        if (mainPassport) {
            for (Visa *visa in savePassport.visas)
            {
                visa.inPassport=mainPassport;
            }
        }
        
        [self.saveContext deleteObject:savePassport];
        
        NSError *error;
        [self.saveContext save:&error]; //SAVE
        
        [[NSNotificationCenter defaultCenter] postNotificationName:PassportSavedNotification object:nil]; //NOTIFICATION
        
        //[context performBlock:^{ }]; //Main Thread
        
    }];

}





-(void) updateDaysWithPassport:(Passport *)passport inContext: (NSManagedObjectContext *)context //CHANGE
{
    //#warning Need to handle if passport is Main Passport
    
    [self.saveContext performBlock:^{
        
        if ([[self.saveContext objectWithID:[passport objectID]] isKindOfClass:[Passport class]]) {
            
            Passport *savePassport=(Passport *)[self.saveContext objectWithID:[passport objectID]];
            
            savePassport.number=self.number;
            savePassport.type=self.type;
            savePassport.isFingerprinting=self.isFingerprinting;
            savePassport.issueDate=self.issueDate;
            savePassport.experationDate=self.experationDate;
            savePassport.whoOwn=self.whoOwn;
            savePassport.visas=self.visas;
            savePassport.daysByPassport=self.daysByPassport;
            
            NSDate *oldIssueDate=[NSDate dateWithTimeInterval:0.0 sinceDate:passport.issueDate];
            NSDate *oldExperationDate=[NSDate dateWithTimeInterval:0.0 sinceDate:passport.experationDate];
            
            NSError *error;
            [self.saveContext save:&error];
            
            ///UPDATE DAYS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            [DayWithPassport resettingDaysWithPassport:savePassport inContext:self.saveContext withOldIssueDate:oldIssueDate andOldExperationDate:oldExperationDate];
            
            [self.saveContext save:&error];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:PassportSavedNotification object:nil]; //NOTIFICATION
            
            //[context performBlock:^{ }]; //Main Thread
  
        }
    }];
    
    
}




@end
