//
//  MainViewController.m
//  WeChat
//
//  Created by Ronan on 14-2-8.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    

    
    
    
    
    
    [super viewDidLoad];
    NSString * tabbarBgStr;
    NSString * navigationBarBgStr;
    if ([UIDevice currentDevice].systemVersion.floatValue<7.0) {
        tabbarBgStr = @"TabbarBkg";
        navigationBarBgStr = @"navigationbg";
    }
    else{
        //ios7 适配

        tabbarBgStr = @"TabbarBkg_ios7";
        navigationBarBgStr = @"navigationbg_ios7";
        [self.tabBar setTranslucent:NO];
    }
//    [self.tabBar setBackgroundImage:[UIImage imageNamed:tabbarBgStr]];
    self.tabBar.hidden = YES;
    
    UIImageView * tabbar = [[UIImageView alloc]initWithFrame:self.tabBar.frame];
    [tabbar setImage:[UIImage imageNamed:tabbarBgStr]];
    [tabbar setUserInteractionEnabled:YES];
    [self.view addSubview:tabbar];
    UIButton * weChatItemButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 49)];
    [weChatItemButton setBackgroundImage:[UIImage imageNamed:@"tabbar_mainframe_ios7@2x"] forState:UIControlStateNormal];
    [weChatItemButton setBackgroundImage:[UIImage imageNamed:@"tabbar_mainframeHL_ios7@2x"] forState:UIControlStateSelected];
    
    [weChatItemButton setTitle:@"微信" forState:UIControlStateNormal];
    [weChatItemButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [weChatItemButton setSelected:YES];
    [weChatItemButton.titleLabel setCenter:CGPointMake(40, 40)];

    UIButton * contactItemButton = [[UIButton alloc]initWithFrame:CGRectMake(80, 0, 80, 49)];
    [contactItemButton setBackgroundImage:[UIImage imageNamed:@"tabbar_contacts_ios7@2x"] forState:UIControlStateNormal];
    [contactItemButton setBackgroundImage:[UIImage imageNamed:@"tabbar_contactsHL_ios7@2x"] forState:UIControlStateSelected];
    
    [tabbar addSubview:weChatItemButton];
    [tabbar addSubview:contactItemButton];
    NSArray* titles = @[@"微信",@"通讯录",@"发现",@"我"];
    for (int i = 0 ; i<self.viewControllers.count; i++) {
        UINavigationController* vc = self.viewControllers[i];
        [vc.navigationBar setBackgroundImage:[UIImage imageNamed:navigationBarBgStr] forBarMetrics:UIBarMetricsDefault];
        [vc.viewControllers[0] setTitle:titles[i]];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
