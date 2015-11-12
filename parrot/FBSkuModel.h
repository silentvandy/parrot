//
//  FBSkuModel.h
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    kSkuStageSelling,
    kSkuStagePre
} SkuStage;

@interface FBSkuModel : NSObject

@property (nonatomic, assign) int skuID;
@property (nonatomic, copy) NSString *skuName;
@property (nonatomic, copy) NSString *skuMode;
@property (nonatomic, copy) NSString *skuPrice;
@property (nonatomic, copy) NSString *skuSummary;
@property (nonatomic, assign) int skuLimmitedCount; // 限量个数
@property (nonatomic, assign) int skuSyncCount; // 已购买个数
@property (nonatomic, assign) SkuStage skuStage;

@end
