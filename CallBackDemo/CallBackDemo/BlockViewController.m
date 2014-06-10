//
//  BlockViewController.m
//  CallBackDemo
//
//  Created by cora1n on 14-4-2.
//  Copyright (c) 2014年 devwu.com. All rights reserved.
//

#import "BlockViewController.h"
#import "MyView2.h"
@interface BlockViewController ()<NSURLConnectionDataDelegate>

@end

@implementation BlockViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //任务:
        //创建自定义MyView,使其具备触摸功能
        //在MyView2中创建代码块属性,每次触摸该view对象时,触发该代码块
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    MyView2 * mv = [[MyView2 alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [mv setBackgroundColor:[UIColor blueColor]];
//    mv.backgroundColor =[UIColor redColor];
    //lamba closure 闭包,块
    
    //1.创建软引用,解决强引用循环问题
    __weak MyView2 * weakMv = mv;
    //2.跟踪变量,即不对该变量进行copy
    //block中使用外部变量时,会先对外部变量进行copy,生成一个快照,
    //此后外部变量的变化block不再接收
    //为了持续跟踪外部变量,常在需要跟踪的变量前加上__block
    __block long long i = 10;
//    NSObject * obj = [[NSObject alloc]init];
    //block创建时所引用的外部变量,都会被copy到block中
    [mv setBlock:^(MyView2* _mv){
//        NSObject * _obj = [obj copy];
        NSLog(@"%lld",i);
        [weakMv setBackgroundColor:[UIColor yellowColor]];
    }];
    i = 20;
    
    //用block代替NSURLConnection 四个常用回调函数
    [self.view addSubview:mv];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
