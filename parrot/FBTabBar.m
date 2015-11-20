//
//  FBTabBar.m
//  parrot
//
//  Created by xiaoyi on 15/11/19.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBTabBar.h"
#import "FBConfig.h"

@interface FBTabBar() {
    UIScrollView   *_navigationTabBar;
    UIImageView    *_arrowButton;
    // 选中状态线
    UIView         *_line;
    // 全部选项
    NSMutableArray *_items;
    // 全部选项，动态宽度值
    NSArray        *_itemsWidth;
    
    BOOL           _showArrowButton;
    BOOL           _popMenu;
}

@end

#define NAV_TAB_BAR_HEIGHT  44.0f
#define ARROW_BUTTON_WIDTH  44.0f
#define ARROW_BUTTON_HEIGHT NAV_TAB_BAR_HEIGHT

@implementation FBTabBar

- (id)initWithFrame:(CGRect)frame showArrawButton:(BOOL)show {
    self = [super initWithFrame:frame];
    if (self) {
        _showArrowButton = show;
        [self initConfig];
    }
    return self;
}

#pragma mark - Private Methods

- (void)initConfig {
    _items = [[NSMutableArray alloc] init];
    _arrawImage = [UIImage imageNamed:@"arrow_down"];
    [self setupViews];
}

- (void)setupViews {
    CGFloat pbuttonX = _showArrowButton ? (SCREEN_WIDTH - ARROW_BUTTON_WIDTH) : SCREEN_WIDTH;
    
    // 添加箭头指示
    if (_showArrowButton) {
        _arrowButton = [[UIImageView alloc] initWithFrame:CGRectMake(pbuttonX, 0.0f, ARROW_BUTTON_WIDTH, ARROW_BUTTON_HEIGHT)];
        _arrowButton.userInteractionEnabled = YES;
        _arrowButton.backgroundColor = self.backgroundColor;
        _arrowButton.image = _arrawImage;
        
        [self addSubview:_arrowButton];
        
        // 添加事件行为
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bindPressedEvent)];
        [_arrowButton addGestureRecognizer:tapGestureRecognizer];
    }
    
    // 添加菜单box
    _navigationTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, pbuttonX, NAV_TAB_BAR_HEIGHT)];
    _navigationTabBar.showsHorizontalScrollIndicator = NO;
    _navigationTabBar.showsVerticalScrollIndicator   = NO;
    _navigationTabBar.alwaysBounceVertical = NO;
    
    [self addSubview:_navigationTabBar];
}

// 显示下划线
- (void)showLineWithButton:(CGFloat)width {
    _line = [[UIView alloc] initWithFrame:CGRectMake(2.0f, NAV_TAB_BAR_HEIGHT - 2.0f, width - 4.0f, 2.0f)];
    _line.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:102.0/255.0 alpha:100];
    [_navigationTabBar addSubview:_line];
}

// 根据文本数量动态获取尺寸
- (NSArray *)getButtonsWidthByTitles:(NSArray *)titles {
    NSMutableArray *allWidths = [[NSMutableArray alloc] init];
    
    UIFont *font = [UIFont fontWithName:kFontFamily size:14.0f];
    
    for (NSString *title in titles) {
        CGSize size = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
        NSNumber *width = [NSNumber numberWithFloat:size.width + 20.0f];
        [allWidths addObject:width];
    }
    return allWidths;
}

// 添加选项，返回内容总宽度
- (CGFloat)contentWidthAndAddNavItems:(NSArray *)widths {
    CGFloat buttonX = 0.0f;
    for (NSInteger index = 0; index < [_itemTitles count]; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame     = CGRectMake(buttonX, 0.0f, [widths[index] floatValue], NAV_TAB_BAR_HEIGHT);
        [button setTitle:_itemTitles[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [button addTarget:self action:@selector(bindItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [_navigationTabBar addSubview:button];
        
        [_items addObject:button];
        
        buttonX += [widths[index] floatValue];
    }
    
    // 默认选中第一个
    [self showLineWithButton:[widths[0] floatValue]];
    
    return buttonX;
}

// 获取点击对象
- (void)bindItemClicked:(UIButton *)button {
    NSInteger index = [_items indexOfObject:button];
    if ([_delegate respondsToSelector:@selector(itemDidSelectedWithIndex:)]) {
        [_delegate itemDidSelectedWithIndex:index];
    }
    // 更新状态
    [self updateCurrentIndex:index];
}


// 箭头下拉行为
- (void)bindPressedEvent {
    
}

// 更新当前选项状态
- (void)updateCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    
    //更新显示位置
    UIButton *currentButton = _items[currentIndex];
    CGFloat flag = _showArrowButton ? (SCREEN_WIDTH - ARROW_BUTTON_WIDTH) : SCREEN_WIDTH;
    
    if (currentButton.frame.origin.x + currentButton.frame.size.width > flag) {
        CGFloat offsetX = currentButton.frame.origin.x + currentButton.frame.size.width - flag;
        if (_currentIndex < [_items count] - 1) {
            offsetX = offsetX + 20.0f;
        }
        [_navigationTabBar setContentOffset:CGPointMake(offsetX, 0.0f) animated:YES];
    } else {
        // 不需要更新位置
        [_navigationTabBar setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
    }
    
    // 同步更新状态
    [UIView animateWithDuration:0.2f animations:^{
        _line.frame = CGRectMake(currentButton.frame.origin.x + 2.0f, _line.frame.origin.y, [_itemsWidth[currentIndex] floatValue] - 4.0f, _line.frame.size.height);
    }];
}

#pragma mark - Public Methods

- (void)setArrawImage:(UIImage *)arrawImage {
    _arrawImage = arrawImage ? arrawImage : _arrawImage;
    // 更新图片
    _arrowButton.image = _arrawImage;
}

// 更新选项数据
- (void)updateItemsData {
    
    _itemsWidth = [self getButtonsWidthByTitles:_itemTitles];
    if (_itemsWidth.count) {
        CGFloat contentWidth = [self contentWidthAndAddNavItems:_itemsWidth];
        _navigationTabBar.contentSize = CGSizeMake(contentWidth, NAV_TAB_BAR_HEIGHT);
    }
}

- (void)refresh {
    
}

@end
