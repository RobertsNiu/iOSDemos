//
//  TableViewController.h
//  CDDemo5
//
//  Created by cora1n on 14-4-21.
//  Copyright (c) 2014年 devwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface TableViewController : UITableViewController <NSFetchedResultsControllerDelegate>
@property(nonatomic,strong) NSFetchedResultsController * frc;
@end
