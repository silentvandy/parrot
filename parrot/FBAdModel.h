//
//  FBAdModel.h
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    kAdTypeWeb         = 1,
    kAdTypeProduct     = 2,
    kAdTypeTopic       = 3,
    kAdTypeList        = 4,
} FBAdType;

@interface FBAdModel : NSObject

@property (nonatomic, copy) NSString *adID;
@property (nonatomic, copy) NSString *adImage;
@property (nonatomic, copy) NSString *adTitle;
@property (nonatomic, copy) NSString *adSubTitle;
@property (nonatomic, copy) NSString *adWebUrl;

@property (nonatomic, assign) FBAdType adType;

@end
