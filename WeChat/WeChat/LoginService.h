//
//  LoginService.h
//  WeTalk
//
//  Created by Ronan on 14-1-13.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPManager.h"
typedef void(^LoginResult)(BOOL result);
typedef void(^RegistResult)(BOOL result);

@interface LoginService : NSObject<XMPPStreamDelegate>
+(LoginService*)shareInstance;
-(void)loginWithUsername:(NSString*)username andPassword:(NSString*)password result:(LoginResult)result;
-(void)registerWithUsername:(NSString*)username andPassword:(NSString*)password result:(RegistResult)result;
@end
