//
//  DetailViewController.h
//  TravisDemo
//
//  Created by Ronan on 14-1-16.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
