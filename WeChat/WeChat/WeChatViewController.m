//
//  WeChatViewController.m
//  WeChat
//
//  Created by Ronan on 14-2-8.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import "WeChatViewController.h"
#import "WeChatCell.h"
#import "XMPPService.h"
#import "XMPPManager.h"
#import "Message.h"
#import <DDLog.h>
static const int ddLogLevel = LOG_LEVEL_OFF;
@interface WeChatViewController ()
{
    
}
@end

@implementation WeChatViewController

- (void)viewDidLoad
{
    NSManagedObjectContext * context = [[XMPPManager shareInstance] xmppMessageArchivingCoreDataStorage];

    
    [super viewDidLoad];
    UIApplication * app = [UIApplication sharedApplication];
    id delegate = app.delegate;
    
    self.managedObjectContext = [delegate managedObjectContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc]initWithEntityName:@"Message"];
    
    
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    
    [request setSortDescriptors:@[sortDescriptor]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    NSError * err;
    if(![self.fetchedResultsController performFetch:&err])
    {
        DDLogVerbose(@"%@",err);
    }
    
    
    [[XMPPService shareInstance] receivedMessage:^(XMPPMessage *message) {
        //将接收到的数据插入coreData
        Message * temp_message = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Message class]) inManagedObjectContext:self.managedObjectContext];
        //将 message的属性进行赋值
        temp_message.person = [message fromStr];
        temp_message.text = [message body];
        temp_message.date = [NSDate date];
        temp_message.sender = [message fromStr];
        __autoreleasing NSError * error;
        [self.managedObjectContext save:&error];
        
        
    }];
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    WeChatCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
//
//  *** Implement to customize cell further
//
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - CoreData fetchController delegate

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}
-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
    }
}
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    [segue.destinationViewController setValue:@"test1@openfire/Spark 2.6.3" forKey:@"toPer"];
}


@end
