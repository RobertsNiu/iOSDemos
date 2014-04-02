//
//  MyView2.h
//  CallBackDemo
//
//  Created by cora1n on 14-4-2.
//  Copyright (c) 2014年 devwu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyView2;
//创建一个自定义类型
typedef void (^ViewDidClickedBlock)(MyView2* v);

@interface MyView2 : UIView

//@property(nonatomic,strong)ViewDidClickedBlock block;
-(void)setBlock:(ViewDidClickedBlock)block;
@end
