//
//  FBCategoryCell.m
//  parrot
//
//  Created by xiaoyi on 15/11/17.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBCategoryCell.h"

#import "FBConfig.h"
#import "FBCategoryModel.h"
#import "UIImageView+WebCache.h"

@interface FBCategoryCell()

@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation FBCategoryCell


- (void)showCellWithModel:(FBCategoryModel *)model {
    
    self.titleLabel.text = model.cateTitle;
    self.titleLabel.font = [UIFont fontWithName:kFontFamily size:18.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    [self.categoryImageView sd_setImageWithURL:[NSURL URLWithString:model.cateImage]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
