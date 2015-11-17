//
//  FBCategoryViewController.m
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBCategoryViewController.h"

#import "FBAPI.h"
#import "FBConfig.h"
#import "FBRequest.h"
#import "FBCategoryCell.h"
#import "FBCategoryModel.h"

#import "MJRefresh.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FBCategoryViewController ()<UITableViewDataSource, UITableViewDelegate, FBRequestDelegate> {
    FBAPI *_categoryReqeust;
    
    NSMutableArray *_dataSource;
}

@property (assign, nonatomic) int page;

@end

#define kCategoryData   @"fetch_category_data"

@implementation FBCategoryViewController

static NSString * const reuseIdentifier = @"CategoryCell";

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"好货";
    
    // 初始化
    _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    _page = 1;
    
    // 设置tableView始终上下滑动
    self.tableView.alwaysBounceVertical = YES;
    
    // 注册优化
    [self.tableView registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    
    // 删除table分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self initRequest];
        [self.tableView.mj_header endRefreshing];
    }];
    
    // 上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    // 初始化数据
    [self initRequest];
}

// 初始请求
- (void)initRequest {
    _page = 1;
    
    // 初始化时需清空dataSource,避免下拉/上拉交叉获取
    [_dataSource removeAllObjects];
    _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    
    // 注意：初始化数据源后，务必同步刷新tableview
    [self.tableView reloadData];
    
    [self request];
}

// 加载更多数据
- (void)loadMoreData {
    _page++;
    [self request];
}

// 发送网络请求
- (void)request {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"page"] = @(_page);
    params[@"size"] = @5;
    
    // 发送请求
    _categoryReqeust = [FBAPI getWithUrlString:kURLCategoryList requestDictionary:params delegate:self];
    _categoryReqeust.flag = kCategoryData;
    [_categoryReqeust startRequest];
}


#pragma mark - FBRequestDelegate

- (void)requestSucess:(FBRequest *)request result:(id)result {
    NSLog(@"Category result: %@", result);
    
    if ([request.flag isEqualToString:kCategoryData]) {
        NSLog(@"Flag: %@", request.flag);
        
        // 装载Model数据
        FBCategoryModel *categoryModel = [[FBCategoryModel alloc] init];
        
        NSArray *pageRows = [categoryModel asignModelWithObject:result];
        // 验证是否为空
        if (pageRows.count > 0) {
            [_dataSource addObjectsFromArray:pageRows];
            
            [self.tableView reloadData];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
}

- (void)requestFailed:(FBRequest *)request error:(NSError *)error {
    NSLog(@"error: %@", error);
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCategoryCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FBCategoryCell *cell = (FBCategoryCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 配置Cell数据
    FBCategoryModel *md = [_dataSource objectAtIndex:indexPath.row];
    
    [cell showCellWithModel:md];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FBCategoryModel *selectedCategory = [_dataSource objectAtIndex:indexPath.row];
    
    NSLog(@"Select category: %@", selectedCategory);
    
    
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
