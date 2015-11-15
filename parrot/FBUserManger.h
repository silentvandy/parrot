//
//  FBUserManger.h
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FBUserModel;

@interface FBUserManger : NSObject {
    BOOL         *_isLogin;
}

@property (nonatomic,strong) NSString *accountField;

// 设置登录状态
+ (BOOL)isLogin;
+ (void)setLoginStatus:(BOOL)status;

// 设置退出状态
+ (void)logout;

// 获取登录用户ID
+ (void)addSessionId:(NSInteger)userId;
+ (NSInteger)getSessionId;

// 更新用户信息
- (void)updateUserInfo:(NSDictionary *)user;
- (FBUserModel *)findUserInfo:(NSInteger)userId;
- (FBUserModel *)findLastUser;

// 最新订单Id
+ (void)setLastOrderId:(NSString *)orderId;
+ (NSString *)getLastOrderId;

- (void)modifyLocalAvatar:(NSString *)avatar;

@end
