//
//  MessageViewController.m
//  WeChat
//
//  Created by Ronan on 14-2-10.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//
#import "MessageViewController.h"
#import "JSMessage.h"
#import "Message.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
@interface MessageViewController ()<JSMessagesViewDataSource,JSMessagesViewDelegate>
@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) NSDictionary *avatars;
@end

@implementation MessageViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    UIApplication * app = [UIApplication sharedApplication];
    id delegate = app.delegate;
    self.managedObjectContext = [delegate managedObjectContext];
    
    
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Message class])];
    
    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    
    [request setSortDescriptors:@[sort]];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"person==%@",self.toPer];
    NSLog(@"toper = %@",self.toPer);
    [request setPredicate:predicate];
    
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    __autoreleasing NSError * error;
    [self.fetchedResultsController performFetch:&error];
    
    
    
    
    self.delegate = self;
    self.dataSource = self;
    [super viewDidLoad];
    [[JSBubbleView appearance] setFont:[UIFont systemFontOfSize:16.0f]];

    self.title = @"Messages";
    self.messageInputView.textView.placeHolder = @"New Message";
    
    [self setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

#pragma mark - Messages view delegate: REQUIRED

- (void)didSendText:(NSString *)text fromSender:(NSString *)sender onDate:(NSDate *)date
{
    
    //将接收到的数据插入coreData
    Message * temp_message = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Message class]) inManagedObjectContext:self.managedObjectContext];
    //将 message的属性进行赋值
    temp_message.person = self.toPer;
    temp_message.text = text;
    temp_message.date = date;
    temp_message.sender = sender;
    
    __autoreleasing NSError * error;
    [self.managedObjectContext save:&error];
    
    //将message转化成xmppmessage发送出去
    
    
    [self.messageInputView.textView setText:nil];
    [self textViewDidChange:self.messageInputView.textView];
    
    if ((self.messages.count - 1) % 2) {
        [JSMessageSoundEffect playMessageSentSound];
    }
    else {
        [JSMessageSoundEffect playMessageReceivedSound];
    }
//   [self finishSend];
    [self scrollToBottomAnimated:YES];
}

- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row % 2) ? JSBubbleMessageTypeIncoming : JSBubbleMessageTypeOutgoing;
}

- (UIImageView *)bubbleImageViewWithType:(JSBubbleMessageType)type
                       forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2) {
        return [JSBubbleImageViewFactory classicBubbleImageViewForType:type style:JSBubbleImageViewStyleClassicSquareGray];
    }
    
    return [JSBubbleImageViewFactory classicBubbleImageViewForType:type style:JSBubbleImageViewStyleClassicSquareBlue];
}

- (JSMessageInputViewStyle)inputViewStyle
{
    return JSMessageInputViewStyleClassic;
}

#pragma mark - Messages view delegate: OPTIONAL

- (BOOL)shouldDisplayTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 3 == 0) {
        return YES;
    }
    return NO;
}

//
//  *** Implement to customize cell further
//
- (void)configureCell:(JSBubbleMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if ([cell messageType] == JSBubbleMessageTypeOutgoing) {
        cell.bubbleView.textView.textColor = [UIColor whiteColor];
        
        if ([cell.bubbleView.textView respondsToSelector:@selector(linkTextAttributes)]) {
            NSMutableDictionary *attrs = [cell.bubbleView.textView.linkTextAttributes mutableCopy];
            [attrs setValue:[UIColor blueColor] forKey:NSForegroundColorAttributeName];
            cell.bubbleView.textView.linkTextAttributes = attrs;
        }
    }
    
    if (cell.timestampLabel) {
        cell.timestampLabel.textColor = [UIColor lightGrayColor];
        cell.timestampLabel.shadowOffset = CGSizeZero;
    }
    
    if (cell.subtitleLabel) {
        cell.subtitleLabel.textColor = [UIColor lightGrayColor];
    }
}

//  *** Implement to use a custom send button
//
//  The button's frame is set automatically for you
//
//  - (UIButton *)sendButtonForInputView
//

//  *** Implement to prevent auto-scrolling when message is added
//
- (BOOL)shouldPreventScrollToBottomWhileUserScrolling
{
    return YES;
}

// *** Implemnt to enable/disable pan/tap todismiss keyboard
//
- (BOOL)allowsPanToDismissKeyboard
{
    return NO;
}

#pragma mark - Messages view data source: REQUIRED

- (JSMessage *)messageForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message * mess = [self.fetchedResultsController objectAtIndexPath:indexPath];

    JSMessage * m = [[JSMessage alloc]initWithText:mess.text sender:mess.sender date:mess.date];
    return m;
}

- (UIImageView *)avatarImageViewForRowAtIndexPath:(NSIndexPath *)indexPath sender:(NSString *)sender
{
    UIImage *image = [self.avatars objectForKey:sender];
    return [[UIImageView alloc] initWithImage:image];
}

#pragma mark - CoreData fetchController delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

@end
