//
//  CalendarTableViewController.m
//  MultiTest
//
//  Created by Administrator on 27.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "CalendarTableViewController.h"
#import "MultiDatabaseAvailability.h"
#import "CalendarTableViewCell.h"
#import "Week.h"
#import "NSDate+Project.h"
#import "TodayVC.h"
#import "DayVC.h"
#import "Day+Create.h"

@interface CalendarTableViewController ()

@property (nonatomic) NSInteger todayFrom2001;

@end

@implementation CalendarTableViewController
-(NSNumber *)lookingDayFrom2001
{
    return self.calendarVC.lookingDayFrom2001;
}

-(NSInteger) todayFrom2001
{
//    if (!_todayFrom2001) {
//        _todayFrom2001=[[Day dayTodayinContext:self.managedObjectContext].from2001 integerValue];
//    }
    _todayFrom2001=[[NSDate dayToday] daysFrom2001];
    return _todayFrom2001;
}
-(void) refreshTodayFrom2001
{
    self.todayFrom2001=[[Day dayTodayinContext:self.managedObjectContext].from2001 integerValue];
}

- (IBAction)goToDate:(id)sender
{
    Day *day=[Day dayTodayinContext:self.managedObjectContext];
    Day *dayToGo=nil;
    
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *button=(UIButton *)sender;
        
        if ([[[[button superview]superview]superview] isKindOfClass:[CalendarTableViewCell class]]) {
            CalendarTableViewCell *cell =(CalendarTableViewCell *)[[[button superview]superview]superview];
            NSSortDescriptor *sortDescriptor=[NSSortDescriptor sortDescriptorWithKey:@"from2001" ascending:YES];
            NSArray *days=[cell.week.days sortedArrayUsingDescriptors:@[sortDescriptor]];
            if ([days objectAtIndex:([sender tag]-1)]) {
                dayToGo=[days objectAtIndex:([sender tag]-1)];
            }
            
        }
        
    }
    
    //[self selectCell];
    id detailvc=[self.splitViewController.viewControllers lastObject];
    
    if ([detailvc isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabDetailVC=(UITabBarController *)detailvc;
        
        if ([[tabDetailVC.viewControllers firstObject] isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController * navDetailvc=[tabDetailVC.viewControllers firstObject];
            tabDetailVC.selectedViewController=navDetailvc;
            
            if ([dayToGo isEqual:day]){
                if ([[navDetailvc.viewControllers firstObject] isKindOfClass:[TodayVC class]]) {
                    TodayVC *tvc=(TodayVC *)[navDetailvc.viewControllers firstObject];
                    tvc.test=@"test";
                    tvc.day=day;
                    
                    
                    //[tvc updateUI];
                }
            }else{
                if ([[navDetailvc.viewControllers firstObject] isKindOfClass:[TodayVC class]]) {
                    //DayVC *dayVC=[[DayVC alloc]init];
                    //dayVC.day=dayToGo;
                    
                    //DayVC *dvc=(DayVC *)[navDetailvc.viewControllers objectAtIndex:1];
                    //dvc.day=dayToGo;
                    //[navDetailvc pushViewController:dvc animated:YES];
                    //[dvc updateUI];
                    
                    TodayVC *tvc=(TodayVC *)[navDetailvc.viewControllers firstObject];
                    tvc.test=@"test";
                    tvc.day=dayToGo;
                    
                    
                    //[tvc updateUI];
                    
                }
                
            }

            
            
            
            
        }
        
    }
}

-(void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserverForName:MultiDatabaseAvailabilityNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.managedObjectContext=note.userInfo[MultiDatabaseAvailabilityContext];
        //NSLog(@"Notification recived by VisaViewController");
        
    }];
}


-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext=managedObjectContext;
    
    //NSLog(@"Context in CalendarTableViewController is set");
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Week"];
    request.predicate=nil;
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001" ascending:YES selector:@selector(compare:)]];
    request.fetchBatchSize=100;
    
    //request.sortDescriptors=@[];
    self.fetchedResultsController=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];

    [self selectCellAnimated:NO];

    
}

-(void) selectCellAnimated: (BOOL) animated
{
        NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Week"];
    request.predicate=[NSPredicate predicateWithFormat:@"from2001 == %@",[NSNumber numberWithInteger:[[NSDate dateTo12h00EUfromDate:[NSDate date]] weeksFrom2001]]];
    //NSLog(@"%ld", (long)[[NSDate dateTo12h00EUfromDate:[NSDate date]] weeksFrom2001]);
    
    NSError *error;
    NSArray *match=[self.managedObjectContext executeFetchRequest:request error:&error];
    //NSLog(@"%@", (Week *)match[0]);
    if ([match count]) {
        NSIndexPath *indexPath=[self.fetchedResultsController indexPathForObject:(Week *)match[0]];
        indexPath= [NSIndexPath indexPathForRow:(indexPath.row + 5) inSection:indexPath.section];
        [self.tableView selectRowAtIndexPath:indexPath animated:animated scrollPosition:UITableViewScrollPositionMiddle];
        
    }
}
-(void) selectCell
{

    [self selectCellAnimated:YES];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Calendar Cell"];
    //cell setFrame:CGRectMake(0, 0, 320, 40);
    
    Week *week=[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.week=week;
    cell.todayFrom2001=self.todayFrom2001;
    cell.lookingDayFrom2001=[self.lookingDayFrom2001 integerValue];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshTodayFrom2001];
    
    if ([self.tableView indexPathForSelectedRow]) {
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    }

}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    NSIndexPath *indexPath=nil;
//    if ([sender isKindOfClass:[CalendarTableViewCell class]])
//    {
//        indexPath=[self.tableView indexPathForCell:sender];
//        NSLog(@"Cell is ready");
//    }
//}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
