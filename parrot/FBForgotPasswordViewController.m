//
//  FBForgotPasswordViewController.m
//  parrot
//
//  Created by xiaoyi on 15/11/16.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBForgotPasswordViewController.h"
#import "FBResetPasswordViewController.h"

@interface FBForgotPasswordViewController ()

@end

@implementation FBForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitSendEvent:(id)sender {
    NSString *phone = _phoneField.text;
    
    // todo 发送短信
    
    // 调整到下一页
    FBResetPasswordViewController *resetViewController = [[FBResetPasswordViewController alloc] initWithNibName:@"ResetPasswordViewController" bundle:nil];
    resetViewController.title = @"设置新密码";
    
    resetViewController.phone = phone;
    
    [self.navigationController pushViewController:resetViewController animated:YES];
}

@end
