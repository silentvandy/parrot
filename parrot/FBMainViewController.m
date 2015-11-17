//
//  FBMainViewController.m
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBMainViewController.h"

#import "UIImageView+WebCache.h"
#import "NSDictionary+ModelParse.h"

#import "FBConfig.h"
#import "FBAPI.h"
#import "FBAdModel.h"

#import "FBOrderListViewController.h"

#define AD_DATA    @"AD_DATA"

@interface FBMainViewController () <FBRequestDelegate> {
    BOOL _afterRequest;
    BOOL _nibsRegistered;
    
    NSInteger _currentPage;
    NSInteger _totalPage;
}

@property (strong, nonatomic) FBAPI *adsRequest;
@property (strong, nonatomic) NSMutableArray *adsItems;
@property (strong, nonatomic) NSMutableArray *contentData;

@end



@implementation FBMainViewController

@synthesize tableView = _tableView;
@synthesize adsItems = _adsItems, contentData = _contentData, adsRequest = _adsRequest;

- (id)init {
    if (self = [super init]) {
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
    
    NSLog(@"request ad data!");
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"app_index_slide", @"name",
                                   @"5", @"size", nil];
    self.adsRequest = [FBAPI getWithUrlString:kURLMainSlide requestDictionary:params delegate:self];
    self.adsRequest.flag = AD_DATA;
    NSLog(@"request start!");
    [self.adsRequest startRequest];
}

#pragma mark - FBRequestDelegate

- (void)requestSucess:(FBRequest *)request result:(id)result {
    _afterRequest = YES;
    
    if ([request.flag isEqualToString:AD_DATA]) {
        // NSLog(@"data: %@", result[@"data"][@"rows"]);
        
        FBAdModel *adv = [[FBAdModel alloc] init];
        [_adsItems addObjectsFromArray:[adv asignModelWithObject:result]];
        
        NSLog(@"轮换图 %lu",  (unsigned long)[_adsItems count] );
        
        [self.tableView reloadData];
    }
}

- (void)requestFailed:(FBRequest *)request error:(NSError *)error {
    NSLog(@"请求出错:  %@", error);
}

// 获取推荐产品列表
- (void)requestForContentOfPage:(int)page {
    
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
    FBSlides *slides = [[FBSlides alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSlideBannerHeight) delegate:self imageItems:_adsItems isAuto:YES];
    [slides scrollToIndex:0];
    return slides;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}

- (void)slide:(FBSlides *)slide currentItem:(int)index {
    //NSLog(@"%s \n scrollToIndex ===> %d", __FUNCTION__, index);
}

- (void)slide:(FBSlides *)slide didSelectItem:(FBAdModel *)item {
    //NSLog(@"%s \n click===>%@", __FUNCTION__, item.adTitle);
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
