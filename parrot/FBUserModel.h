//
//  FBUserModel.h
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBUserModel : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *job;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *mail;
@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) int gender;

@end
