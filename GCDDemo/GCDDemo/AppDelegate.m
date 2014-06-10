//
//  AppDelegate.m
//  GCDDemo
//
//  Created by cora1n on 14-4-3.
//  Copyright (c) 2014年 devwu.com. All rights reserved.
//

#import "AppDelegate.h"
#import "OperationQueueViewController.h"
#import "GCDViewController.h"
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    self.window.rootViewController = [[OperationQueueViewController alloc]init];
    
    self.window.rootViewController = [[GCDViewController alloc]init];
    return YES;
}



@end
