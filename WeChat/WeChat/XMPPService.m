//
//  XMPPService.m
//  WeChat
//
//  Created by Ronan on 14-2-12.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import "XMPPService.h"
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
@interface XMPPService(){
    XMPPStream *_xmppStream;
    XMPPReconnect *_xmppReconnect;
    XMPPRoster *_xmppRoster;
    XMPPRosterCoreDataStorage *_xmppRosterCDS;
    
    MessageSended _messageSended;
    IQSended _iqSended;
    PresenceSended _presenceSended;
    
    MessageReceived _messageReceived;
    IQReceived _iqReceived;
    PresenceReceived _presenceReceived;
    
    SubscribeReceived _subscribeReceived;
}
@end

@implementation XMPPService

#pragma -mark 生命周期
static XMPPService * shareInstance;
+(instancetype)shareInstance{
    static XMPPService * shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[XMPPService alloc]init];
    });
    return shareInstance;
}
-(id)init{
    if (self=[super init]) {
        _xmppStream = [XMPPManager shareInstance].xmppStream;
        _xmppStream.autoStartTLS=YES;
        _xmppReconnect = [XMPPManager shareInstance].xmppReconnet;
        _xmppRoster = [XMPPManager shareInstance].xmppRoster;
        _xmppRosterCDS = [XMPPManager shareInstance].xmppRosterCoreDataStorage;
        
        [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
        [_xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
        [_xmppReconnect addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
}

-(void)dealloc{
    [_xmppReconnect removeDelegate:self];
    [_xmppRoster removeDelegate:self];
    [_xmppStream removeDelegate:self];
}
#pragma -mark 基本操作
-(void)goOnLine{
    [_xmppStream sendElement:[XMPPPresence presence]];
}
-(void)goOffLine{
    [_xmppStream sendElement:[XMPPPresence presenceWithType:@"unavaliable"]];
}
-(void)sendIQ:(XMPPIQ *)iq result:(IQSended)is{
    [_xmppStream sendElement:iq];
    _iqSended = is;
}
-(void)sendMessage:(XMPPMessage *)message result:(MessageSended)ms{
    [_xmppStream sendElement:message];
    _messageSended=ms;
}
-(void)sendPresence:(XMPPPresence *)presence result:(PresenceSended)ps{
    [_xmppStream sendElement:presence];
    _presenceSended = ps;
}
-(void)receivedIQ:(IQReceived)ir{
    _iqReceived = ir;
}
-(void)receivedMessage:(MessageReceived)mr{
    _messageReceived = mr;
}
-(void)receivedPresence:(PresenceReceived)pr{
    _presenceReceived = pr;
}
-(void)subscribeReceived:(SubscribeReceived)sr{
    _subscribeReceived = sr;
}

#pragma -mark Stream 出错时回调
-(void)xmppStream:(XMPPStream *)sender didReceiveError:(DDXMLElement *)error{
    DDLogVerbose(@"%@::%@ \n %@",THIS_FILE,THIS_METHOD,[error prettyXMLString]);
}
#pragma -mark Reconnect 回调
/**
 *
 *  @param connectionFlags 网络连接状态
 *  @return 是否再次连接
 */
-(BOOL)xmppReconnect:(XMPPReconnect *)sender shouldAttemptAutoReconnect:(SCNetworkConnectionFlags)connectionFlags{
    DDLogVerbose(@"%@::%@",THIS_FILE,THIS_METHOD);
    if (connectionFlags == kSCNetworkFlagsReachable) {
        return YES;
    }
    else{
        return NO;
    }
}
#pragma -mark Roster 回调
/**
 *  ...Push 收到服务器指定的set信息调用
 */
-(void)xmppRoster:(XMPPRoster *)sender didReceiveRosterPush:(XMPPIQ *)iq{
    DDLogVerbose(@"%@::%@ \n %@",THIS_FILE,THIS_METHOD,[iq prettyXMLString]);
}
/**
 *  ...Item 收到服务器返回roster信息的item时调用
 */
-(void)xmppRoster:(XMPPRoster *)sender didRecieveRosterItem:(DDXMLElement *)item{
    DDLogVerbose(@"%@::%@ \n %@",THIS_FILE,THIS_METHOD,[item prettyXMLString]);
}
/**
 *  ...Request 收到好友请求时调用
 */
-(void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence
{
    DDLogVerbose(@"%@::%@ \n %@",THIS_FILE,THIS_METHOD,[presence prettyXMLString]);
    if (!_subscribeReceived) {
        return;
    }
    _subscribeReceived(presence,sender);
}


#pragma -mark  IQ 回调
/**
 *  特殊说明
 *  @return 如果要回复该IQ，则return yes，如果不响应此iq，则return no
 */
-(BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq{
    DDLogVerbose(@"%@::%@ \n %@",THIS_FILE,THIS_METHOD,[iq prettyXMLString]);
    if (!_iqReceived) {
        return YES;
    }
    _iqReceived(iq);
    return YES;
}
-(void)xmppStream:(XMPPStream *)sender didSendIQ:(XMPPIQ *)iq{
    DDLogVerbose(@"%@::%@ \n %@",THIS_FILE,THIS_METHOD,[iq prettyXMLString]);
    if (!_iqSended) {
        return;
    }
    _iqSended(YES,nil);
}
-(void)xmppStream:(XMPPStream *)sender didFailToSendIQ:(XMPPIQ *)iq error:(NSError *)error{
    DDLogVerbose(@"%@::%@ \n %@",THIS_FILE,THIS_METHOD,[iq prettyXMLString]);
    if (!_iqSended) {
        return;
    }
    _iqSended(NO,error);
}
#pragma -mark Presence 回调
-(void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence{
    DDLogVerbose(@"%@::%@ \n %@",THIS_FILE,THIS_METHOD,[presence prettyXMLString]);
    if (!_presenceReceived) {
        return;
    }
    _presenceReceived(presence);
}
-(void)xmppStream:(XMPPStream *)sender didSendPresence:(XMPPPresence *)presence{
    DDLogVerbose(@"%@::%@ \n %@",THIS_FILE,THIS_METHOD,[presence prettyXMLString]);
    if (!_presenceSended) {
        return;
    }
    _presenceSended(YES,nil);
}
-(void)xmppStream:(XMPPStream *)sender didFailToSendPresence:(XMPPPresence *)presence error:(NSError *)error{
    DDLogVerbose(@"%@::%@ \n %@",THIS_FILE,THIS_METHOD,[presence prettyXMLString]);
    if (!_presenceSended) {
        return;
    }
    _presenceSended(NO,error);
}
#pragma -mark Message 回调
-(void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    DDLogVerbose(@"%@::%@ \n %@",THIS_FILE,THIS_METHOD,[message prettyXMLString]);
    if (!_messageReceived) {
        return;
    }
    _messageReceived(message);
}
-(void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message{
    DDLogVerbose(@"%@::%@ \n %@",THIS_FILE,THIS_METHOD,[message prettyXMLString]);
    if (!_messageSended) {
        return;
    }
    _messageSended(YES,nil);
}
-(void)xmppStream:(XMPPStream *)sender didFailToSendMessage:(XMPPMessage *)message error:(NSError *)error{
    DDLogVerbose(@"%@::%@ \n %@",THIS_FILE,THIS_METHOD,[message prettyXMLString]);
    if (!_messageSended) {
        return;
    }
    _messageSended(NO,error);
}
@end
