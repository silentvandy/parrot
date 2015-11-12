//
//  FBMainViewController.h
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FBSlides.h"

@interface FBMainViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,FBSlidesDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
