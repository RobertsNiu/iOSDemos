//
//  DelegateViewController.m
//  CallBackDemo
//
//  Created by cora1n on 14-4-2.
//  Copyright (c) 2014年 devwu.com. All rights reserved.
//

#import "DelegateViewController.h"
//导入具备点击功能的MyView
#import "MyView1.h"


@interface DelegateViewController ()<MyViewDelegate>

@end

@implementation DelegateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //任务:
        //自定义一个UIView,使其具有touch事件
        //把这个自定义的UIView加载到当前的self.view中
        //每次点击该view对象时,在本类中触发viewDidCliked事件
    }
    return self;
}

-(void)viewDidClicked:(UIView *)v
{
    NSLog(@"456");
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    MyView1 * mv = [[MyView1 alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    mv.delegate= self;
    [mv setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:mv];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
