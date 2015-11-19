//
//  FBProductCell.m
//  parrot
//
//  Created by xiaoyi on 15/11/17.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBProductCell.h"

#import "FBLineLabel.h"
#import "FBProductModel.h"
#import "UIImageView+WebCache.h"

@interface FBProductCell()

@property (weak, nonatomic) IBOutlet UIImageView *productCover;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *userPriceLabel;

@property (weak, nonatomic) IBOutlet FBLineLabel *salePriceLabel;

@end

@implementation FBProductCell

- (void)showCellWithModel:(FBProductModel *)model {
    [self.productCover sd_setImageWithURL:[NSURL URLWithString:model.coverImage] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.titleLabel.text     = model.title;
    self.userPriceLabel.text = model.userPrice;
    self.salePriceLabel.text = model.salePrice;
}

@end
