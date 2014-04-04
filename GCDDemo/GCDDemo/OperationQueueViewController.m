//
//  OperationQueueViewController.m
//  GCDDemo
//
//  Created by cora1n on 14-4-3.
//  Copyright (c) 2014年 devwu.com. All rights reserved.
//

#import "OperationQueueViewController.h"

@interface OperationQueueViewController ()
{
    UIImage * image;
}
@end

@implementation OperationQueueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    [UINavigationBar appearance];
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    //操作队列demo
    //    [self queueDemo];
    //    [self operationDemo];
    
    //在副队列中,延迟三秒后回到主队列,并添加一个背景色为红色的view
            //-----------
    NSLog(@"1 :: %@",[NSThread currentThread]);
    
    NSOperationQueue * q = [[NSOperationQueue alloc]init];
    [q addOperationWithBlock:^{
            //-----------
        NSLog(@"2 :: %@",[NSThread currentThread]);
        
        sleep(3);
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            //-----------
            NSLog(@"3 :: %@",[NSThread currentThread]);
            
            UIView * v = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 300, 300)];
            [v setBackgroundColor:[UIColor redColor]];
            [self.view addSubview:v];
        }];
    }];
    
}

- (void)operationDemo
{
    
    //操作demo
    //NSOperation是一个抽象类,不能被直接使用,但它提供了两个子类,Invocation,Block
    
    //代码不易维护,不推荐
    //    [NSInvocationOperation alloc]initWithTarget:(id) selector:<#(SEL)#> object:<#(id)#>
    
    //操作对象1
    NSBlockOperation * o1 = [NSBlockOperation blockOperationWithBlock:^{
        
        for (int i = 1000; i<1100; i++) {
            NSLog(@"%d",i);
        }
    }];
    //设置优先级为100,优先级只是一个概率,异步执行时还是乱序执行
    [o1 setQueuePriority:NSOperationQueuePriorityLow];
    //操作对象2
    NSBlockOperation * o2 = [NSBlockOperation blockOperationWithBlock:^{
        //        sleep(3);
        //        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/w%3D2048/sign=47f78116be315c6043956cefb989cb13/c83d70cf3bc79f3d5fd5c933b8a1cd11728b29f8.jpg"]]];
        for (int i = 0; i<100; i++) {
            NSLog(@"%d",i);
        }
    }];
    //设置优先级为-100
    [o2 setQueuePriority:NSOperationQueuePriorityHigh];
    NSOperationQueue * q2 = [[NSOperationQueue alloc]init];
    
    //依赖管理
    //o2 依赖于 o1,只有当o1执行完毕后,o2方可执行
    //    [o2 addDependency:o1];
    
    [q2 addOperation:o1];
    [q2 addOperation:o2];
    [q2 setName:@"操作队列2"];
    
    // o2执行结束时,代码块
    [o2 setCompletionBlock:^{
        //o2结束后,回到主线程中, 操作UI界面
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            UIImageView * iv = [[UIImageView alloc]initWithImage:image];
            
            [self.view addSubview:iv];
        }];
    }];
}

-(void)queueDemo
{
    /**
     *  查看队列
     */
    NSLog(@"%@", [NSOperationQueue mainQueue]);     //主队列
    NSLog(@"%@", [NSOperationQueue currentQueue]);  //查看当前执行的代码所在队列
    
    //1.创建一个自己的队列
    NSOperationQueue * q1 = [[NSOperationQueue alloc]init];
    //2.向队列中添加任务
    //一旦操作加入到队列中,则立即执行
    
    //设置队列的最大并发数
    [q1 setMaxConcurrentOperationCount:1];
    
    //向队列中添加第一个任务对象
    [q1 addOperationWithBlock:^{
        for (int i =0; i<10; i++) {
            NSLog(@"123");
        }
    }];
    
    //将q1队列挂起  == 待机
    [q1 setSuspended:YES];
    
    //向队列中添加第二个任务对象
    [q1 addOperationWithBlock:^{
        for (long i =0; i<10; i++) {
            NSLog(@"789");
        }
        NSLog(@"%@", [NSOperationQueue currentQueue]);  //查看当前执行的代码所在队列
        
    }];
    
    /**
     *  外部执行函数
     */
    for (int i =0 ; i<10; i++) {
        NSLog(@"456");
    }
    
    //恢复队列 ,resume
    [q1 setSuspended:NO];
    [q1 setName:@"队列1"];
    //当q1队列中的操作完成后,才继续向下执行
    [q1 waitUntilAllOperationsAreFinished];
    
    //主线程等待q1执行结束,造成UI阻塞
    NSLog(@"q1操作队列结束");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
