//
//  FBCategoryModel.h
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBCategoryModel : NSObject

// 分类ID
@property (nonatomic, copy) NSString *cateID;

// 分类名称
@property (nonatomic, copy) NSString *cateName;

// 分类中文名
@property (nonatomic, copy) NSString *cateTitle;

// 分类描述
@property (nonatomic, copy) NSString *cateSummary;

// 分类图片
@property (nonatomic, copy) NSString *cateImage;

// 子数量
@property (nonatomic, assign) int cateCount;


- (NSArray *)asignModelWithObject:(id)resultObject;

@end
