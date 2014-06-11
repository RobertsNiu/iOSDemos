//
//  XMPPManager.h
//  WeTalk
//
//  Created by Ronan on 14-1-13.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XMPPFramework/XMPPFramework.h>
#import <DDLog.h>
#import <DDTTYLogger.h>
#import <DDFileLogger.h>
#import <XMPPFramework/xmppmessagearchiving.h>
#import <XMPPFramework/xmppmessagearchivingcoredatastorage.h>
@protocol XMPPManagerDelegate
@optional


@end


@interface XMPPManager : NSObject
@property(nonatomic,strong)GCDMulticastDelegate<XMPPManagerDelegate> *multicastDelegate;

@property(nonatomic,strong)XMPPStream *xmppStream;


@property(nonatomic,strong)XMPPReconnect *xmppReconnet;
@property(nonatomic,strong)XMPPAutoTime *xmppAutoTime;
@property(nonatomic,strong)XMPPTime *xmppTime;

@property(nonatomic,strong)XMPPRoster *xmppRoster;
@property(nonatomic,strong)XMPPRosterCoreDataStorage *xmppRosterCoreDataStorage;

@property(nonatomic,strong)XMPPvCardTempModule *xmppvCardTemp;
@property(nonatomic,strong)XMPPvCardAvatarModule *xmppvCardAvatar;
@property(nonatomic,strong)XMPPvCardCoreDataStorage *xmppvCardCoreDataStorage;

@property(nonatomic,strong)XMPPMessageArchiving * xmppMessageArchiving;
@property(nonatomic,strong)XMPPMessageArchivingCoreDataStorage * xmppMessageArchivingCoreDataStorage;

+(XMPPManager*)shareInstance;
-(void)setupStream;
-(void)teardownStream;

- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (void)removeDelegate:(id)delegate;
@end
