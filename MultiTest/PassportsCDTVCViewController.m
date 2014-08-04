//
//  PassportsCDTVCViewController.m
//  MultiTest
//
//  Created by Administrator on 29.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "PassportsCDTVCViewController.h"
#import "MultiDatabaseAvailability.h"
#import "Passport.h"
#import "PassportAddVC.h"
#import "PassportTemp.h"
#import "NSString+Project.h"
#import "NSDate+Project.h"
#import "UIColor+Project.h"
#import "NSDateFormatter+Project.h"

@interface PassportsCDTVCViewController ()

@end

@implementation PassportsCDTVCViewController


-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext=managedObjectContext;
    
    //NSLog(@"Context in PassportsCDTVCViewController is set");
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Passport"];
    request.predicate=[NSPredicate predicateWithFormat:@"type != %@",@100];
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"experationDate" ascending:NO selector:@selector(compare:)]];
    
    self.fetchedResultsController=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Passport Cell"];
    
    Passport *passport=[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSString *text=@"";
    NSString *detailedText=@"";
    
    if ([passport.number length]) {
        text=[NSString stringWithFormat:@"Загранпаспорт №%@" , passport.number];
    } else text=[NSString stringWithFormat:@"Загранпаспорт"];
    

    detailedText=[NSString stringWithFormat:@"%@ — %@",
                  [NSDateFormatter multiVisaLocalizedStringFromDate:passport.issueDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle],
                  [NSDateFormatter multiVisaLocalizedStringFromDate:passport.experationDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]
                  ];
    
    cell.textLabel.text=text;
    
    cell.detailTextLabel.text=detailedText;
    
    ///////////////////////////////////Creating icon
    NSString *name=@"xPassport";
    
    if (NSOrderedDescending==[passport.experationDate compare:[NSDate dateTo12h00EUfromDate:[NSDate date]]]) { //Active Passport
        if ([passport.type isEqualToNumber:@1]) {
            name=[name stringByAppendingString:@""];
            cell.imageView.image=[UIImage imageNamed:name] ? : [UIImage imageNamed:@"xPassportGray"];
        }else{
            name=@"empty";
        }
        [cell.textLabel setTextColor:[UIColor blackColor]];
        [cell.detailTextLabel setTextColor:[UIColor blackColor]];
    }else{ //Past Passport
        if ([passport.type isEqualToNumber:@1]) {
            name=[name stringByAppendingString:@"Gray"];
        }else{
            name=@"empty";
        }
        [cell.textLabel setTextColor:[UIColor colorCalendarOldDate]];
        [cell.detailTextLabel setTextColor:[UIColor colorCalendarOldDate]];
    }
    cell.imageView.frame=CGRectMake(0.0, 0.0, 22.0, 22.0);
    cell.imageView.image=[UIImage imageNamed:name] ? : [UIImage imageNamed:@"empty"];
    
    
    return cell;
}

#pragma mark - Deselecting
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.tableView indexPathForSelectedRow]) {
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    }
    
}
#pragma mark - Table design settings
-(void) viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60.0;
}

#pragma mark - Preparing for Segue
-(void)prepareVC:(id) vc forSegue: (NSString *) segueIdetifier fromIndexPatch:(NSIndexPath *) indexPath
{
    //Editting passport
    Passport *passport =[self.fetchedResultsController objectAtIndexPath:indexPath];
    if ([vc isKindOfClass:[PassportAddVC class]]) {
        PassportAddVC *passportAVC = (PassportAddVC *)vc;
        passportAVC.passport=passport;
        passportAVC.editingPassport = [PassportTemp editingPassportTempCopyFromPassport:passport];
        passportAVC.managedObjectContext=self.managedObjectContext;
        passportAVC.userEditingPassport=self.user;
        passportAVC.isCreating=NO;
        
        
        //NSLog(@"PassportAVC is Editing");
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath=nil;
    if ([sender isKindOfClass:[UITableViewCell class]]){
        indexPath=[self.tableView indexPathForCell:sender];
    }
    if ([segue.identifier isEqualToString:@"Edit Passport"]) {
        if ([segue.destinationViewController isKindOfClass:[PassportAddVC class]]) {
            [self prepareVC:segue.destinationViewController forSegue:segue.identifier fromIndexPatch:indexPath];
            //NSLog(@"Prepare for PassportAddVC");
            
        }
    }
}

@end


