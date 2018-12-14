//
//  CircleImageView.m
//  AFNetworking
//
//  Created by apple on 2018/11/10.
//

#import "CircleImageView.h"
#import "UIView+Helper.h"

@implementation CircleImageView

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.radius) {
        [self addMaskLayer];
    }else{
        self.layer.cornerRadius = self.yxy_w / 2;
        self.layer.masksToBounds = YES;
    }
}

- (void)addMaskLayer{
    CAShapeLayer *maskLayer = self.layer.mask;
    if (!maskLayer) {
        maskLayer = [CAShapeLayer layer];
    }
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.radius];
    maskLayer.path = maskPath.CGPath;
    maskLayer.frame = self.bounds;
    self.layer.mask = maskLayer;
}

@end
