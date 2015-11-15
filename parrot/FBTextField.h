//
//  FBTextField.h
//  parrot
//
//  Created by xiaoyi on 15/11/13.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBTextField : UITextField

@property (assign, nonatomic) CGPoint placeholderOffset;
@property (assign, nonatomic) CGPoint textOffset;
@property (assign, nonatomic) CGRect  leftViewRect;
@property (assign, nonatomic) CGRect  textRect;

@end
