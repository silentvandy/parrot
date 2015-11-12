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
    BOOL         *_loginState;
    NSString     *_userId;
}

// 是否登录标识
@property (nonatomic, assign, readonly) BOOL   loginState;

@property (nonatomic, copy) NSString  *userId;
@property (nonatomic, assign, readonly) FBUserModel  *userInfo;

- (NSString *)uuid;
+ (NSString *)time;
+ (NSString *)channel;
+ (NSString *)clientId;
+ (NSString *)clientSecret;

+ (NSString *)standardDate;

- (NSString *)gender;

- (void)login;
- (void)loginWithAnimation:(BOOL)animation;

- (void)logout;
- (void)storeUserInfo;

- (void)backToGame;

- (void)modifyLocalAvatar:(NSString *)avatar;

- (void)loginSuccess;
- (void)refreshUserInfo;

@end
