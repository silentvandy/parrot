//
//  FBTrialViewController.m
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBTrialViewController.h"

#import "FBConfig.h"
#import "FBTabBar.h"

@interface FBTrialViewController ()<FBTabBarDelegate> {
    FBTabBar *_tabBar;
}

@end

@implementation FBTrialViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 添加分类tab
    NSArray *allTabs = [[NSArray alloc] initWithObjects:@"免费试用", @"评测报告", nil];
    _tabBar = [[FBTabBar alloc] initWithFrame:CGRectMake(0, 64.0f, SCREEN_WIDTH, 44.0f) showArrawButton:NO];
    _tabBar.delegate   = self;
    _tabBar.itemTitles = allTabs;
    _tabBar.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];;
    [_tabBar updateItemsData];
    
    [self.view addSubview:_tabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"试用";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
}

- (void)itemDidSelectedWithIndex:(NSInteger)index {
    NSLog(@"Clicked index: %lu", index);
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
