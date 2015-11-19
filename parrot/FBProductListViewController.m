//
//  FBProductListViewController.m
//  parrot
//
//  Created by xiaoyi on 15/11/18.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBProductListViewController.h"

#import "MJRefresh.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "FBAPI.h"
#import "FBConfig.h"
#import "FBRequest.h"

#import "FBProductCell.h"
#import "FBCategoryModel.h"
#import "FBProductModel.h"

@interface FBProductListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,FBRequestDelegate> {
    FBAPI *_apiRequest;
    NSMutableArray *_dataSource;
}

@property (nonatomic, assign) int page;

@end

#define kProductData   @"fetch_product_data"

@implementation FBProductListViewController

static NSString * const reuseIdentifier = @"ProductCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _selectedCategory.cateTitle;
    
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    
    // 初始化
    _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    _page = 1;
    
    // 注册优化
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 始终保持上下滑动
    self.collectionView.alwaysBounceVertical = YES;
    
    // 下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self initRequest];
        [self.collectionView.mj_header endRefreshing];
    }];
    
    // 上拉加载更多
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
        [self.collectionView.mj_footer endRefreshing];
    }];
    
    // 初始化数据
    [self initRequest];
}

// 初始化请求
- (void)initRequest {
    _page = 1;
    
    // 初始化时需清空dataSource,避免下拉/上拉交叉获取
    [_dataSource removeAllObjects];
    _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    
    // 注意：初始化数据源后，务必同步刷新tableview
    [self.collectionView reloadData];
    
    [self request];
}

// 加载更多数据
- (void)loadMoreData {
    _page++;
    
    [self request];
}

- (void)request {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    params[@"page"] = @(_page);
    params[@"size"] = @6;
    
    params[@"category_id"] = _selectedCategory.cateID;
    
    _apiRequest = [FBAPI getWithUrlString:kURLProductList requestDictionary:params delegate:self];
    _apiRequest.flag = kProductData;
    [_apiRequest startRequest];
}

#pragma mark - FBRequestDelegate

- (void)requestSucess:(FBRequest *)request result:(id)result {
    NSLog(@"Products: %@", result);
    if ([request.flag isEqualToString: kProductData]) {
        // 装载Model数据
        FBProductModel *md = [[FBProductModel alloc] init];
        
        NSArray *pageRows = [md asignModelWithObject:result];
        
        if ([pageRows count] > 0) {
            [_dataSource addObjectsFromArray:pageRows];
            [self.collectionView reloadData];
        } else {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
    }
}

- (void)requestFailed:(FBRequest *)request error:(NSError *)error {
    NSLog(@"Fetch product: %@", error);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataSource count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FBProductCell *cell = (FBProductCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 设置圆角
    [cell.layer setMasksToBounds:YES];
    [cell.layer setCornerRadius:3];
    
    FBProductModel *md = (FBProductModel *)[_dataSource objectAtIndex:indexPath.item];
    [cell showCellWithModel:md];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

// 定义每个Item的大小
- (CGSize)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(148.0f, 185.0f);
}

// 定义每个collection的margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(8, 8, 8, 8);
}

// 每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8.0f;
}

// 每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}


#pragma mark - UICollectionViewDelegate



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
