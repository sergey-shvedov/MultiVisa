//
//  TripsCDTVC.m
//  MultiTest
//
//  Created by Administrator on 29.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "TripsCDTVC.h"
#import "Trip.h"
#import "Country.h"
#import "TripAddVC.h"
#import "TripTemp.h"
#import "NSDate+Project.h"
#import "NSString+Project.h"
#import "UIColor+Project.h"
#import "NSDateFormatter+Project.h"

@interface TripsCDTVC ()

@end

@implementation TripsCDTVC

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext=managedObjectContext;
    
    //NSLog(@"Context in TripsCDTVC is set");
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Trip"];
    request.predicate=nil;
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"entryDate" ascending:NO selector:@selector(compare:)]];
    
    self.fetchedResultsController=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Trip Cell"];
    
    Trip *trip=[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSString *text;
    NSString *detailedText;
    
    if ([trip.title isEqualToString:@"Мое путешествие"] || ![trip.title length]) {
        text=[NSString stringWithFormat:@"%@", trip.entryCountry.titleRUS];
    }else{
        text=[NSString stringWithFormat:@"%@", trip.title];
    }
    NSInteger tripDays=[NSDate daysFromDate:trip.entryDate toDate:trip.outDate];
    
    
    detailedText=[NSString stringWithFormat:@"%@ — %@ (%ld %@)",
                  [NSDateFormatter multiVisaLocalizedStringFromDate:trip.entryDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle],
                  [NSDateFormatter multiVisaLocalizedStringFromDate:trip.outDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle],
                  (long)tripDays,
                  [NSString stringByRussianFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:tripDays]
                  ];


    
    cell.textLabel.text=text;
    cell.detailTextLabel.text=detailedText;
    
    
    ////////////////////////////////////  Create the icon for the cell
    NSString *name=@"xTrip";
    
    if (NSOrderedDescending==[trip.outDate compare:[NSDate dateTo12h00EUfromDate:[NSDate date]]]) { //Active Trip
        if ([trip.type isEqualToNumber:@0]) {
            name=[name stringByAppendingString:@"0"];
        }else if ([trip.type isEqualToNumber:@1]){
            name=[name stringByAppendingString:@"1"];
        }else{
            name=[name stringByAppendingString:@"2"];
        }
        [cell.textLabel setTextColor:[UIColor blackColor]];
        [cell.detailTextLabel setTextColor:[UIColor blackColor]];
    }else{ //Past Trip
        if ([trip.type isEqualToNumber:@0]) {
            name=[name stringByAppendingString:@"0Gray"];
        }else if ([trip.type isEqualToNumber:@1]){
            name=[name stringByAppendingString:@"1Gray"];
        }else{
            name=[name stringByAppendingString:@"2Gray"];
        }
        [cell.textLabel setTextColor:[UIColor colorCalendarOldDate]];
        [cell.detailTextLabel setTextColor:[UIColor colorCalendarOldDate]];
    }
    
    cell.imageView.image=[UIImage imageNamed:name] ? : [UIImage imageNamed:@"xTrip2Gray"];
    
    UIImage *flag=nil;
    
    NSString *name2=[@"iTrip" stringByAppendingString:trip.entryCountry.title];
    if ([name2 isEqualToString:@"iTripEU"]) {
        //flag=[UIImage imageNamed:@"iTripEU"];;
    }else{
        flag=[UIImage imageNamed:name2] ? : [UIImage imageNamed:@"iTripEU"];
    }
    if (flag) {
        UIImageView *flagView=[[UIImageView alloc]initWithImage:flag];
    [flagView setFrame:CGRectMake(24.0, 19.0, 12.0, 10.0)];
    [cell.imageView addSubview:flagView];
    }
    

    
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
    //Editting trip
    Trip *trip =[self.fetchedResultsController objectAtIndexPath:indexPath];
    if ([vc isKindOfClass:[TripAddVC class]]) {
        TripAddVC *tripAVC = (TripAddVC *)vc;
        tripAVC.trip=trip;
        tripAVC.editingTrip = [TripTemp editingTripTempCopyFromTrip:trip];
        tripAVC.managedObjectContext=self.managedObjectContext;
        tripAVC.userEditingTrip=self.user;
        tripAVC.isCreating=NO;
        
        
        //NSLog(@"TripAVC is Editing");
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath=nil;
    if ([sender isKindOfClass:[UITableViewCell class]]){
        indexPath=[self.tableView indexPathForCell:sender];
    }
    if ([segue.identifier isEqualToString:@"Edit Trip"]) {
        if ([segue.destinationViewController isKindOfClass:[TripAddVC class]]) {
            [self prepareVC:segue.destinationViewController forSegue:segue.identifier fromIndexPatch:indexPath];
            //NSLog(@"Prepare for TripAddVC");
            
        }
    }
}


@end
