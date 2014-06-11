//
//  AppDelegate.m
//  ShareSDKDemo
//
//  Created by Ronan on 14-1-3.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#define APPKEY @"10878c8a7965"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [ShareSDK registerApp:APPKEY useAppTrusteeship:YES];
    
    RootViewController *root = [[RootViewController alloc]init];
    self.window.rootViewController = root;


//    id<ISSAuthOptions> options = [ShareSDK authOptionsWithAutoAuth:YES allowCallback:NO authViewStyle:SSAuthViewStyleFullScreenPopup viewDelegate:self authManagerViewDelegate:self];
    
    id<ISSAuthOptions> opt = [ShareSDK authOptionsWithAutoAuth:YES allowCallback:NO scopes:nil powerByHidden:YES followAccounts:nil authViewStyle:SSAuthViewStyleModal viewDelegate:self authManagerViewDelegate:self];
    [ShareSDK waitAppSettingComplete:^{
        [ShareSDK authWithType:ShareTypeSinaWeibo options:opt result:^(SSAuthState state, id<ICMErrorInfo> error) {
            if (state==SSAuthStateSuccess) {
            NSLog(@"%@", [[ShareSDK getCredentialWithType:ShareTypeSinaWeibo] token]);
            }
//            if (state==SSAuthStateCancel) {
//                NSLog(@"取消");
//            }
//            if (state==SSAuthStateBegan) {
//                NSLog(@"开始");
//            }
//            if (state==SSAuthStateFail) {
//                NSLog(@"失败");
//            }

        }];

            }];
    
    return YES;
}
-(void)viewOnWillDisplay:(UIViewController *)viewController shareType:(ShareType)shareType
{
    NSLog(@"1  %@",NSStringFromClass([viewController class]));
//    viewController.navigationItem.rightBarButtonItem=nil;
//    [viewController setTitle:@"123"];
//    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"1"] forBarMetrics:UIBarMetricsDefault];
}
-(void)viewOnWillDismiss:(UIViewController *)viewController shareType:(ShareType)shareType
{
    NSLog(@"2");
}
-(void)view:(UIViewController *)viewController autorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation shareType:(ShareType)shareType
{
    NSLog(@"3");
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
