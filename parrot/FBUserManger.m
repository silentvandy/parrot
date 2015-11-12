//
//  FBUserManger.m
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBUserManger.h"

#import <JSONKit/JSONKit.h>
#import "FBHttpRequest.h"

#import "FBConfig.h"
#import "FBUserModel.h"

@implementation FBUserManger

- (id)init {
    if (self = [super init]) {
        
        // 读取登录信息
        NSString *loginInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoPath];
        if (loginInfo) {
            // 解密
            
        } else {
            // 初始化未登录默认值
            [self resetValue];
        }
    }
    return self;
}

// 初始化默认值
- (void)resetValue {
    _userId = nil;
}

// 获取用户登录状态
- (BOOL)loginState {
    if (!self.userId || [self.userId isEqualToString:@""]) {
        return NO;
    }
    
    return YES;
}

// 获取UUID
- (NSString *)uuid {
    NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:kLocalKeyUUID];
    if (uuid) {
        return uuid;
    }
    // 创建新UUID
    NSString *new_uuid = [self gen_uuid];
    [self saveUUIDToLocal:new_uuid];
    
    return new_uuid;
}

// 本地化存储
- (void)saveUUIDToLocal:(NSString *)uuid {
    NSString *k = [[NSUserDefaults standardUserDefaults] objectForKey:kLocalKeyUUID];
    if (!k) {
        [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:kLocalKeyUUID];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

// 创建uuid
- (NSString *)gen_uuid {
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidStr = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidStr));
    CFRelease(puuid);
    CFRelease(uuidStr);
    
    return result;
}


+ (NSString *)time {
    NSDate *sendDate = [NSDate date];
    NSCalendar  *cal = [NSCalendar  currentCalendar];
    NSUInteger  unitFlags = NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents *conponent = [cal components:unitFlags fromDate:sendDate];
    NSInteger year = [conponent year];
    NSInteger month = [conponent month];
    NSInteger day = [conponent day];
    NSString *nsDateString = [NSString stringWithFormat:@"%4ld-%2ld-%2ld", (long)year, (long)month, (long)day];
    
    return nsDateString;
}

+ (NSString *)channel {
    return kChannel;
}

+ (NSString *)clientId {
    return kClientID;
}

+ (NSString *)clientSecret {
    return kClientSecret;
}

+ (NSString *)standardDate {
    return @"";
}

- (NSString *)gender {
    if (self.userInfo.gender == 1) {
        return @"男";
    } else if (self.userInfo.gender == 2) {
        return @"女";
    } else {
        return @"保密";
    }
}

- (void)login {
    
}

- (void)loginWithAnimation:(BOOL)animation {
    
}

// 安全退出
- (void)logout {
    [self removeUserInfo];
    [self resetValue];
}

// 登录成功
- (void)loginSuccess {
    [self storeUserInfo];
}

#pragma mark - 本地化信息
- (void)storeUserInfo {
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                              self.userId, @"userId", nil];
    NSString *storeData = [userInfo JSONString];
    [[NSUserDefaults standardUserDefaults] setObject:storeData forKey:kUserInfoPath];
    BOOL status = [[NSUserDefaults standardUserDefaults] synchronize];
    if (status == YES) {
        NSLog(@"Store user info success!");
    } else {
        NSLog(@"Store user info fail!!!");
    }
}

- (void)removeUserInfo {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserInfoPath];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 刷新用户信息
- (void)refreshUserInfo {
    
}

- (void)backToGame {
    
}

- (void)modifyLocalAvatar:(NSString *)avatar {
    
}

@end
