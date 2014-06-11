//
//  XMPPManager.m
//  WeTalk
//
//  Created by Ronan on 14-1-13.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import "XMPPManager.h"
static const int ddLogLevel = LOG_LEVEL_OFF;
@implementation XMPPManager
static XMPPManager * shareManager = nil;
+(XMPPManager*)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[XMPPManager alloc]init];
    });
    return shareManager;
}
-(id)init
{
    if (self=[super init]) {
        [self setupDDLog];
        /**
         *  初始化
         */
        self.multicastDelegate = (GCDMulticastDelegate<XMPPManagerDelegate>*)[[GCDMulticastDelegate alloc]init];
        
        
        self.xmppStream = [[XMPPStream alloc]init];
        //设置服务器IP,PCH文件中设置JID [node]@hostname[/resource]
        [self.xmppStream setHostName:@"124.202.147.14"];

        self.xmppAutoTime = [[XMPPAutoTime alloc]init];
        self.xmppTime = [[XMPPTime alloc]init];
        self.xmppReconnet = [[XMPPReconnect alloc]init];
        
        self.xmppRosterCoreDataStorage = [XMPPRosterCoreDataStorage sharedInstance];
        self.xmppRoster = [[XMPPRoster alloc]initWithRosterStorage:self.xmppRosterCoreDataStorage];
        
        self.xmppvCardCoreDataStorage = [XMPPvCardCoreDataStorage sharedInstance];
        self.xmppvCardTemp = [[XMPPvCardTempModule alloc]initWithvCardStorage:self.xmppvCardCoreDataStorage];
        self.xmppvCardAvatar = [[XMPPvCardAvatarModule alloc]initWithvCardTempModule:self.xmppvCardTemp];
        
        
        self.xmppMessageArchivingCoreDataStorage = [XMPPMessageArchivingCoreDataStorage sharedInstance];
        self.xmppMessageArchiving = [[XMPPMessageArchiving alloc]initWithMessageArchivingStorage:self.xmppMessageArchivingCoreDataStorage];
        
        [self setupStream];
        
    }
    return self;
}
-(void)setupDDLog
{
    [[DDTTYLogger sharedInstance]setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance]setForegroundColor:[UIColor redColor] backgroundColor:nil forFlag:LOG_FLAG_ERROR];
    [[DDTTYLogger sharedInstance]setForegroundColor:[UIColor yellowColor] backgroundColor:nil forFlag:LOG_FLAG_WARN];
    [[DDTTYLogger sharedInstance]setForegroundColor:[UIColor cyanColor] backgroundColor:nil forFlag:LOG_FLAG_INFO];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc]init];
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [DDLog addLogger:fileLogger];
}
-(void)setupStream
{
    DDLogVerbose(@"%@::%@",THIS_FILE,THIS_METHOD);
    /**
     *  激活服务
     */
    [self.xmppTime activate:self.xmppStream];
    [self.xmppAutoTime activate:self.xmppStream];
    [self.xmppReconnet activate:self.xmppStream];
    [self.xmppRoster activate:self.xmppStream];
    [self.xmppvCardTemp activate:self.xmppStream];
    
    [self.xmppMessageArchiving activate:self.xmppStream];
    //TODO: 头像等待实现
//    [self.xmppvCardAvatar activate:self.xmppStream];
    
}

-(void)teardownStream
{
    DDLogVerbose(@"%@::%@",THIS_FILE,THIS_METHOD);
    /**
     *  与初始化反序
     */

    [self.xmppvCardAvatar deactivate];
    [self.xmppvCardTemp deactivate];
    [self.xmppRoster deactivate];
    [self.xmppAutoTime deactivate];
    [self.xmppTime deactivate];
}
/**
 *  多路代理相关函数
 *
 *  @param delegate      代理对象
 *  @param delegateQueue 代理队列
 */
-(void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    DDLogVerbose(@"%@::%@",THIS_FILE,THIS_METHOD);
    [self.multicastDelegate addDelegate:delegate delegateQueue:delegateQueue];
}
-(void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    DDLogVerbose(@"%@::%@",THIS_FILE,THIS_METHOD);
    [self.multicastDelegate removeDelegate:delegate delegateQueue:delegateQueue];
}
-(void)removeDelegate:(id)delegate
{
    DDLogVerbose(@"%@::%@",THIS_FILE,THIS_METHOD);
    [self.multicastDelegate removeDelegate:delegate];
}


@end
