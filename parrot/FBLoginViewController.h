//
//  FBLoginViewController.h
//  parrot
//
//  Created by xiaoyi on 15/11/13.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBTextField.h"

@interface FBLoginViewController : UIViewController 

@property (strong, nonatomic) IBOutlet UITextField *accountField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UIButton *quickSignupButton;
@property (strong, nonatomic) IBOutlet UIButton *forgotPasswordButton;

- (IBAction)forgotPasswordClick:(id)sender;
- (IBAction)quickSignupClick:(id)sender;

- (IBAction)bindFocusEvent:(id)sender;


- (IBAction)hideKeyboard:(id)sender;


@end
