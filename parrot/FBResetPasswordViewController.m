//
//  FBResetPasswordViewController.m
//  parrot
//
//  Created by xiaoyi on 15/11/16.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBResetPasswordViewController.h"

@interface FBResetPasswordViewController ()

@end

@implementation FBResetPasswordViewController


@synthesize phone = _phone;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"phone: %@", self.phone);
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

- (IBAction)resetPasswordEvent:(id)sender {
    
}

@end
