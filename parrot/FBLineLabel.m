//
//  FBLineLabel.m
//  parrot
//
//  Created by xiaoyi on 15/11/17.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBLineLabel.h"

@implementation FBLineLabel

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    /*
     1.获取到上下文CGContextRef
     2.设置画线的起点位置
     3.画线，并画到另一个点的位置
     4.渲染到屏幕上面
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, rect.size.height/2);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height/2);
    CGContextStrokePath(context);
}


@end
