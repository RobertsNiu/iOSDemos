//
//  MessageService.h
//  WeTalk
//
//  Created by Ronan on 14-1-14.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPService.h"

@interface MessageService : NSObject
@property(strong,nonatomic)NSMutableArray * messages;
@end
