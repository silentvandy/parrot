//
//  FBTabBar.h
//  parrot
//
//  Created by xiaoyi on 15/11/19.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FBTabBarDelegate <NSObject>

@optional

- (void)itemDidSelectedWithIndex:(NSInteger)index;

- (void)shouldPopNavigationMenu:(BOOL)pop height:(CGFloat)height;

@end


@interface FBTabBar : UIView

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) NSArray *itemTitles;

@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, strong) UIImage *arrawImage;

@property (nonatomic, weak) id <FBTabBarDelegate> delegate;

/**
 * 初始化方法
 */
- (id)initWithFrame:(CGRect)frame showArrawButton:(BOOL)show;


- (void)updateItemsData;

- (void)refresh;

@end
