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
            
        }
    }
    return self;
}

// 是否登录状态
+ (BOOL)isLogin {
    NSUserDefaults *passportDefaults = [NSUserDefaults standardUserDefaults];
    return [passportDefaults boolForKey:@"FB_USER_LOGIN"];
}

// 更新登录状态
+ (void)setLoginStatus:(BOOL)status {
    NSUserDefaults *passportDefaults = [NSUserDefaults standardUserDefaults];
    [passportDefaults setBool:status forKey:@"FB_USER_LOGIN"];
    
    [passportDefaults synchronize];
}

+ (void)logout {
    [self setLoginStatus:NO];
    
    // 清空用户信息
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"FB_SESSION_ID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)addSessionId:(NSInteger)userId {
    NSUserDefaults *passportDefaults = [NSUserDefaults standardUserDefaults];
    [passportDefaults setInteger:userId forKey:@"FB_SESSION_ID"];
    [passportDefaults synchronize];
    
    // 同步设置登录状态
    [self setLoginStatus:YES];
}

+ (NSInteger)getSessionId {
    NSUserDefaults *passportDefaults = [NSUserDefaults standardUserDefaults];
    return [passportDefaults integerForKey:@"FB_SESSION_ID"];
}

// 添加最新订单ID
+ (void)setLastOrderId:(NSString *)orderId {
    NSUserDefaults *passportDefaults = [NSUserDefaults standardUserDefaults];
    [passportDefaults setObject:orderId forKey:@"FB_LAST_ORDERID"];
    [passportDefaults synchronize];
}

// 获取最新订单ID
+ (NSString *)getLastOrderId {
     NSUserDefaults *passportDefaults = [NSUserDefaults standardUserDefaults];
    return [passportDefaults objectForKey:@"FB_LAST_ORDERID"];
}

// 更新用户信息
- (void)updateUserInfo:(NSDictionary *)user {
    
}

// 获取用户信息
- (FBUserModel *)findUserInfo:(NSInteger)userId {
    FBUserModel *currentUser;
    
    return currentUser;
}

// 获取最新用户
- (FBUserModel *)findLastUser {
    FBUserModel *currentUser;
    
    return currentUser;
}



// 获取UUID
- (NSString *)uuid {
    NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:kLocalKeyUUID];
    if (uuid) {
        return uuid;
    }
    // 创建新UUID
    NSString *new_uuid = [self genUid];
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
- (NSString *)genUid {
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


- (void)modifyLocalAvatar:(NSString *)avatar {
    
}

@end
