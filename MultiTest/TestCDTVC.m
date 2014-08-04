//
//  TestCDTVC.m
//  MultiTest
//
//  Created by Administrator on 03.06.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "TestCDTVC.h"

#import "Visa.h"
#import "Country.h"
#import "VisaAddVC.h"
#import "VisaTemp.h"
#import "Day.h"
#import "DayWithVisa.h"
#import "DayWithPassport.h"
#import "DayWithTrip.h"
#import "Trip.h"
#import "MultiTestAppDelegate.h"
#import "Passport.h"
#import "DayWithPassport+Create.h"
#import "NSString+Project.h"

@interface TestCDTVC ()

@end

@implementation TestCDTVC

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext=managedObjectContext;
    
    //DayVisa Test
    {
//        NSLog(@"Context in TsetCDTVC is set");
//        NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
//        request.predicate=[NSPredicate predicateWithFormat:@"visasByDay.@count!=0"];
//        request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001" ascending:YES selector:@selector(compare:)]];
//        
//        //request.sortDescriptors=@[];
//        self.fetchedResultsController=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];

    }
    //DayPassport Test
    {
//    NSLog(@"Context in TsetCDTVC is set");
//    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
//    request.predicate=[NSPredicate predicateWithFormat:@"passportsByDay.@count!=0"];
//    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001" ascending:YES selector:@selector(compare:)]];
//    
//    //request.sortDescriptors=@[];
//    self.fetchedResultsController=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
    {
//    NSLog(@"Context in TsetCDTVC is set");
//    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Day"];
//    request.predicate=[NSPredicate predicateWithFormat:@"tripsByDay.@count!=0"];
//    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"from2001" ascending:YES selector:@selector(compare:)]];
//    
//    //request.sortDescriptors=@[];
//    self.fetchedResultsController=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        }
    //Passport
    {
//    NSLog(@"Context in TsetCDTVC is set");
//    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Passport"];
//    request.predicate=[NSPredicate predicateWithFormat:@"type != %@",@100];
//    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"experationDate" ascending:NO selector:@selector(compare:)]];
//    
//    //request.sortDescriptors=@[];
//    NSManagedObjectContext *saveContext=((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).fetchContext;
//    self.fetchedResultsController=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:saveContext sectionNameKeyPath:nil cacheName:nil];
    }
    //DayWithPassport
    {
//    NSLog(@"Context in TsetCDTVC is set");
//    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"DayWithPassport"];
//    //request.predicate=[NSPredicate predicateWithFormat:@"type != %@",@100];
//    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"usedDay.from2001" ascending:NO selector:@selector(compare:)]];
//    
//    //request.sortDescriptors=@[];
//    NSManagedObjectContext *saveContext=((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).fetchContext;
//    self.fetchedResultsController=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
    //DayWithVisa
    {
//    NSLog(@"Context in TsetCDTVC is set");
//    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"DayWithVisa"];
//    //request.predicate=[NSPredicate predicateWithFormat:@"type != %@",@100];
//    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"usedDay.from2001" ascending:NO selector:@selector(compare:)]];
//    
//    //request.sortDescriptors=@[];
//    NSManagedObjectContext *saveContext=((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).fetchContext;
//    self.fetchedResultsController=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
    //DayWithTrip
    //NSLog(@"Context in TsetCDTVC is set");
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"DayWithTrip"];
    //request.predicate=[NSPredicate predicateWithFormat:@"type != %@",@100];
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"usedDay.from2001" ascending:NO selector:@selector(compare:)]];
    
    //request.sortDescriptors=@[];
    //NSManagedObjectContext *saveContext=((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).fetchContext;
    self.fetchedResultsController=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //DayVisa Test
    {
//        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Test Cell"];
//        
//        Day *day=[self.fetchedResultsController objectAtIndexPath:indexPath];
//        cell.textLabel.text=[NSString stringWithFormat:@"День %@ : %@", day.from2001, [NSDateFormatter localizedStringFromDate:day.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
//        DayWithVisa *dayWithVisa=(DayWithVisa *)[[day.visasByDay allObjects] firstObject];
//        cell.detailTextLabel.text=[NSString stringWithFormat:@"%lu: %@ - %@",
//                                   (unsigned long)[day.visasByDay count],
//                                   [NSDateFormatter localizedStringFromDate:dayWithVisa.inVisa.startDate  dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle],
//                                   [NSDateFormatter localizedStringFromDate:dayWithVisa.inVisa.endDate  dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]
//                                   ];
//        
//        return cell;
    }
    //DayPassport Test
    {
//        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Test Cell"];
//        
//        Day *day=[self.fetchedResultsController objectAtIndexPath:indexPath];
//        cell.textLabel.text=[NSString stringWithFormat:@"День %@ : %@", day.from2001, [NSDateFormatter localizedStringFromDate:day.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
//        DayWithPassport *dayWithPassport=(DayWithPassport *)[[day.passportsByDay allObjects] firstObject];
//        cell.detailTextLabel.text=[NSString stringWithFormat:@"%lu: %@ - %@",
//                                   (unsigned long)[day.passportsByDay count],
//                                   [NSDateFormatter localizedStringFromDate:dayWithPassport.inPassport.issueDate  dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle],
//                                   [NSDateFormatter localizedStringFromDate:dayWithPassport.inPassport.experationDate  dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]
//                                   ];
//        
//        return cell;
    }
    {
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Test Cell"];
//    
//    Day *day=[self.fetchedResultsController objectAtIndexPath:indexPath];
//    cell.textLabel.text=[NSString stringWithFormat:@"День %@ : %@", day.from2001, [NSDateFormatter localizedStringFromDate:day.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
//    DayWithTrip *dayWithTRip=(DayWithTrip *)[[day.tripsByDay allObjects] firstObject];
//    cell.detailTextLabel.text=[NSString stringWithFormat:@"%lu: %@ - %@:---%@",
//                               (unsigned long)[day.tripsByDay count],
//                               [NSDateFormatter localizedStringFromDate:dayWithTRip.inTrip.entryDate  dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle],
//                               [NSDateFormatter localizedStringFromDate:dayWithTRip.inTrip.outDate  dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle],
//                               day.last180TripDays
//                               ];
//    
//    return cell;
    }
    
    
    //Passports
    {
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Test Cell"];
//    
//    Passport *passport=[self.fetchedResultsController objectAtIndexPath:indexPath];
//    if ([passport.number length]) {
//        cell.textLabel.text=[NSString stringWithFormat:@"Паспорт %@ №%@",[NSString stringByPassportType:passport.type] , passport.number];
//    } else cell.textLabel.text=[NSString stringWithFormat:@"Паспорт %@",[NSString stringByPassportType:passport.type]];
//    
//    cell.detailTextLabel.text=[NSString stringWithFormat:@"Годен до: %@",[NSDateFormatter localizedStringFromDate:passport.experationDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle]];
//    
//    return cell;
}

    //DayWithPassport
    {
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Test Cell"];
//    
//    DayWithPassport *dwp=[self.fetchedResultsController objectAtIndexPath:indexPath];
//    
//    cell.textLabel.text=[NSString stringWithFormat:@"%@: №%@",[NSDateFormatter localizedStringFromDate:dwp.usedDay.date  dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle],dwp.inPassport.number];
//    
//    
//    //cell.detailTextLabel.text=[NSString stringWithFormat:@"Годен до: %@",[NSDateFormatter localizedStringFromDate:passport.experationDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle]];
//    
//    return cell;
    }
    //DayWithVisa
    {
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Test Cell"];
//    
//    DayWithVisa *dwp=[self.fetchedResultsController objectAtIndexPath:indexPath];
//    
//    cell.textLabel.text=[NSString stringWithFormat:@"%@: №%@",[NSDateFormatter localizedStringFromDate:dwp.usedDay.date  dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle],dwp.inVisa.forCountry.titleRUS];
//    
//    
//    cell.detailTextLabel.text=[NSString stringWithFormat:@"Годен до: %@",[NSDateFormatter localizedStringFromDate:dwp.inVisa.endDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle]];
//    
//    return cell;
}

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Test Cell"];
    
    DayWithTrip *dwp=[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@: №%@",[NSDateFormatter localizedStringFromDate:dwp.usedDay.date  dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle],dwp.inTrip.outCountry.titleRUS];
    
    cell.detailTextLabel.text=[NSString stringWithFormat:@"До: %@",[NSDateFormatter localizedStringFromDate:dwp.inTrip.outDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle]];
    
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
-(void)prepareVC:(id) vc forSegue: (NSString *) segueIdetifier fromIndexPatch:(NSIndexPath *) indexPath
{
    //Editting visa

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath=nil;
    if ([sender isKindOfClass:[UITableViewCell class]]){
        indexPath=[self.tableView indexPathForCell:sender];
    }

}


@end
