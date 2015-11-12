//
//  FBProductModel.h
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBProductModel : NSObject

// 产品描述
@property (nonatomic, copy) NSString *productSummary;
// 轮播图数组
@property (nonatomic, retain) NSArray *productAdImages;
// 内容介绍页
@property (nonatomic, copy) NSString *productContentURL;
/*评论*/
// 数量
@property (nonatomic, copy) NSString *productCommentCount;
/*SKU*/
@property (nonatomic, retain) NSArray *skus;
/*SKU count*/
@property (nonatomic, assign) int skusCount;

/*当前用户是否收藏*/
@property (nonatomic, assign) BOOL userLike;
/*当前用户是否点赞*/
@property (nonatomic, assign) BOOL userLove;

// tag标签
@property (nonatomic, copy) NSString *productTags;

@end
