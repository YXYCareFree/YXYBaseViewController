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
    self.layer.cornerRadius = self.yxy_w / 2;
    self.layer.masksToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
}
@end
