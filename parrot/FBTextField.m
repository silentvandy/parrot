//
//  FBTextField.m
//  parrot
//
//  Created by xiaoyi on 15/11/13.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBTextField.h"

@implementation FBTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // init code
    }
    
    return self;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGFloat insetX = (self.placeholderOffset.x == 0) ? 20 : self.placeholderOffset.x;
    CGFloat insetY = (self.placeholderOffset.y == 0) ? 10 : self.placeholderOffset.y;
    return CGRectInset(bounds,insetX,insetY);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGFloat insetX = (self.textOffset.x == 0) ? 20 : self.textOffset.x;
    CGFloat insetY = (self.textOffset.y == 0) ? 10 : self.textOffset.y;
    return CGRectInset(bounds,insetX,insetY);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    if (!CGRectEqualToRect(CGRectZero, self.textRect)) {
        return self.textRect;
    }
    CGFloat insetX = (self.textOffset.x == 0) ? 20 : self.textOffset.x;
    CGFloat insetY = (self.textOffset.y == 0) ? 10 : self.textOffset.y;
    return CGRectInset(bounds,insetX,insetY);
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    return self.leftViewRect;
}

@end
