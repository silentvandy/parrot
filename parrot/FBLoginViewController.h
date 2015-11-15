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

@property (nonatomic, weak) IBOutlet FBTextField *accountField;
@property (nonatomic, weak) IBOutlet FBTextField *passwordField;

@property (nonatomic, weak) IBOutlet UIButton    *submitButton;

@property (nonatomic, weak) IBOutlet UIButton    *quickSignup;
@property (nonatomic, weak) IBOutlet UIButton    *forgetPassword;

- (IBAction)forgotPassword:(id)sender;
- (IBAction)bindFocusEvent:(id)sender;
- (IBAction)bindSignupEvent:(id)sender;


- (IBAction)hideKeyboard:(id)sender;

@end
