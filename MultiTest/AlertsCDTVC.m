//
//  AlertsCDTVC.m
//  MultiTest
//
//  Created by Administrator on 29.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "AlertsCDTVC.h"

#import "Visa.h"
#import "Country.h"
#import "VisaAddVC.h"
#import "VisaTemp.h"

@interface AlertsCDTVC ()

@end

@implementation AlertsCDTVC

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext=managedObjectContext;
    
    //NSLog(@"Context in AlertsCDTVC is set");
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Visa"];
    request.predicate=nil;
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"endDate" ascending:NO selector:@selector(compare:)]];
    //request.sortDescriptors=@[];
    self.fetchedResultsController=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Alert Cell"];
    
    Visa *visa=[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text=[NSString stringWithFormat:@"Виза %@ : %@", visa.typeABC, visa.forCountry.titleRUS];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@ дней",visa.days];
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
