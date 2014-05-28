//
//  TableViewController.m
//  CDDemo5
//
//  Created by cora1n on 14-4-21.
//  Copyright (c) 2014年 devwu. All rights reserved.
//

#import "TableViewController.h"
#import <CoreData+MagicalRecord.h>
#import "Person.h"
@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}
-(void)doLeft
{
    Person * p = [Person MR_createEntity];
    static int a;
    a++;
    NSArray * firstName = @[@"张",@"王",@"李",@"赵"];
    NSArray * lastName = @[@"三",@"四",@"五",@"六"];
    NSString * fullName = [NSString stringWithFormat:@"%@%@",firstName[arc4random()%4],lastName[arc4random()%4]];
    NSArray * genderArr = @[@"男",@"女"];
    [p setName:fullName];
    [p setAge:[NSNumber numberWithInt:a]];
    [p setGender:genderArr[arc4random()%2]];
    

    [[NSManagedObjectContext MR_defaultContext]MR_saveOnlySelfAndWait];

}
-(void)doRight
{
    [Person MR_truncateAll];
    [[NSManagedObjectContext MR_defaultContext]MR_saveOnlySelfAndWait];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(doLeft)];
    [self.navigationItem setLeftBarButtonItem:left animated:YES];
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(doRight)];
    [self.navigationItem setRightBarButtonItem:right];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.frc.sections[section] name];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [self configCell:cell WithIndexPath:indexPath];
    return cell;
}
-(void)configCell:(UITableViewCell*)cell WithIndexPath:(NSIndexPath*)indexPath
{
    Person * p = [self.frc objectAtIndexPath:indexPath];
    cell.textLabel.text=p.name;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.frc.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> info =self.frc.sections[section];
    return [info numberOfObjects];
}

#pragma --mark CoreData Delegate
-(NSFetchedResultsController *)frc
{
    _frc = [Person MR_fetchAllSortedBy:@"gender,age" ascending:YES withPredicate:nil groupBy:@"gender" delegate:self];
    return _frc;
}


-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
        default:
            break;
    }
}
-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}
@end
