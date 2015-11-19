//
//  FBProductModel.h
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBProductModel : NSObject

// 产品id
@property (nonatomic, copy) NSString *pid;

// 产品标题
@property (nonatomic, copy) NSString *title;

// 产品描述
@property (nonatomic, copy) NSString *summary;

// 产品封面图
@property (nonatomic, retain) NSString *coverImage;

// 内容介绍页
@property (nonatomic, copy) NSString *contentH5URL;

// 会员专享价
@property (nonatomic, copy) NSString *userPrice;

// 销售价格
@property (nonatomic, copy) NSString *salePrice;

// 市场价格
@property (nonatomic, copy) NSString *marketPrice;

/*评论*/

// 数量
@property (nonatomic, copy) NSString *commentCount;

/*SKU*/
@property (nonatomic, retain) NSArray *skus;

/*SKU count*/
@property (nonatomic, assign) int skusCount;

/*当前用户是否收藏*/
@property (nonatomic, assign) BOOL userLike;

/*当前用户是否点赞*/
@property (nonatomic, assign) BOOL userLove;

// tag标签
@property (nonatomic, copy) NSString *tags;

- (NSArray *)asignModelWithObject:(id)resultObject;

@end
