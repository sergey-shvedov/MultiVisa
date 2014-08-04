//
//  VisasCDTVC.m
//  MultiTest
//
//  Created by Administrator on 29.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "VisasCDTVC.h"
#import "Visa.h"
#import "Country.h"
#import "VisaAddVC.h"
#import "VisaTemp.h"
#import "UIColor+Project.h"
#import "NSDate+Project.h"
#import "NSString+Project.h"
#import "DayWithTrip.h"
#import "NSDateFormatter+Project.h"

@interface VisasCDTVC ()
@property (strong,nonatomic) NSIndexPath *selectedIndex;
@end

@implementation VisasCDTVC

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext=managedObjectContext;
    
    //NSLog(@"Context in VisasCDTVC is set");
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Visa"];
    request.predicate=nil;
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"endDate" ascending:NO selector:@selector(compare:)]];
    //request.sortDescriptors=@[];
    self.fetchedResultsController=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Visa Cell"];
    
    Visa *visa=[self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString *text;
    NSString *textType=@"";
    NSString *textDays;
    NSString *detailedText;
   // NSString *detailedTextDays=@"";
    
    if ([visa.forCountry.title isEqualToString:@"EU"]) text=@"Шенген";
    else text=[NSString stringWithString:visa.forCountry.titleRUS];
    
    if (0 == [visa.multiEntryType integerValue]) textType=@"(Однократная) ";
    else if (1 == [visa.multiEntryType integerValue]) textType=@"(Двухкратная) ";
    else textType=@"";
    
    if ([NSDate daysFromDate:visa.startDate toDate:visa.endDate] > 180){
        textDays=[NSString stringWithFormat:@"(%@/180)", visa.days];
    }else{
        textDays=[NSString stringWithFormat:@"(%@/%ld)", visa.days,(long)[NSDate daysFromDate:visa.startDate toDate:visa.endDate]];
    }
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@ %@", text, textType];
    
    detailedText=[NSString stringWithFormat:@"%@ — %@",
                  [NSDateFormatter multiVisaLocalizedStringFromDate:visa.startDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle],
                  [NSDateFormatter multiVisaLocalizedStringFromDate:visa.endDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]
                  ];

    {
//    NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:@"Day"];
//    request.predicate=[NSPredicate predicateWithFormat:@"(from2001>=%@) && (from2001<=%@) && (tripsByDay.@count>0)",[NSNumber numberWithInteger:[visa.startDate daysFrom2001]], [NSNumber numberWithInteger:[visa.endDate daysFrom2001]] ];
//    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001" ascending:YES selector:@selector(compare:)]];
//    NSError *error;
//    
//    NSArray *match=[self.managedObjectContext executeFetchRequest:request error:&error];
//    
//    NSMutableSet *trips=[[NSMutableSet alloc]init];
//    
//    if ([match count]){
//        NSInteger usedDays=[match count];
//        
//        for (Day *day in match)
//        {
//            for (DayWithTrip *dayWithTrip in day.tripsByDay)
//            {
//                [trips addObject:dayWithTrip.inTrip];
//            }
//        }
//        
//        detailedTextDays=[NSString stringWithFormat:@"(%ld %@ на %ld %@)",
//                          [trips count],
//                          [NSString stringByRussianFor1:@"поездка" for2to4:@"поездки" for5up:@"поездок" withValue:[trips count]],
//                          usedDays,
//                          [NSString stringByRussianFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:usedDays]
//                          ];
//    }
    }//get count of trips // Need to update table when you change a trip

    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@ %@",detailedText,textDays];
    
    
    ////////////////// Create icon
    NSString *name=[@"iVisa" stringByAppendingString:visa.forCountry.title];
    if ([name isEqualToString:@"iVisaEU"]) {
        cell.imageView.image=[UIImage imageNamed:@"iVisaDefault"];
    }else{
        cell.imageView.image=[UIImage imageNamed:name] ? : [UIImage imageNamed:@"iVisaDefault"];
    }
    
    if (NSOrderedDescending==[visa.endDate compare:[NSDate dateTo12h00EUfromDate:[NSDate date]]]) { //Active Visa
        [cell.textLabel setTextColor:[UIColor blackColor]];
        [cell.detailTextLabel setTextColor:[UIColor blackColor]];
        [cell.imageView setAlpha:1.0];
    }else{ //Past Visa
        [cell.textLabel setTextColor:[UIColor colorCalendarOldDate]];
        [cell.detailTextLabel setTextColor:[UIColor colorCalendarOldDate]];
        [cell.imageView setAlpha:0.3];
    }
    
    
    
    return cell;
}

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
    return 124.0;
}


-(void)prepareVC:(id) vc forSegue: (NSString *) segueIdetifier fromIndexPatch:(NSIndexPath *) indexPath
{
    //Editting visa
    Visa *visa =[self.fetchedResultsController objectAtIndexPath:indexPath];
    if ([vc isKindOfClass:[VisaAddVC class]]) {
        VisaAddVC *visaAVC = (VisaAddVC *)vc;
        visaAVC.visa=visa;
        visaAVC.editingVisa = [VisaTemp editingVisaTempCopyFromVisa:visa];
        visaAVC.managedObjectContext=self.managedObjectContext;
        visaAVC.userEditingVisa=self.user;
        visaAVC.isCreating=NO;
        
        
        //NSLog(@"VisaAVC is Editing");
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath=nil;
    if ([sender isKindOfClass:[UITableViewCell class]]){
        indexPath=[self.tableView indexPathForCell:sender];
    }
    if ([segue.identifier isEqualToString:@"Edit Visa"]) {
        if ([segue.destinationViewController isKindOfClass:[VisaAddVC class]]) {
            [self prepareVC:segue.destinationViewController forSegue:segue.identifier fromIndexPatch:indexPath];
            //NSLog(@"Prepare for VisaAddVC");
            
        }
    }
}
@end
