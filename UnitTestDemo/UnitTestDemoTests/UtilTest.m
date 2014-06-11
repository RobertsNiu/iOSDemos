//
//  UtilTest.m
//  UnitTestDemo
//
//  Created by Ronan on 14-1-16.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UtilDemo1.h"
@interface UtilTest : XCTestCase

@end

@implementation UtilTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPow
{
    UtilDemo1 * util1 = [[UtilDemo1 alloc]init];
    int i = 20;
    int result = [util1 pow:i];
    XCTAssertEqual(result, i*i, @"测试失败");
}

@end
