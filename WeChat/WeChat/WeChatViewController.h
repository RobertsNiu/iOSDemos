//
//  WeChatViewController.h
//  WeChat
//
//  Created by Ronan on 14-2-8.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeChatViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
