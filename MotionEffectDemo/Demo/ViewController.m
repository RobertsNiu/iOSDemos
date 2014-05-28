//
//  ViewController.m
//  Demo
//
//  Created by cora1n on 14-5-28.
//  Copyright (c) 2014年 devwu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
    UIInterpolatingMotionEffect * ex = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis ];
    UIInterpolatingMotionEffect * ey = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    [ex setMaximumRelativeValue:@30];
    [ey setMaximumRelativeValue:@30];
    [ex setMinimumRelativeValue:@-30];
    [ey setMinimumRelativeValue:@-30];
    
    UIInterpolatingMotionEffect * layerEx = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"layer.shadowOffset" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    [layerEx setMaximumRelativeValue:[NSValue valueWithCGSize:CGSizeMake(-10, 5)]];
    [layerEx setMinimumRelativeValue:[NSValue valueWithCGSize:CGSizeMake(10, 5)]];

    
    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    [v addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
    [v.layer setShadowColor:[UIColor blackColor].CGColor];
    [v.layer setShadowOpacity:0.6];
    [v setCenter:CGPointMake(160, 200)];
    [v setBackgroundColor:[UIColor redColor]];
    [v setMotionEffects:@[ex,ey,layerEx]];
    [self.view addSubview:v];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath  isEqual: @"center"]) {
        NSLog(@"%@",change);
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
