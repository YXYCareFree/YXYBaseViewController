//
//  YXYButton.m
//  Test
//
//  Created by apple on 2018/9/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYButton.h"

@implementation YXYButton

+ (instancetype)new{
    YXYButton *btn = [super new];
    btn.adjustsImageWhenHighlighted = NO;
    return btn;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (YXYButton *(^)(UIFont *))titleFont{
    return ^YXYButton *(UIFont *font){
        self.titleLabel.font = font;
        return self;
    };
}

- (YXYButton *(^)(UIColor *, UIControlState))color{
    return ^YXYButton *(UIColor *color, UIControlState state){
        [self setTitleColor:color forState:state];
        return self;
    };
}

- (YXYButton *(^)(NSString *, UIControlState))title{
    return ^YXYButton *(NSString *title, UIControlState state){
        [self setTitle:title forState:state];
        return self;
    };
}

- (YXYButton *(^)(UIImage *, UIControlState))bgImgae{
    return ^YXYButton *(UIImage *image, UIControlState state){
        [self setBackgroundImage:image forState:state];
        return self;
    };
}

- (YXYButton *(^)(UIImage *, UIControlState))setImgae{
    return ^YXYButton *(UIImage *image, UIControlState state){
        [self setImage:image forState:state];
        return self;
    };
}
@end
