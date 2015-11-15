//
//  FBAccountViewController.m
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBAccountViewController.h"

#import "FBUserManger.h"

#import "FBLoginViewController.h"

@interface FBAccountViewController () {
    NSArray *_menuAry;
}
@property (nonatomic, strong) NSArray *menuAry;
@end

@implementation FBAccountViewController

@synthesize tableView = _tableView, menuAry = _menuAry;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的账户";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.menuAry = @[@"", @"我的订单", @"我的收藏", @"收货地址", @"我的红包", @"我的鸟币", @"客服热线"];
    
    // 添加tableview
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 470)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)dealloc {
    [self.tableView setDelegate:nil];
    [self.tableView setDataSource:nil];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 150;
    } else {
        return 42;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        // 个人资料
        if (indexPath.row == 0) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 25, 45, 50, 50)];
            imageView.tag = 1101;
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius  = 25;
            [cell.contentView addSubview:imageView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 25, 105, 200, 20)];
            titleLabel.tag = 1102;
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:titleLabel];
        } else {
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
        }
        
        // 客服热线无需指示
        if ((indexPath.row == [self.menuAry count] - 1) || (indexPath.row == 0)) {
            cell.accessoryType  = UITableViewCellAccessoryNone;
        } else {
            cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 0) {
        // 登录状态
        if ([FBUserManger isLogin] == YES) {
            
        } else { // 未登录状态显示默认值
            [((UIImageView *)[cell viewWithTag:1101]) setImage:[UIImage imageNamed:@"placeholder"]];
            [((UILabel *)[cell viewWithTag:1102]) setText:@"点击登录"];
            
            // 添加点击登录事件
            UITapGestureRecognizer *tapLogin = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(redirectLogin:)];
            ((UILabel *)[cell viewWithTag:1102]).userInteractionEnabled = YES;
            [((UILabel *)[cell viewWithTag:1102]) addGestureRecognizer:tapLogin];
        }
    } else {
        cell.textLabel.text = self.menuAry[indexPath.row];
        // 客服热线无需指示
        if (indexPath.row == [self.menuAry count] - 1) {
            UILabel *phone = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 140, 12, 140, 20)];
            phone.text = @"4008 798 751";
            [cell.contentView addSubview:phone];
        }
    }
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            break;
            
        case 6: {
            // 拨号
            NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", @"4008798751"];
            UIWebView *callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            
            [self.view addSubview:callWebview];
        }
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

- (void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

// 调整登录
- (void)redirectLogin:(id)sender {
    FBLoginViewController *loginViewController = [[FBLoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    loginViewController.title = @"登录";
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    //[self.navigationController pushViewController:nav animated:YES];
    
    [self presentViewController:nav animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
