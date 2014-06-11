//
//  MessageService.m
//  WeTalk
//
//  Created by Ronan on 14-1-14.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import "MessageService.h"
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
@implementation MessageService
-(id)init
{
    self=[super init];
    if (self) {
        [[XMPPService shareInstance] receivedMessage:^(XMPPMessage *message) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:message.fromStr message:message.body delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }];
    }
    return self;
}
@end
