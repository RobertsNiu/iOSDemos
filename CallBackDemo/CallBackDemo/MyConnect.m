//
//  MyConnect.m
//  CallBackDemo
//
//  Created by cora1n on 14-4-2.
//  Copyright (c) 2014年 devwu.com. All rights reserved.
//

#import "MyConnect.h"

@implementation MyConnect
-(id)initWithReceiveRes:(ReceiveResBlock)receiveResBlock
            ReceiveData:(ReceiveDataBlock)receiveDatablock
           ReceiveError:(ReceiveErrorBlock)receiveErrorblock
      ConnFinishLoading:(ConnFinishLoading)connFinishLoadingblock
{
    if (self = [super init]) {
        _receiveResBlock = receiveResBlock;
        _receiveDatablock = receiveDatablock;
        _receiveErrorblock = receiveErrorblock;
        _connFinishLoadingblock = connFinishLoadingblock;
    }
    return self;
}

-(id)initWithReceiveRes:(ReceiveResBlock)receiveResBlock ReceiveData:(ReceiveDataBlock)receiveDatablock ConnFinishLoading:(ConnFinishLoading)connFinishLoadingblock
{
    
    self = [MyConnect myConnWithReceiveRes:receiveResBlock ReceiveData:receiveDatablock ReceiveError:nil ConnFinishLoading:connFinishLoadingblock];
    return self;
}

+(MyConnect *)myConnWithReceiveRes:(ReceiveResBlock)receiveResBlock
                       ReceiveData:(ReceiveDataBlock)receiveDatablock
                      ReceiveError:(ReceiveErrorBlock)receiveErrorblock
                 ConnFinishLoading:(ConnFinishLoading)connFinishLoadingblock
{
    MyConnect * conn = [[MyConnect alloc]initWithReceiveRes:receiveResBlock
                             ReceiveData:receiveDatablock
                            ReceiveError:receiveErrorblock
                       ConnFinishLoading:connFinishLoadingblock];
    return conn;
}
-(void)sendRequestWithURL:(NSURL *)url
{
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}


//收到响应
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _receiveResBlock(connection,response);
}
//收到数据
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    _receiveDatablock(connection,data);
}
//收到错误
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_receiveErrorblock) {
        _receiveErrorblock(connection,error);
    }
}
//连接结束
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _connFinishLoadingblock(connection);
}
@end
