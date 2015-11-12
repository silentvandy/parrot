//
//  FBMainViewController.m
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBMainViewController.h"

#import "FBConfig.h"
#import "FBHttpRequest.h"
#import "UIImageView+WebCache.h"
#import "NSDictionary+ModelParse.h"

#import "FBAdModel.h"

@interface FBMainViewController () <FBHttpRequestDelegate> {
    FBHttpRequest *_adsRequest;
    FBHttpRequest *_contentRequest;
    
    BOOL _afterRequest;
    BOOL _nibsRegistered;
    
    NSInteger _currentPage;
    NSInteger _totalPage;
}

@property (strong, nonatomic) NSMutableArray *adsItems;
@property (strong, nonatomic) NSMutableArray *contentData;

@end



@implementation FBMainViewController

@synthesize tableView = _tableView;
@synthesize adsItems = _adsItems, contentData = _contentData;

- (id)init {
    if (self = [super init]) {
        _adsRequest = [[FBHttpRequest alloc] init];
        _contentRequest = [[FBHttpRequest alloc] init];
        
        _adsItems = [[NSMutableArray alloc] init];
        _contentData = [[NSMutableArray alloc] init];
        
        _nibsRegistered = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"精选";
    
    _afterRequest = NO;
    _currentPage  = 1;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView setContentSize:CGSizeMake(self.view.frame.size.width, self.tableView.frame.size.height + 1)];
    
    [self requestForAdData];
}

// 获取轮播图信息
- (void)requestForAdData {
    _afterRequest = NO;
    [self.adsItems removeAllObjects];
    self.adsItems = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"app_index_slide", @"name",
                                   @"5", @"size", nil];
    if (!_adsRequest) {
        _adsRequest = [[FBHttpRequest alloc] init];
    }
    [_adsRequest cleanDelegatesAndCancel];
    _adsRequest.delegate = self;
    [_adsRequest getInfoWithParams:params andUrl:[NSString stringWithFormat:@"%@", kMainSlide]];
}

// 获取推荐产品列表
- (void)requestForContentOfPage:(int)page {
    
}

#pragma mark - FBHttpRequestDelegate

- (void)fbRequest:(FBHttpRequest *)fbRequest didFinishLoading:(id)result {
    
    _afterRequest = YES;
    // 判断来源请求
    if ([fbRequest.requestUrl hasSuffix:kMainSlide]) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSArray *rows = [result objectForKey:@"rows"];
            for (NSDictionary *dict in rows) {
                FBAdModel *adv = [[FBAdModel alloc] init];
                adv.adID = [dict stringValueForKey:@"_id"];
                adv.adTitle = [dict stringValueForKey:@"title"];
                adv.adSubTitle = [dict stringValueForKey:@"subtitle"];
                adv.adType = [dict intValueForKey:@"type"];
                if (adv.adType == 2) {
                    NSString *itemType = [dict stringValueForKey:@"item_type"];
                    if ([itemType isEqualToString:@"Topic"]) {
                        adv.adType = kAdTypeTopic;
                    } else {
                        adv.adType = kAdTypeProduct;
                    }
                }
                adv.adImage = [dict stringValueForKey:@"cover_url"];
                
                [_adsItems addObject:adv];
            }
        }
        
    }else if ([fbRequest.requestUrl hasPrefix:kProductList]) {
        
    }
    
    [self.tableView reloadData];
}

- (void)fbRequest:(id)fbRequest didFailLoading:(NSError *)error {
    
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _afterRequest ? [_contentData count] : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.contentData count] == 0 || indexPath.row > [self.contentData count] - 1) {
        return 0;
    }
    return kMainTabelCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return _afterRequest ? kSlideBannerHeight : 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSLog(@"Ads count: %lu", (unsigned long)[_adsItems count]);
    FBSlides *slides = [[FBSlides alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSlideBannerHeight) delegate:self imageItems:[self rebuildSlideItems:_adsItems] isAuto:YES];
    [slides scrollToIndex:0];
    return slides;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}

// 重新组装数据
- (NSMutableArray *)rebuildSlideItems:(NSMutableArray *)items {
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

- (void)slide:(FBSlides *)slide currentItem:(int)index {
    NSLog(@"%s \n scrollToIndex ===> %d", __FUNCTION__, index);
}

- (void)slide:(FBSlides *)slide didSelectItem:(FBAdModel *)item {
    NSLog(@"%s \n click===>%@", __FUNCTION__, item.adTitle);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
