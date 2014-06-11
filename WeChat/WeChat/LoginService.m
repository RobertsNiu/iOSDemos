//
//  LoginService.m
//  WeTalk
//
//  Created by Ronan on 14-1-13.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import "LoginService.h"
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
typedef enum {
    kServiceTypeLogin,
    kServiceTypeRegist
}ServiceType;
@interface LoginService()
{
    LoginResult _loginResult;
    RegistResult _registResult;
    ServiceType _serviceType;
    
    XMPPJID *_myJid;
    NSString *_password;
}
@end
@implementation LoginService
static LoginService *shareInstance = nil;
+(LoginService*)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[LoginService alloc]init];
    });
    return shareInstance;
}
-(id)init
{
    DDLogInfo(@"%@::%@",THIS_FILE,THIS_METHOD);
    if (self=[super init]) {
        [[XMPPManager shareInstance].xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
}
-(void)dealloc
{
    DDLogInfo(@"%@::%@",THIS_FILE,THIS_METHOD);
    [[XMPPManager shareInstance].xmppStream removeDelegate:self];
}

-(void)loginWithUsername:(NSString *)username andPassword:(NSString *)password result:(LoginResult)result
{
    DDLogInfo(@"%@::%@",THIS_FILE,THIS_METHOD);
    _serviceType = kServiceTypeLogin;
    _myJid=[XMPPJID jidWithString:[NSString stringWithFormat:@"%@%@",username,HOST_NAME]];
    _password=password;
    _loginResult=result;
    
    XMPPStream* xmppStream = [XMPPManager shareInstance].xmppStream;
    xmppStream.myJID = _myJid;
    if (![xmppStream isConnected]) {
        [xmppStream connectWithTimeout:10 error:nil];
    }
    else
    {
        [xmppStream authenticateWithPassword:password error:nil];
    }
}
-(void)registerWithUsername:(NSString *)username andPassword:(NSString *)password result:(RegistResult)result
{
    DDLogInfo(@"%@::%@",THIS_FILE,THIS_METHOD);
    _serviceType = kServiceTypeRegist;
    _myJid=[XMPPJID jidWithString:[NSString stringWithFormat:@"%@%@",username,HOST_NAME]];
    _password=password;
    _registResult = result;
    
    XMPPStream *xmppStream = [XMPPManager shareInstance].xmppStream;
    xmppStream.myJID = _myJid;
    if (![xmppStream isConnected]) {
        [xmppStream connectWithTimeout:10 error:nil];
    }
    else
    {
        [xmppStream registerWithPassword:_password error:nil];
    }
    
}


-(void)xmppStreamDidConnect:(XMPPStream *)sender
{
    DDLogInfo(@"%@::%@",THIS_FILE,THIS_METHOD);
    if (_serviceType == kServiceTypeLogin) {
        [sender authenticateWithPassword:_password error:nil];
    }
    if (_serviceType == kServiceTypeRegist) {
        [sender registerWithPassword:_password error:nil];
    }
}
/**
 *  当服务器要求加密连接时，该方法才会被调用
 *
 *  @param settings 加密设置字典，详细查看以下资料
 *  https://github.com/robbiehanson/XMPPFramework/wiki/Security
 */
-(void)xmppStream:(XMPPStream *)sender willSecureWithSettings:(NSMutableDictionary *)settings
{
    DDLogInfo(@"%@::%@",THIS_FILE,THIS_METHOD);
    [settings setObject:@YES forKey:(NSString *)kCFStreamSSLAllowsAnyRoot];
    DDLogVerbose(@"%@",settings);
}
-(void)xmppStreamDidSecure:(XMPPStream *)sender
{
    DDLogInfo(@"%@::%@",THIS_FILE,THIS_METHOD);
}
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    DDLogInfo(@"%@::%@",THIS_FILE,THIS_METHOD);
    _loginResult(YES);
}
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    DDLogInfo(@"%@::%@",THIS_FILE,THIS_METHOD);
    _loginResult(NO);
}


-(void)xmppStreamDidRegister:(XMPPStream *)sender
{
    DDLogInfo(@"%@::%@",THIS_FILE,THIS_METHOD);
    _registResult(YES);
}
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    DDLogInfo(@"%@::%@",THIS_FILE,THIS_METHOD);
    _registResult(NO);
}
@end
