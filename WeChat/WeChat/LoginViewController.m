//
//  LoginViewController.m
//  WeTalk
//
//  Created by Ronan on 14-1-13.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginService.h"
#import "XMPPService.h"
static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doLogin:(UIBarButtonItem *)sender {
    [[LoginService shareInstance]loginWithUsername:self.usernameTF.text andPassword:self.passwordTF.text result:^(BOOL result){
        if (result) {
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            [[XMPPService shareInstance]goOnLine];
        }else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"登陆失败" message:@"用户或密码错误,请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }];
}

- (IBAction)doRegister:(UIBarButtonItem *)sender {
    [[LoginService shareInstance]registerWithUsername:self.usernameTF.text andPassword:self.passwordTF.text result:^(BOOL result) {
        if (result) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注册成功" message:@"人品好就是不一样,快去登陆吧~" delegate:nil cancelButtonTitle:@"好的~" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注册失败" message:@"额,这个用户名有点意思,换个用户名再试一次吧" delegate:nil cancelButtonTitle:@"好吧.." otherButtonTitles: nil];
            [alert show];
        }
    }];
}
@end
