//
//  FBProductCell.h
//  parrot
//
//  Created by xiaoyi on 15/11/17.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBProductModel;

@interface FBProductCell : UICollectionViewCell

- (void)showCellWithModel:(FBProductModel *)model;

@end
