//
//  main.m
//  BlockDemo
//
//  Created by Ronan on 14-1-13.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  定义名为Block的block
 *
 *  @param str1 block执行时，传入的第一个值
 *  @param str2 block执行时，传入的第二个值
 *
 *  @return 无返回值 void
 */
typedef void(^Block)(NSString* str1,NSString* str2);
/**
 *  定义BlockDemo类
 */
@interface BlockDemo : NSObject
{
    /**
     *  两个实例变量
     */
    Block block1;
    Block block2;
}
/**
 *  测试方法
 *
 *  @param b1 传入的第一个block
 *  @param b2 传入的第二个block
 */
-(void)runBeforeBlock:(Block)b1 AndAfterBlock:(Block)b2;
@end
@implementation BlockDemo
-(void)runBeforeBlock:(Block)b1 AndAfterBlock:(Block)b2
{
    /**
     *  将传入的b1 和b2 赋值给实例变量
     */
    block1= b1;
    block2= b2;
    /**
     *  在循环前触发第一个block
     */
    b1(@"我是B1",@"开始循环");
    for (int i =0 ; i<5; i++) {
        NSLog(@"%d",i);
    }
    /**
     *  在循环后触发第二个block
     */
    b2(@"我是B2",@"结束循环");
}
@end
int main(int argc, const char * argv[])
{
    
    BlockDemo *bd = [[BlockDemo alloc]init];
    [bd runBeforeBlock:^(NSString *str1, NSString *str2) {
        NSLog(@"%@   %@",str1,str2);
    } AndAfterBlock:^(NSString *str1, NSString *str2) {
        NSLog(@"%@   %@",str1,str2);
    }];
    
    return 0;
}

