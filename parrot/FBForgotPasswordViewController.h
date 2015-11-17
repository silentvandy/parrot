//
//  FBForgotPasswordViewController.h
//  parrot
//
//  Created by xiaoyi on 15/11/16.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBForgotPasswordViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *phoneField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)submitSendEvent:(id)sender;


@end
