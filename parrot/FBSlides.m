//
//  FBSlides.m
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBSlides.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FBConfig.h"

// switch interval time
static CGFloat FOCUS_INTERVAL = 5.0;

@interface FBSlides () {
    UIScrollView  *_scrollView;
    UIPageControl *_pageControl;
    NSArray *_slideItems;
    float _pageCount;
}

@property (nonatomic, strong) NSArray *slideItems;

- (void)setupViews;
- (void)switchFocusItem;

@end

@implementation FBSlides

@synthesize delegate = _delegate, slideItems = _slideItems;

- (id)initWithFrame:(CGRect)frame delegate:(id<FBSlidesDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto {
    self = [super initWithFrame:frame];
    if (self) {
        _slideItems = [self rebuildSlideItems:items];
        _isAutoPlay = isAuto;
        
        _pageCount  = [_slideItems count];
        
        self.delegate = delegate;
        
        [self setupViews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame delegate:(id<FBSlidesDelegate>)delegate imageItems:(NSArray *)items {
    return [self initWithFrame:frame delegate:delegate imageItems:items isAuto:YES];
}

- (void)scrollToIndex:(int)index {
    if ([_slideItems count] > 1) {
        if (index >= ([_slideItems count] - 2) ) {
            index = (int)_slideItems.count - 3;
        }
        
        [self moveToTargetPosition:kItemWidth*(index+1)];
    } else {
        [self moveToTargetPosition:0];
    }
    [self scrollViewDidScroll:_scrollView];
}

#pragma mark - private methods

- (void)setupViews {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.scrollsToTop = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    float space = 0;
    CGSize size = CGSizeMake(320, 0);
    
    float pageControlWidth  = (_pageCount - 2) * 10.0f;
    NSLog(@"page width: %f", (_scrollView.frame.size.width - pageControlWidth)/2);
    float pageControlHeight = 8.0f;
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _scrollView.frame.size.height - pageControlHeight - 10.0f, pageControlWidth, pageControlHeight)];
    _pageControl.userInteractionEnabled = NO;
    
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
    
    _pageControl.numberOfPages = _slideItems.count > 1 ? _slideItems.count - 2 : _slideItems.count;
    _pageControl.currentPage = 0;
    
    // 添加手势（单击事件）
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    
    [_scrollView addGestureRecognizer:tapGestureRecognize];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*_slideItems.count, _scrollView.frame.size.height);
    
    for (int i=0; i < _slideItems.count; i++) {
        NSLog(@"Slide index: %d", i);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * _scrollView.frame.size.width+space, space, _scrollView.frame.size.width - space*2, _scrollView.frame.size.height - 2*space - size.height)];
        
        FBAdModel *adv = (FBAdModel *)[_slideItems objectAtIndex:i];
        NSString *imgUrl = adv.adImage;
        // 加载网络图片
        if ([imgUrl hasPrefix:@"http://"]) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"placeholder" ]];
        }
        
        [_scrollView addSubview:imageView];
    }
    
    if ([_slideItems count] > 1) {
        [_scrollView setContentOffset:CGPointMake(kItemWidth, 0) animated:NO];
        // 设置自动播放
        if (_isAutoPlay) {
            [self performSelector:@selector(switchFocusItem) withObject:nil afterDelay:FOCUS_INTERVAL];
        }
    }
}

// 自动播放切换
- (void)switchFocusItem {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusItem) object:nil];
    
    CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
    targetX = (int)(targetX/kItemWidth) * kItemWidth;
    
    [self moveToTargetPosition:targetX];
    
    if ([_slideItems count] > 1 && _isAutoPlay) {
        [self performSelector:@selector(switchFocusItem) withObject:nil afterDelay:FOCUS_INTERVAL];
    }
}

// 移动位置
- (void)moveToTargetPosition:(CGFloat)targetX {
    NSLog(@"drag x: %f", targetX);
    [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:YES];
}

// 响应点击事件
- (void)singleTapGestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer {
    int page = (int)(_scrollView.contentOffset.x / _scrollView.frame.size.width);
    if (page > 1 && page < _slideItems.count) {
        FBAdModel *item = (FBAdModel *)[_slideItems objectAtIndex:page];
        if ([self.delegate respondsToSelector:@selector(slide:didSelectItem:)]) {
            [self.delegate slide:self didSelectItem:item];
        }
    }
}

#pragma mark - UIScrollViewDelegate

// scrollView滚动时，就调用该方法。任何offset值改变都调用该方法。即滚动过程中，调用多次
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float targetX = scrollView.contentOffset.x;
    if ([_slideItems count] >= 3) {
        if (targetX >= kItemWidth * ([_slideItems count] - 1)) {
            targetX = kItemWidth;
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        } else if (targetX <= 0) {
            targetX = kItemWidth * ([_slideItems count] - 2);
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
    }
    int page = (_scrollView.contentOffset.x + kItemWidth/2.0) / kItemWidth;
    if ([_slideItems count] > 1) {
        page --;
        if (page >= _pageControl.numberOfPages ) {
            page = 0;
        } else if (page < 0) {
            page = (int)_pageControl.numberOfPages - 1;
        }
    }
    if (page != _pageControl.currentPage) {
        if ([self.delegate respondsToSelector:@selector(slide:currentItem:)]) {
            [self.delegate slide:self currentItem:page];
        }
    }
    _pageControl.currentPage = page;
}

// 滑动视图，当手指离开屏幕那一霎那，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
        targetX = (int)(targetX/kItemWidth) * kItemWidth;
        NSLog(@"drag x: %f", targetX);
        [self moveToTargetPosition:targetX];
    }
}

#pragma mark - Private Methods

// 重新组装数据
- (NSArray *)rebuildSlideItems:(NSArray *)items {
    NSMutableArray *rebuildItems = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSInteger length = items.count;
    if ([items count] > 1) {
        [rebuildItems addObject:[items objectAtIndex:length - 1]];
    }
    for (int i = 0; i < length; i++) {
        [rebuildItems addObject:[items objectAtIndex:i]];
    }
    if ([items count] > 1) {
        [rebuildItems addObject:[items objectAtIndex:0]];
    }
    
    return rebuildItems;
}

@end
