//
//  MyConnectionViewController.m
//  CallBackDemo
//
//  Created by cora1n on 14-4-2.
//  Copyright (c) 2014年 devwu.com. All rights reserved.
//

#import "MyConnectionViewController.h"
#import "MyConnect.h"
@interface MyConnectionViewController ()

@end

@implementation MyConnectionViewController

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
    
    NSMutableData * d = [[NSMutableData alloc]init];
    
    
    MyConnect * conn = [MyConnect
                myConnWithReceiveRes:^(NSURLConnection *oconnection, NSURLResponse *response)
                        {
                            NSLog(@"收到响应,%@",response);
                        }
                        ReceiveData:^(NSURLConnection *oconnection, NSData *data)
                        {
                            NSLog(@"收到数据,%@",data);
                            [d appendData:data];
                        }
                       ReceiveError:^(NSURLConnection *oconnection, NSError *err)
                        {
                            NSLog(@"收到错误,%@",err);
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"请求失败,请再次尝试" delegate:nil cancelButtonTitle:@"好吧" otherButtonTitles: nil];
                            [alert show];
                        }
                  ConnFinishLoading:^(NSURLConnection *oconnection)
                        {
                            UIImage * img = [UIImage imageWithData:d];
                            UIImageView * v = [[UIImageView alloc]initWithImage:img];
                            [self.view addSubview:v];
                            NSLog(@"请求结束");
                        }
     ];
    [conn sendRequestWithURL:[NSURL URLWithString:@"http://www.sinaimg.cn/dy/slidenews/4_img/2014_13/704_1276120_835433.jpg"]];
    
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
