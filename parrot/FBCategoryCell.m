//
//  FBCategoryCell.m
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBCategoryCell.h"

@implementation FBCategoryCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // 初始化时加载FrbirdCollectionCell.xib文件
        NSArray *aryOfViews = [[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:self options:nil];
        
        // 如果路径不存在， 返回nil
        if (aryOfViews.count < 1) {
            return nil;
        }
        
        // xib中view不属于UICollectionViewCell类，返回nil
        if (![[aryOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        // 加载nib
        self = [aryOfViews objectAtIndex:0];
    }
    
    return self;
}

@end
