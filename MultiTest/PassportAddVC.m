//
//  PassportAddVC.m
//  MultiTest
//
//  Created by Administrator on 09.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "PassportAddVC.h"
#import "Passport+Create.h"
#import "Visa.h"
#import "PassportFormTVC.h"
#import "MultiTestAppDelegate.h"


@interface PassportAddVC ()
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end

@implementation PassportAddVC



/////////////////////////////////////////
#pragma mark - Buttons action

- (IBAction)deletePassport:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Удаление" message:@"Вы уверены, что хотите удалить этот паспорт?" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Да", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"Удаление"] && (1 == buttonIndex)) {

        ////////////////////
        
//#warning !!!
        [self.todayVC activatePassportSpinner];
         [self.editingPassport deletePassport:self.passport InContext:self.managedObjectContext];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    }
}

-(void) clickOKForCreate: (id) sender
{
    if (self.editingPassport.isNeedToEdit) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Внимание!" message:@"Перед созданием нового паспорта необходимо заполнить все требуемые данные." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else{
        
        [self.todayVC activatePassportSpinner];
        [self.editingPassport insertNewPassportInContext:self.managedObjectContext];
 
        //[self updateTodayView];
        
          
        [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
        
        //[self updateCalendarView];
        
    }
}
-(void) clickOKForSave: (id) sender
{
    if (self.editingPassport.isNeedToEdit) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Внимание!" message:@"Перед сохранением паспорта необходимо отредактировать отмеченные данные." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else{
        
        [self.todayVC activatePassportSpinner];
        
        [self.editingPassport updateDaysWithPassport:self.passport inContext:self.managedObjectContext];

        [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];

    }
}
-(void) clickCancel:(id) sender
{
    //NSLog(@"PresentingViewController:%@",self.presentingViewController);
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

////////////////////////////////////////////
#pragma mark - Inhered methods
-(void)dismissButtons
{
    [super dismissButtons];
    self.deleteButton.hidden=YES;
}
-(void)appearButtons
{
    [super appearButtons];
    if (!self.isCreating) {
        [self animateAppearsButton:self.deleteButton];
    }
}

////////////////////////////////////////////
#pragma mark - Prepare For Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Embed Passport Form"]) {
        if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navc= (UINavigationController *)segue.destinationViewController;
            
            if ([[navc.viewControllers firstObject]isKindOfClass:[PassportFormTVC class]]) {
                PassportFormTVC *pfTVC =(PassportFormTVC *)[navc.viewControllers firstObject];
                pfTVC.passportaddvc=self;
                pfTVC.passport=self.passport;
                pfTVC.managedObjectContect=self.managedObjectContext;
                pfTVC.editingPassport=self.editingPassport;
                pfTVC.isCreating=self.isCreating;
                //NSLog(@"prepare for PassportFormTVC");
            }
        }
    }
}

////////////////////////////////////////////
#pragma mark - DID-WILL Methods
-(void)viewDidLoad
{
    [super viewDidLoad];
    if (self.isCreating) {
        self.deleteButton.hidden=YES;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


@end
