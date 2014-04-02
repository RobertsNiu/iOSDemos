//
//  MyView2.m
//  CallBackDemo
//
//  Created by cora1n on 14-4-2.
//  Copyright (c) 2014年 devwu.com. All rights reserved.
//

#import "MyView2.h"
//
//void show(id a)
//{
//    
//}

@interface MyView2()
{
    ViewDidClickedBlock _block;
}
@end

@implementation MyView2

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"123");
    //如果self.block被赋值,则调用该block种的代码
//    if (self.block) {
//        //带括号的,就是调用
//        self.block(self);
//        //NextStep
//        //GUNStep
//    }
    if (_block) {
        _block(self);
    }
}

-(void)setBlock:(ViewDidClickedBlock)block
{
    //block 属于self,self.block被self管理
    //self 属于block,self被block管理
//    _block = ^(MyView2* mv){
//        self;
//    };
    _block = block;
}

@end
