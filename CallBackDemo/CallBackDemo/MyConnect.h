//
//  MyConnect.h
//  CallBackDemo
//
//  Created by cora1n on 14-4-2.
//  Copyright (c) 2014年 devwu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^ReceiveResBlock)(NSURLConnection* oconnection,NSURLResponse* response);//收到响应
typedef void (^ReceiveDataBlock)(NSURLConnection* oconnection ,NSData* data);//收到数据
typedef void (^ReceiveErrorBlock)(NSURLConnection* oconnection,NSError* err);//收到错误

typedef void (^ConnFinishLoading)(NSURLConnection* oconnection);//连接结束

@interface MyConnect : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    //声明实例变量
    ReceiveResBlock _receiveResBlock;
    ReceiveDataBlock _receiveDatablock;
    ReceiveErrorBlock _receiveErrorblock;
    ConnFinishLoading _connFinishLoadingblock;
}
//便利构造器  , Factory 工厂方法
+(MyConnect*)myConnWithReceiveRes:(ReceiveResBlock)receiveResBlock
                      ReceiveData:(ReceiveDataBlock)receiveDatablock
                     ReceiveError:(ReceiveErrorBlock)receiveErrorblock
                ConnFinishLoading:(ConnFinishLoading)connFinishLoadingblock;
//自定义init方法
-(id)initWithReceiveRes:(ReceiveResBlock)receiveResBlock
            ReceiveData:(ReceiveDataBlock)receiveDatablock
            ReceiveError:(ReceiveErrorBlock)receiveErrorblock
            ConnFinishLoading:(ConnFinishLoading)connFinishLoadingblock;


-(id)initWithReceiveRes:(ReceiveResBlock)receiveResBlock ReceiveData:(ReceiveDataBlock)receiveDatablock  ConnFinishLoading:(ConnFinishLoading)connFinishLoadingblock;

//通过传入的url发送异步请求
-(void)sendRequestWithURL:(NSURL*)url;

@end
