//
//  AppDelegate.m
//  CDDemo5
//
//  Created by cora1n on 14-4-18.
//  Copyright (c) 2014年 devwu. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData+MagicalRecord.h>
#import <CoreData/CoreData.h>
#import "TableViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    [MagicalRecord setupCoreDataStack];
    
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[TableViewController alloc]init]];

    return YES;
}

@end
