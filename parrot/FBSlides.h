//
//  FBSlides.h
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBAdModel.h"

@class FBSlides;

@protocol FBSlidesDelegate <NSObject>

@optional
- (void)slide:(FBSlides *)slide didSelectItem:(FBAdModel *)item;
- (void)slide:(FBSlides *)slide currentItem:(int)index;

@end


@interface FBSlides : UIView <UIGestureRecognizerDelegate, UIScrollViewDelegate> {
    BOOL _isAutoPlay;
}

- (id)initWithFrame:(CGRect)frame delegate:(id<FBSlidesDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto;

- (id)initWithFrame:(CGRect)frame delegate:(id<FBSlidesDelegate>)delegate imageItems:(NSArray *)items;

- (void)scrollToIndex:(int)index;

@property (nonatomic, assign) id <FBSlidesDelegate> delegate;

@end
