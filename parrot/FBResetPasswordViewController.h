//
//  FBResetPasswordViewController.h
//  parrot
//
//  Created by xiaoyi on 15/11/16.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBResetPasswordViewController : UIViewController {

}

@property (nonatomic, copy) NSString *phone;

@property (strong, nonatomic) IBOutlet UITextField *verfyCodeField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@property (strong, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)resetPasswordEvent:(id)sender;


@end
