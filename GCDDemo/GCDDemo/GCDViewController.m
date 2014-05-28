//
//  GCDViewController.m
//  Operation+GCDDemo
//
//  Created by cora1n on 14-4-4.
//  Copyright (c) 2014年 devwu.com. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // --|
    //    NSThred
    // --|
    //    NSOpertionQueue
    // --|
    //    GCD
    //
    // Grand Central Dispatch
    
    //内置两个队列  main global
//    dispatch_get_main_queue();
    
    //并发队列
//   dispatch_get_global_queue
    
    //在 某一个队列中 异步 执行 代码块
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //在主队列中,异步方式休息三秒后,加上一块 红色view
//        sleep(3);
//        UIView * v = [[UIView alloc]initWithFrame:CGRectMake(30, 30, 100, 100)];
//        [v setBackgroundColor:[UIColor redColor]];
//        [self.view addSubview:v];
//    });
    
    
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSLog(@"开始下载");
//        UIImage *i = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://imgwww.heiguang.net/f/2013/0614/20130614090802737.jpg"]]];
//        NSLog(@"下载结束");
//            dispatch_async(dispatch_get_main_queue(), ^{
//                UIImageView * iv= [[UIImageView alloc]initWithImage:i];
//                [self.view addSubview:iv];
//            });
//    });
    
    //GCD 单例
//    for (int i =0 ; i<10; i++) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            NSLog(@"123");
//        });
//    }
    
    /**
     *  多次执行代码块
     *
     *  @param iterations 执行次数
     *  @param queue      执行队列
     *  @param block      执行代码块
     *  @param block(size_t n) 第n次执行
     */
//    dispatch_apply(3, dispatch_get_global_queue(0, 0), ^(size_t i) {
//        NSLog(@"%ld",i);
//    });
    
    
    //异步执行代码块
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"333");
//    });
    //异步执行c函数
//    dispatch_async_f(dispatch_get_global_queue(0, 0), @"123", show);
    
    //自定义队列
//    dispatch_queue_attr_t
//    DISPATCH_QUEUE_CONCURRENT
//    DISPATCH_QUEUE_SERIAL
//    dispatch_queue_t qqq = dispatch_queue_create("qqq",  DISPATCH_QUEUE_SERIAL);
//    //为dispach对象设置上下文
//    dispatch_set_context(qqq,@"我是qqq");
//    NSLog(@"%@",dispatch_get_context(qqq));
//    //获取队列的标签
//    NSLog(@"%s", dispatch_queue_get_label(qqq));
//    dispatch_async(qqq, ^{
//        NSLog(@"ddddd");
//    });
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)3*NSEC_PER_USEC);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//        
//        NSLog(@"3秒后.....");
//        
//    });
    
    
    __block UIImage *iv1;
    __block UIImageView *iv2;
    //创建串行队列
    dispatch_queue_t q2 =   dispatch_queue_create("q2", DISPATCH_QUEUE_SERIAL);
    //组管理
    dispatch_group_t g1 = dispatch_group_create();
    //向q2队列中添加属于g1组的任务(task)
    dispatch_group_async(g1, q2, ^{
        NSLog(@"iv1开始下载");
        iv1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://imgwww.heiguang.net/f/2013/0614/20130614090802737.jpg"]]];
        NSLog(@"iv1下载完成");
        NSLog(@"%@",iv1);

        
    });
    dispatch_group_async(g1, q2, ^{
        NSLog(@"iv2开始下载");

        iv2 = [[UIImageView alloc]initWithImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/w%3D2048/sign=0a758254014f78f0800b9df34d090b55/29381f30e924b899589965386c061d950a7bf60d.jpg"]]]];
        NSLog(@"iv2下载完成");
        NSLog(@"%@",iv2);

    });
   
    
    dispatch_group_notify(g1, q2, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"%@",iv1);
            NSLog(@"%@",iv2);
            //注意!!  不要在线程间传递UIVIew对象,容易出现内存问题
//            UIImageView *i1 = [[UIImageView alloc]initWithImage:iv1];
//            [self.view addSubview:i1];
////            UIImageView *i2 = [[UIImageView alloc]initWithImage:iv2];
//            [self.view addSubview:iv2];
            NSLog(@"加载完成");
        });
    });
    
    
}
void show(void * str)
{
    NSLog(@"%@",str);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
