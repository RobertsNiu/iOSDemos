//
//  MessageViewController.h
//  WeChat
//
//  Created by Ronan on 14-2-10.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSMessagesViewController.h"
@interface MessageViewController : JSMessagesViewController<NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSString * toPer;


@property (strong, nonatomic) NSFetchedResultsController * fetchedResultsController;
@end
