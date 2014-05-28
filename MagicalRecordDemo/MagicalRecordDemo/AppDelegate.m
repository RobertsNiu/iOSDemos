//
//  AppDelegate.m
//  MagicalRecordDemo
//
//  Created by Ronan on 14-2-18.
//  Copyright (c) 2014年 Ronan. All rights reserved.
//

#import <MagicalRecord/CoreData+MagicalRecord.h>

#import "AppDelegate.h"
#import "ViewController.h"
#import "Person.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController= [[ViewController alloc]init];
    
    [MagicalRecord setupCoreDataStack];
    
    Person * p = [Person MR_createEntity];
    p.name = @"张三";
    p.age = @22;

    [[NSManagedObjectContext MR_defaultContext]MR_saveOnlySelfAndWait];
    NSLog(@"%@",[NSBundle mainBundle]);
    
    NSLog(@"%@",[[Person MR_findAll] lastObject]);
    
    return YES;
}

@end
