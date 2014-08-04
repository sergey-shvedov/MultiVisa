//
//  VisaAddVC.m
//  MultiTest
//
//  Created by Administrator on 30.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "VisaAddVC.h"
#import "VisaFormTVC.h"
#import "CONST.h"
#import "UIColor+Project.h"
#import "FormButton.h"
#import "TodayVC.h"
#import "MultiTestAppDelegate.h"

@interface VisaAddVC () <UIAlertViewDelegate>
//@property (weak, nonatomic) IBOutlet UIButton *buttonOutletCancel;
//@property (weak, nonatomic) IBOutlet UIButton *buttonOutletSave;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end

@implementation VisaAddVC
/////////////////////////////////////////
#pragma mark - Buttons action
- (IBAction)deleteVisa:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Удаление" message:@"Вы уверены, что хотите удалить эту визу?" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Да", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"Удаление"] && (1 == buttonIndex)) {
        [self.todayVC activateVisaSpinner];
        [self.editingVisa deleteVisa:self.visa InContext:self.managedObjectContext];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    }
            
}
-(void) clickOKForCreate: (id) sender
{
    if (self.editingVisa.isNeedToEdit) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Внимание!" message:@"Перед созданием новой визы необходимо заполнить все требуемые данные." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else{
        [self.todayVC activateVisaSpinner];
        [self.editingVisa insertNewVisaInContext:self.managedObjectContext];
        //[self updateTodayView];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    }
}
-(void) clickOKForSave: (id) sender
{
    if (self.editingVisa.isNeedToEdit) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Внимание!" message:@"Перед сохранением визы необходимо отредактировать отмеченные данные." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else{
        [self.todayVC activateVisaSpinner];
        [self.editingVisa updateDaysWithVisa: self.visa inContext:self.managedObjectContext];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    }
}


-(void) clickCancel:(id) sender
{
    //[super clickCancel: sender];
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
    if ([segue.identifier isEqualToString:@"Embed Visa Form"]) {
        if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navc= (UINavigationController *)segue.destinationViewController;
            
            if ([[navc.viewControllers firstObject]isKindOfClass:[VisaFormTVC class]]) {
                VisaFormTVC *vfTVC =(VisaFormTVC *)[navc.viewControllers firstObject];
                vfTVC.visaaddvc=self;
                vfTVC.visa=self.visa;
                vfTVC.managedObjectContect=self.managedObjectContext;
                vfTVC.saveContect=((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).saveContext; //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> SaveContext
                vfTVC.editingVisa=self.editingVisa;
                vfTVC.isCreating=self.isCreating;
                //NSLog(@"prepare for VisaFormTVC");
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
//    if (self.isCreating) {
//        [self.buttonOutletSave setTitle:@"Создать" forState:UIControlStateNormal];
//        
//    }else{
//        [self.buttonOutletSave setTitle:@"Сохранить" forState:UIControlStateNormal];
//    }
//    [self.buttonOutletSave setBackgroundImage:([[UIColor colorButtonOkBackgroundHigligted] imageFromColor]) forState:UIControlStateHighlighted];
//    [self.buttonOutletSave setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    self.buttonOutletSave.adjustsImageWhenHighlighted=NO;
    
}


//-(void) dismissButtons
//{
//    self.buttonOutletCancel.hidden=YES;
//    self.buttonOutletSave.hidden=YES;
//}
//-(void) appearButtons
//{
//    [self animateAppearsButton:self.buttonOutletCancel];
//    [self animateAppearsButton:self.buttonOutletSave];
//}


//- (IBAction)addButton
//{
//    if (self.isCreating) {
//        [self.editingVisa insertNewVisaInContext:self.managedObjectContext];
//    }else{
//        [self.editingVisa updateVisa:self.visa];
//    }
//    NSLog(@"isNeedEdit=%hhd",self.buttonOk.isNeedEdit);
//    //[self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
//    self.buttonOk.isNeedEdit = (self.buttonOk.isNeedEdit) ? NO : YES ;
//    NSLog(@"isNeedEdit=%hhd",self.buttonOk.isNeedEdit);
//}

//- (IBAction)cancelButton
//{
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
//}

@end
