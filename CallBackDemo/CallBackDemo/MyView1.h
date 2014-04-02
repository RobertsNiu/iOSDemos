//
//  MyView1.h
//  CallBackDemo
//
//  Created by cora1n on 14-4-2.
//  Copyright (c) 2014年 devwu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
//协议,      是OC中的一种语法,
//代理,委托  是一种设计模式

//实现自己的协议
@protocol MyViewDelegate <NSObject>
//必须实现的函数
@required
-(void)viewDidClicked:(UIView*)v;

@end

@interface MyView1 : UIView
//  id ===  void *
@property(nonatomic,weak) id<MyViewDelegate>  delegate;
@end
