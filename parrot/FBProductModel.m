//
//  FBProductModel.m
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBProductModel.h"
#import "NSDictionary+ModelParse.h"

@implementation FBProductModel

- (NSArray *)asignModelWithObject:(id)resultObject {
    NSMutableArray *newResult = [[NSMutableArray alloc] init];
    
    NSArray *rows = resultObject[@"data"][@"rows"];
    // 验证是否为空
    if (rows.count) {
        for (NSDictionary *dict in rows) {
            FBProductModel *md = [[FBProductModel alloc] init];
            
            md.pid = [dict stringValueForKey:@"_id"];
            md.title = [dict stringValueForKey:@"title"];
            // todo: 会员价格暂时无，需要补充
            md.userPrice = [dict stringValueForKey:@"sale_price"];
            md.salePrice = [dict stringValueForKey:@"sale_price"];
            
            md.coverImage = [dict stringValueForKey:@"cover_url"];
            
            [newResult addObject:md];
        }
    }
    
    return newResult;
}

@end
