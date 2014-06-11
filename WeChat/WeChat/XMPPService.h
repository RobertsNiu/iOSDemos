//
//  XMPPService.h
//  WeChat
//
//  Created by Ronan on 14-2-12.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPManager.h"
typedef void (^MessageReceived)(XMPPMessage* message);
typedef void (^MessageSended)(BOOL success,id err);

typedef void (^PresenceReceived)(XMPPPresence* presence);
typedef void (^PresenceSended)(BOOL success,id err);

typedef void (^IQReceived)(XMPPIQ* iq);
typedef void (^IQSended)(BOOL success,id err);

typedef void (^SubscribeReceived)(XMPPPresence* presence,XMPPRoster* sender);

@interface XMPPService : NSObject<XMPPStreamDelegate,XMPPRosterDelegate,XMPPReconnectDelegate>
+(instancetype)shareInstance;

- (void)receivedIQ:(IQReceived)ir;
- (void)receivedPresence:(PresenceReceived)pr;
- (void)receivedMessage:(MessageReceived)mr;

- (void)subscribeReceived:(SubscribeReceived)sr;

- (void)sendIQ:(XMPPIQ*)iq result:(IQSended)is;
- (void)sendPresence:(XMPPPresence*)presence result:(PresenceSended)ps;
- (void)sendMessage:(XMPPMessage*)message result:(MessageSended)ms;

- (void)goOnLine;
- (void)goOffLine;
@end
