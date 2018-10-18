//
//  UIView+Helper.h
//  趣睡
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 Yutao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Helper)

//使用Masonry布局的时候获取为0，因为界面还没有刷新，需要调用superView的layoutIfNeeded
@property (nonatomic, assign) CGFloat yxy_w;
@property (nonatomic, assign) CGFloat yxy_h;

/**
 origin.x
 */
@property (nonatomic, assign) CGFloat yxy_x;

/**
 origin.y
 */
@property (nonatomic, assign) CGFloat yxy_y;

/**
 center.x
 */
@property (nonatomic, assign) CGFloat yxy_cx;

/**
 center.y
 */
@property (nonatomic, assign) CGFloat yxy_cy;


- (void)setCornerRadius:(CGFloat)radius;

@end
