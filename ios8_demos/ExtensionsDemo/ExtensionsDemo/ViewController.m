//
//  ViewController.m
//  ExtensionsDemo
//
//  Created by cora1n on 14-6-11.
//  Copyright (c) 2014年 devwu. All rights reserved.
//

#import "ViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface ViewController ()
            

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NCWidgetController alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
