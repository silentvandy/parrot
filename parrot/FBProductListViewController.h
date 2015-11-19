//
//  FBProductListViewController.h
//  parrot
//
//  Created by xiaoyi on 15/11/18.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBCategoryModel;

@interface FBProductListViewController : UIViewController

@property (nonatomic, strong) FBCategoryModel *selectedCategory;

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

@end
