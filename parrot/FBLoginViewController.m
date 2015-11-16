//
//  FBLoginViewController.m
//  parrot
//
//  Created by xiaoyi on 15/11/13.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBLoginViewController.h"

@interface FBLoginViewController () <UITextFieldDelegate> {
    
}

@end

@implementation FBLoginViewController

@synthesize accountField = _accountField, passwordField = _passwordField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    
    // 添加输入框事件
    _accountField.delegate = self;
    _accountField.keyboardAppearance = UIKeyboardAppearanceAlert;
    _accountField.keyboardType = UIKeyboardTypeNumberPad;
    _accountField.tag = 1101;
    
    _accountField.layer.borderWidth = .5;
    _accountField.layer.borderColor = [[UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1.0] CGColor];
    _accountField.font = [UIFont systemFontOfSize:14];
    
    [_passwordField setSecureTextEntry:YES];
    _passwordField.delegate = self;
    _passwordField.layer.borderWidth = .5;
    _passwordField.layer.borderColor = [[UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1.0] CGColor];
    _passwordField.font = [UIFont systemFontOfSize:14];
    
    _passwordField.keyboardAppearance = UIKeyboardAppearanceAlert;
    _passwordField.keyboardType = UIKeyboardTypeASCIICapable;
    _passwordField.returnKeyType = UIReturnKeySend;
    _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordField.tag = 1102;
    
    // 添加按钮事件
    _submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _submitButton.frame = CGRectMake(17, 144, 281, 32);
    _submitButton.layer.masksToBounds = YES;
    _submitButton.layer.cornerRadius  = 4.0;
    
    [_submitButton addTarget:self action:@selector(bindLoginEvent:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)bindLoginEvent:(id)sender {
    if ([self validateLoginForm] != YES) {
        return;
    }
    
}

- (IBAction)forgotPasswordClick:(id)sender {
}

- (IBAction)quickSignupClick:(id)sender {
}

- (IBAction)bindFocusEvent:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 1101) {
        [_accountField becomeFirstResponder];
    } else if (btn.tag == 1102) {
        [_passwordField becomeFirstResponder];
    } else {
        [self hideKeyboard:sender];
    }
}

// 验证登录表单
- (BOOL)validateLoginForm {
    
    return YES;
}


- (void)hideKeyboard:(id)sender {
    [self.accountField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
