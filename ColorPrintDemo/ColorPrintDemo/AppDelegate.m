//
//  AppDelegate.m
//  ColorPrintDemo
//
//  Created by cora1n on 14-3-19.
//  Copyright (c) 2014年 cora1n. All rights reserved.
//
#define dlogVerbose(fmt, ...) \
do { \
NSString *___FILENAME___ = [[[NSString stringWithCString:__FILE__ \
encoding:NSUTF8StringEncoding] \
componentsSeparatedByString:@"/"] lastObject]; \
DDLogVerbose((@ \
"\n┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n" \
"文件:%@\n" \
"方法:%s\n" \
"行数:%d\n" \
"信息:" fmt \
"\n┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"), \
___FILENAME___, \
__FUNCTION__, \
__LINE__, \
##__VA_ARGS__); \
} while(0); \

#define dlogInfo(fmt, ...) \
do { \
NSString *___FILENAME___ = [[[NSString stringWithCString:__FILE__ \
encoding:NSUTF8StringEncoding] \
componentsSeparatedByString:@"/"] lastObject]; \
DDLogInfo((@ \
"\n┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n" \
"文件:%@\n" \
"方法:%s\n" \
"行数:%d\n" \
"信息:" fmt \
"\n┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"), \
___FILENAME___, \
__FUNCTION__, \
__LINE__, \
##__VA_ARGS__); \
} while(0); \

#define dlogError(fmt, ...) \
do { \
NSString *___FILENAME___ = [[[NSString stringWithCString:__FILE__ \
encoding:NSUTF8StringEncoding] \
componentsSeparatedByString:@"/"] lastObject]; \
DDLogError((@ \
"\n┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n" \
"文件:%@\n" \
"方法:%s\n" \
"行数:%d\n" \
"信息:" fmt \
"\n┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"), \
___FILENAME___, \
__FUNCTION__, \
__LINE__, \
##__VA_ARGS__); \
} while(0); \

#define dlogWarn(fmt, ...) \
do { \
NSString *___FILENAME___ = [[[NSString stringWithCString:__FILE__ \
encoding:NSUTF8StringEncoding] \
componentsSeparatedByString:@"/"] lastObject]; \
DDLogWarn((@ \
"\n┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n" \
"文件:%@\n" \
"方法:%s\n" \
"行数:%d\n" \
"信息:" fmt \
"\n┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"), \
___FILENAME___, \
__FUNCTION__, \
__LINE__, \
##__VA_ARGS__); \
} while(0); \

#define dlogDebug(fmt, ...) \
do { \
NSString *___FILENAME___ = [[[NSString stringWithCString:__FILE__ \
encoding:NSUTF8StringEncoding] \
componentsSeparatedByString:@"/"] lastObject]; \
DDLogDebug((@ \
"\n┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n" \
"文件:%@\n" \
"方法:%s\n" \
"行数:%d\n" \
"信息:" fmt \
"\n┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"), \
___FILENAME___, \
__FUNCTION__, \
__LINE__, \
##__VA_ARGS__); \
} while(0); \

#import "AppDelegate.h"
/**
 *  导入Lumberjack框架
 */
#import "CocoaLumberjack.h"

/**
 *  设置输出等级    Verbose>Info>Warn>Error
 */
#ifdef DEBUG
    //开发模式，在Schema中修改模式
    static const int ddLogLevel = DDLogFlagDebug;
#else
    //发布模式
    static const int ddLogLevel = DDLogFlagError;
#endif


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:ddLogLevel];     //添加Xcode控制台Logger
    [[DDTTYLogger sharedInstance]setColorsEnabled:YES];//开启Xcode控制台Logger彩色输出
    /**
     *  设置不同输出颜色
     */
    [[DDTTYLogger sharedInstance]setForegroundColor:[UIColor redColor] backgroundColor:nil forFlag:DDLogFlagError];//DDLogError颜色，默认为暗红色
    [[DDTTYLogger sharedInstance]setForegroundColor:[UIColor yellowColor] backgroundColor:nil forFlag:DDLogFlagWarning];//DDLogWarn，默认为褐色
    [[DDTTYLogger sharedInstance]setForegroundColor:[UIColor cyanColor] backgroundColor:nil forFlag:DDLogFlagInfo];//DDLogInfo,默认为白色
    [[DDTTYLogger sharedInstance]setForegroundColor:[UIColor whiteColor] backgroundColor:nil forFlag:DDLogFlagVerbose];//DDLogVerbose,默认为白色
    [[DDTTYLogger sharedInstance]setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:DDLogFlagDebug];
    /**
     *  THIS_FILE,THIS_METHOD 。 Lumberjack框架内置变量，用于表示当前的文件名和方法名
     */

//    DDLogVerbose(@"%@::%@",THIS_FILE,THIS_METHOD);
//    DDLogVerbose(@"verbose");
//    DDLogInfo(@"info");
//    DDLogWarn(@"warn");
//    DDLogError(@"error");
    
    dlogWarn(@"warn");
    dlogError(@"error");
    dlogInfo(@"info");
    dlogDebug(@"debug");
    dlogVerbose(@"verbose");
    return YES;
}
@end
