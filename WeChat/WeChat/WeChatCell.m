//
//  WeChatCell.m
//  WeChat
//
//  Created by Ronan on 14-2-8.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import "WeChatCell.h"
@implementation WeChatCell
-(void)awakeFromNib
{
    [self.headerPic.layer setCornerRadius:20];
    [self.headerPic.layer setMasksToBounds:YES];
    [self.headerPic.layer setBorderWidth:1];
    [self.headerPic.layer setBorderColor:[[UIColor redColor] CGColor]];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
