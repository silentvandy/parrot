//
//  FBProductModel.m
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBProductModel.h"

@implementation FBProductModel

- (id)init {
    if (self = [super init]) {
        _productAdImages = [[NSArray alloc] init];
        _skusCount = 0;
    }
    return self;
}

@end
