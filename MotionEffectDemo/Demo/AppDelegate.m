//
//  AppDelegate.m
//  Demo
//
//  Created by cora1n on 14-5-28.
//  Copyright (c) 2014年 devwu. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    ViewController * v = [[ViewController alloc]init];
    self.window.rootViewController = v;
    
    return YES;
}

@end
