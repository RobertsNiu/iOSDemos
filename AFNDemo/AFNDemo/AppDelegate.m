//
//  AppDelegate.m
//  AFNDemo
//
//  Created by Ronan on 14-1-22.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window =[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[MasterViewController alloc]init];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    return YES;
}


@end
