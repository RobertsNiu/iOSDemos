//
//  MyView1.m
//  CallBackDemo
//
//  Created by cora1n on 14-4-2.
//  Copyright (c) 2014年 devwu.com. All rights reserved.
//

#import "MyView1.h"

@implementation MyView1

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //开启用户交互
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"123");
    //如果delegate属性被赋值,且delegate遵循协议并且响应协议中的方法,
    //则调用delegate中的viewDidClicked方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewDidClicked:)]) {
        [self.delegate viewDidClicked:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
