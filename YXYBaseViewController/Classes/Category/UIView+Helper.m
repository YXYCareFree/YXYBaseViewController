//
//  UIView+Helper.m
//  趣睡
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 Yutao. All rights reserved.
//

#import "UIView+Helper.h"
#import <objc/runtime.h>

@implementation UIView (Helper)

- (CGFloat)yxy_h{
    return self.frame.size.height;
}

- (CGFloat)yxy_w{
    return self.frame.size.width;
}

- (CGFloat)yxy_x{
    return self.frame.origin.x;
}

- (CGFloat)yxy_y{
    return self.frame.origin.y;
}

- (CGFloat)yxy_cy{
    return self.center.y;
}

- (CGFloat)yxy_cx{
    return self.center.x;
}

- (void)setCornerRadius:(CGFloat)radius{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = radius;
}
@end
