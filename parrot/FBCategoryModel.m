//
//  FBCategoryModel.m
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBCategoryModel.h"
#import "NSDictionary+ModelParse.h"

@implementation FBCategoryModel

- (NSArray *)asignModelWithObject:(id)resultObject {
    
    NSMutableArray *newAry = [[NSMutableArray alloc] init];
    
    NSArray *rows = resultObject[@"data"][@"rows"];
    // 验证是否为空
    if (rows.count) {
        for (NSDictionary *dict in rows) {
            FBCategoryModel *md = [[FBCategoryModel alloc] init];
            
            md.cateID    = [dict stringValueForKey:@"_id"];
            md.cateName  = [dict stringValueForKey:@"name"];
            md.cateTitle = [dict stringValueForKey:@"title"];
            
            md.cateImage = [dict stringValueForKey:@"app_cover_url"];
            md.cateCount = [dict intValueForKey:@"total_count"];
            
            [newAry addObject:md];
        }
    }
    return newAry;
}

@end
