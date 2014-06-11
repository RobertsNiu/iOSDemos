//
//  TableViewController.m
//  SmartCellDemo
//
//  Created by cora1n on 14-3-26.
//  Copyright (c) 2014年 devwu.com. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString * s = @"- (void)didReceiveMemoryWarning- (void)didReceiveMemoryWarning- (void)didReceiveMemoryWarning- (void)didReceiveMemoryWarning- (void)didReceiveMemoryWarning- (void)didReceiveMemoryWarning- (void)didReceiveMemoryWarning- (void)didReceiveMemoryWarning 123";
    CGRect r = [s boundingRectWithSize:CGSizeMake(300, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell.textLabel.font} context:nil];
    return r.size.height+80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString * s = @"- (void)didReceiveMemoryWarning- (void)didReceiveMemoryWarning- (void)didReceiveMemoryWarning- (void)didReceiveMemoryWarning- (void)didReceiveMemoryWarning- (void)didReceiveMemoryWarning- (void)didReceiveMemoryWarning- (void)didReceiveMemoryWarning 123";
    CGRect r = [s boundingRectWithSize:CGSizeMake(300, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell.textLabel.font} context:nil];
//    [cell.textLabel setNumberOfLines:0];
//    cell.textLabel.text=s;
//    cell.textLabel.frame=CGRectMake(0, 100, r.size.width, r.size.height);
    UILabel * la = [[UILabel alloc]initWithFrame:CGRectZero];
    la.text = s;
    la.numberOfLines=0;
    [la setFrame:CGRectMake(0, 80, r.size.width, r.size.height)];
    [cell.contentView addSubview:la];
    
    return cell;
}




@end
