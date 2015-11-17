//
//  FBSignupViewController.h
//  parrot
//
//  Created by xiaoyi on 15/11/16.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBSignupViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *accountField;
@property (strong, nonatomic) IBOutlet UIButton *getCodeButton;
@property (strong, nonatomic) IBOutlet UITextField *verfyCodeField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)fetchVerfyCode:(id)sender;

- (IBAction)submitSignupEvent:(id)sender;


@end
