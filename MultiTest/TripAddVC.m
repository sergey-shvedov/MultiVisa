//
//  TripAddVC.m
//  MultiTest
//
//  Created by Administrator on 08.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "TripAddVC.h"
#import "TripFormTVC.h"
#import "CONST.h"
#import "UIColor+Project.h"
#import "FormButton.h"
#import "UserWithTrip.h"
#import "DayWithTrip+Create.h"
#import "MultiTestAppDelegate.h"

@interface TripAddVC () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end

@implementation TripAddVC
/////////////////////////////////////////
#pragma mark - Buttons action
- (IBAction)deleteTrip:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Удаление" message:@"Вы уверены, что хотите удалить это путешествие?" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Да", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"Удаление"] && (1 == buttonIndex)) {
        
        //Addition deleting
        // Now via Cascade CoreData rule
        {
            
        
//        NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"UserWithTrip"];
//        request.predicate=[NSPredicate predicateWithFormat:@"inTrip = %@",self.trip];
//        NSError *error;
//        NSArray  *mathes=[self.managedObjectContext executeFetchRequest:request error:&error];
//        if (mathes && [mathes count]>0) {
//            for (UserWithTrip *userWithTrip in mathes)
//            {
//                [self.managedObjectContext deleteObject:userWithTrip];
//            }
//        }
        }
        
        
        ////////////////////

        [self.editingTrip deleteTrip:self.trip InContext:self.managedObjectContext];
        
        [self updateTodayView];
        [self updateCalendarView];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    }
    
}

-(void) clickOKForCreate: (id) sender
{
    if (self.editingTrip.isNeedToEdit) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Внимание!" message:@"Перед созданием нового путешествия необходимо заполнить все требуемые данные." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else{
        [self.editingTrip insertNewTripInContext:self.managedObjectContext];
        [self updateTodayView];
        [self updateCalendarView];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    }
}
-(void) clickOKForSave: (id) sender
{
    if (self.editingTrip.isNeedToEdit) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Внимание!" message:@"Перед сохранением путешествия необходимо отредактировать отмеченные данные." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else{
        [self.editingTrip updateDaysWithTrip:self.trip inContext:self.managedObjectContext];
        [self updateTodayView];
        [self updateCalendarView];
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
    if ([segue.identifier isEqualToString:@"Embed Trip Form"]) {
        if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navc= (UINavigationController *)segue.destinationViewController;
            
            if ([[navc.viewControllers firstObject]isKindOfClass:[TripFormTVC class]]) {
                TripFormTVC *tfTVC =(TripFormTVC *)[navc.viewControllers firstObject];
                tfTVC.tripaddvc=self;
                tfTVC.trip=self.trip;
                tfTVC.managedObjectContect=self.managedObjectContext;
                tfTVC.saveContect=((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).saveContext; //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> SaveContext
                tfTVC.editingTrip=self.editingTrip;
                tfTVC.isCreating=self.isCreating;
                //NSLog(@"prepare for TripFormTVC");
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
