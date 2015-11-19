//
//  FBProductDetailViewController.h
//  parrot
//
//  Created by xiaoyi on 15/11/19.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBProductModel;

@interface FBProductDetailViewController : UIViewController

@property (nonatomic, strong) FBProductModel *selectedProduct;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *salePriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;


@end
