//
//  FBProductDetailViewController.m
//  parrot
//
//  Created by xiaoyi on 15/11/19.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBProductDetailViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "FBAPI.h"
#import "FBConfig.h"
#import "FBRequest.h"

#import "FBProductCell.h"
#import "FBProductModel.h"

@interface FBProductDetailViewController () <FBRequestDelegate> {
    FBAPI *_apiRequest;
    NSDictionary *_detailDict;
}

@end


#define kProductDetail @"fetch_product_info"

@implementation FBProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _selectedProduct.title;
    
    // 设置产品信息
    [self buildUIFace];
    
    // 初始化详情
    [self requestDetailData];
}

// 更新UI界面
- (void)buildUIFace {
    self.titleLabel.text     = _selectedProduct.title;
    self.salePriceLabel.text = _selectedProduct.salePrice;
    self.summaryLabel.text   = _selectedProduct.summary;
    
    // 创建底部浮动层
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGRect bounds = CGRectMake(screen.origin.x, screen.origin.y, screen.size.width, 40);
    
    UIView *floatView = [[UIView alloc] initWithFrame:bounds];
    floatView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [self.view addSubview:floatView];
}

// 获取产品详情信息
- (void)requestDetailData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"id"] = _selectedProduct.pid;
    
    _apiRequest = [FBAPI getWithUrlString:kURLProductView requestDictionary:params delegate:self];
    _apiRequest.flag = kProductDetail;
    [_apiRequest startRequest];
}

#pragma mark - FBRequestDelegate

- (void)requestSucess:(FBRequest *)request result:(id)result {
    if ([request.flag isEqualToString:kProductDetail]) {
        _detailDict = result[@"data"];
        // NSLog(@"Product detail: %@", _detailDict);
    }
}

- (void)requestFailed:(FBRequest *)request error:(NSError *)error {
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
