//
//  RootViewController.m
//  RACDemo
//
//  Created by Ronan on 14-1-11.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import "RootViewController.h"
#import <ReactiveCocoa.h>
@interface RootViewController ()
@property(nonatomic,strong)NSString *str;
@end

@implementation RootViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
   
//    RACSignal *s2= @[@"1",@"2",@"3"].rac_sequence.signal;
//    RACSignal *s3= @{@"key1":@"value1",@"key2": @"value2"}.rac_valueSequence.signal;
//    [s2 subscribeNext:^(id x) {
//        NSLog(@"%@   :: %f",x,[NSDate timeIntervalSinceReferenceDate]);
//    }];
//    [s3 subscribeNext:^(id x) {
//        NSLog(@"%@   :: %f",x,[NSDate timeIntervalSinceReferenceDate]);
//    }];
    
    __block unsigned subscriptions = 0;
    
    RACSignal *loggingSignal = [RACSignal createSignal:^ RACDisposable * (id<RACSubscriber> subscriber) {
        for (int i=0; i<100; i++) {
            [subscriber sendNext:[NSNumber numberWithInt:i]];
        }
        [subscriber sendCompleted];
        subscriptions++;
        return nil;
    }];
    // Outputs:
    // subscription 1
    
    [loggingSignal switchToLatest];
    
    
    [loggingSignal subscribeNext:^(id x) {
        NSLog(@"next  : %@",x);
    }];
    
    // Outputs:
    // subscription 2
    [loggingSignal subscribeCompleted:^{
        NSLog(@"subscription %u", subscriptions);
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
