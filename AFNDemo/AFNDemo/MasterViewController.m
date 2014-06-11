//
//  MasterViewController.m
//  AFNDemo
//
//  Created by Ronan on 14-1-22.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//
#import "MasterViewController.h"

#import <AFNetworking/AFNetworking.h>
#import <UIKit+AFNetworking.h>
@interface MasterViewController ()<UIAlertViewDelegate> {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    /**
     *  网络状态监控示例
     */
    //开启监控
    [[AFNetworkActivityIndicatorManager sharedManager]setEnabled:YES];
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    //设置网络状况监控后的代码块
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch ([[AFNetworkReachabilityManager sharedManager]networkReachabilityStatus]) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"WWAN");
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"Unknown");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"NotReachable");
                break;
            default:
                break;
        }
    }];
    

    
    
    
    
    //下载测试
    UIButton * b1 =[UIButton buttonWithType:UIButtonTypeSystem];
    [b1 setFrame:CGRectMake(30, 50, 80, 30)];
    [b1 setTitle:@"开始下载" forState:UIControlStateNormal];
    [b1 addTarget:self action:@selector(testGet:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b1];
    //上传测试
    UIButton * b2 =[UIButton buttonWithType:UIButtonTypeSystem];
    [b2 setFrame:CGRectMake(30, 100, 80, 30)];
    [b2 setTitle:@"开始上传" forState:UIControlStateNormal];
    [b2 addTarget:self action:@selector(testPost:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b2];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"123");
}

-(void)testGet:(UIButton*)b
{
    /**
     *  Request操作管理器单例得使用
     */
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    //设置返回值类型,默认类型为Json
    manager.responseSerializer= [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    /**
     *  开始请求数据,
     *  GET,请求URL
     *  parameters,请求参数
     *
     *  返回值, AFHTTPRequestOperation,请求操作对象
     */
    AFHTTPRequestOperation * o1 = [manager GET:@"https://api.weibo.com/2/statuses/public_timeline.json" parameters:@{@"access_token":@"2.00evHF2Cm9O2FC6cabf489d8zODP6E",@"count":@200} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    //设置请求出错时的警告框
    [UIAlertView showAlertViewForRequestOperationWithErrorOnCompletion:o1
                                                              delegate:self];
    //为o1操作单独设置状态栏中的小菊花
    //    [[[UIActivityIndicatorView alloc]init]setAnimatingWithStateOfOperation:o1];
    /**
     *  为所有AFNetWorking发送的请求设置小菊花.
     */
    [[AFNetworkActivityIndicatorManager sharedManager]setEnabled:YES];
    [o1 setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //bytesRead,上次读取的数据
        //totalBytesRead,目前为止总共读取的数据
        //totalBytesExpectedToRead,预测的文件大小
    }];
    /**
     *  设置下载进度条
     */
    UIProgressView * progressV1 = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
    [progressV1 setFrame:CGRectMake(0, 80, 320, 30)];
    [self.view addSubview:progressV1];
    //将o1操作的进度交由progressV展示
    [progressV1 setProgressWithDownloadProgressOfOperation:o1 animated:YES];
    
    

}

-(void)testPost:(UIButton*)b
{
    /**
     *  文件上传示例
     */
    //设置接收响应类型为标准HTTP类型(默认为响应类型为JSON)
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFHTTPRequestOperation  * o2= [manager
                                   POST:@"http://127.0.0.1/edu4child/1/upload/upload"
                                   parameters:@{@"user_id":@"1",@"user_password":@"123"}
                                   constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                   {
                                       //开始拼接表单
                                       //获取图片的二进制形式
                                       NSData * data= UIImagePNGRepresentation([UIImage imageNamed:@"icon.png"]);
                                       //将得到的二进制图片拼接到表单中
                                       /**
                                        *  data,指定上传的二进制流
                                        *  name,服务器端所需参数名
                                        *  fileName,指定文件名
                                        *  mimeType,指定文件格式
                                        */
                                       [formData appendPartWithFileData:data name:@"avatar" fileName:@"111icon.png" mimeType:@"image/png"];
                                       [formData appendPartWithFileData:data name:@"aaa" fileName:@"111icon.png" mimeType:@"image/png"];
                                       //多用途互联网邮件扩展（MIME，Multipurpose Internet Mail Extensions）
                                   }
                                   success:^(AFHTTPRequestOperation *operation, id responseObject)
                                   {
//                                       NSLog(@"%@",responseObject);
//                                       NSLog(@"%@",[[responseObject objectForKey:@"error"] objectForKey:@"error_message"]);
                                       NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
                                   }
                                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                       NSLog(@"%@",error);
                                   }];
    //设置上传操作的进度
    [o2 setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
    }];
    UIProgressView * progressV2 = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    [progressV2 setProgressWithUploadProgressOfOperation:o2 animated:YES];
    [progressV2 setFrame:CGRectMake(0, 130, 320, 30)];
    [self.view addSubview:progressV2];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
