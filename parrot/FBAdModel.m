//
//  FBAdModel.m
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBAdModel.h"
#import "NSDictionary+ModelParse.h"

@implementation FBAdModel

- (NSMutableArray *)asignModelWithObject:(id)resultObject {
    NSMutableArray *newAry = [[NSMutableArray alloc] init];
    
    NSArray *rows = resultObject[@"data"][@"rows"];
    
    for (NSDictionary *dict in rows) {
        FBAdModel *adv = [[FBAdModel alloc] init];
        
        adv.adID = [dict stringValueForKey:@"_id"];
        adv.adTitle = [dict stringValueForKey:@"title"];
        adv.adSubTitle = [dict stringValueForKey:@"subtitle"];
        adv.adType = [dict intValueForKey:@"type"];
        if (adv.adType == 2) {
            NSString *itemType = [dict stringValueForKey:@"item_type"];
            if ([itemType isEqualToString:@"Topic"]) {
                adv.adType = kAdTypeTopic;
            } else {
                adv.adType = kAdTypeProduct;
            }
        }
        adv.adImage = [dict stringValueForKey:@"cover_url"];
        
        [newAry addObject:adv];
    }
    
    return newAry;
}

@end
