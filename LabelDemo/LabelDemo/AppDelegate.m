//
//  AppDelegate.m
//  LabelDemo
//
//  Created by cora1n on 14-3-25.
//  Copyright (c) 2014年 devwu.com. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSString * str =@"香格里拉等全国1400家景区门票国庆期间将优惠20%香格里拉等全国1400家景区门票国庆期间将优惠20%香格里拉等全国1400家景区门票国庆期间将优惠20%香格里拉等全国1400家景区门票国庆期间将优惠20%香格里拉测试国1400家景区门票国庆期间将优惠20%香格里拉等全国1400家景区门票国庆期间将优惠20%香格里拉测试国1400家景区门票国庆期间将优惠20%香格里拉等全国1400家景区门票国庆期间将优惠20%香格里拉测试国1400家景区门票国庆期间将优惠20%香格里拉等全国1400家景区门票国庆期间将优惠20%香格里拉测试国140家景区门票国庆期间将优惠20%香格里拉等全国1400家景区门票国庆期间将优惠20%香格里拉测试123";
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(10,200,200,20)];
    //必须设置numberOfLines
    label1.numberOfLines =0;
    [label1 setTextColor:[UIColor redColor]];
    UIFont * tfont = [UIFont systemFontOfSize:11];
    label1.font = tfont;
    label1.text = str ;
    [self.window addSubview:label1];
    
    //给一个比较大的高度，宽度不变
    CGSize size =CGSizeMake(320,1000);
    //获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    //ios7方法，获取文本需要的size，限制宽度
    CGSize  actualsize =[str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    [label1 setFrame:CGRectMake(0, 20, actualsize.width, actualsize.height)];
    
    
    UILabel * label2 = [[UILabel alloc]init];
    [label2 setFont:tfont];
//    [label2 setLineBreakMode:NSLineBreakByWordWrapping];
    label2.text=str;
    label2.numberOfLines=0;
    CGSize sss = [str sizeWithFont:tfont constrainedToSize:size];
    
    NSLog(@"%@",NSStringFromCGSize(sss));
    [label2 setFrame:CGRectMake(0, label1.frame.size.height+30, sss.width, sss.height)];
    [self.window addSubview:label2];

    

    return YES;
}
@end