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
    }
}

- (void)addMaskLayer{
    CAShapeLayer *maskLayer = self.layer.mask;
    if (!maskLayer) {
        maskLayer = [CAShapeLayer layer];
    }
    CGRect rect = self.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.radius];
    maskLayer.path = maskPath.CGPath;
    maskLayer.frame = rect;
    self.layer.mask = maskLayer;
}

@end
