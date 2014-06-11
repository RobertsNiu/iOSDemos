//
//  LoginViewController.h
//  WeTalk
//
//  Created by Ronan on 14-1-13.
//  Copyright (c) 2014年 iBokan. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
- (IBAction)doLogin:(UIBarButtonItem *)sender;
- (IBAction)doRegister:(UIBarButtonItem *)sender;

@end
