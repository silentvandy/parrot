//
//  FBConfig.h
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#ifndef FBConfig_h
#define FBConfig_h

#define kAppDebug 1

#define kChannel              @"appstore";
// 客户端版本
#define kClientVersion        @"2.1.0"
#define kClientID             @"1415289600"
#define kClientSecret         @"545d9f8aac6b7a4d04abffe5"

#define kFontFamily           @"HelveticaNeue"

// App Store ID
#define kAppStoreId           @"FrBrid2.0"
#define kAppName              @"太火鸟+"

// Error Domain
#define kDomain               @"TaiHuoNiao"
#define kServerError          60001
#define kParseError           60002
#define kNetError             60003

#define kUserInfoPath         @"FB__StoreUserInfo__"
#define kLocalKeyUUID         @"FB__UUID__"

// 用户设备系统版本
#define IOS7_OR_LATER         ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS8_OR_LATER         ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )

// 判断是否是4寸屏
#define IS_PHONE5             ( ([[UIScreen mainScreen] bounds].size.height-568) ? NO : YES )

// 屏幕宽高
#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width

#define kItemWidth 320.0

// 超时时间
#define kTimeoutTime  30

#define kSlideBannerHeight 225.00001f
#define kMainTabelCellHeight 266
#define kCategoryCellHeight 100.0f


// API ROOT URL
#define kDomainBaseUrl @"http://taihuoniao.me/app/api"

/*
 * API URL
 */
// 首页
#define kURLMainSlide            @"/gateway/slide"

// 产品分类列表
#define kURLCategoryList         @"/product/category"
#define kURLProductList          @"/product/getlist"
#define kURLProductView          @"/product/view"



// 无参数的Block回调
typedef void (^CallbackBlock)(void);

// 带一个参数的Block回调
typedef void (^CallbackBlockWithParam)(id param);


#endif /* FBConfig_h */
