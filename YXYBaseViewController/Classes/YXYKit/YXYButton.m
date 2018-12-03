//
//  YXYButton.m
//  Test
//
//  Created by apple on 2018/9/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYButton.h"

@implementation YXYButton

- (YXYButton *(^)(UIFont *))titleFont{
    return ^id(UIFont *font){
        self.titleLabel.font = font;
        return self;
    };
}

- (YXYButton *(^)(UIColor *, UIControlState))color{
    return ^id(UIColor *color, UIControlState state){
        [self setTitleColor:color forState:state];
        return self;
    };
}

- (YXYButton *(^)(NSString *, UIControlState))title{
    return ^id(NSString *title, UIControlState state){
        [self setTitle:title forState:state];
        return self;
    };
}

- (YXYButton *(^)(UIImage *, UIControlState))bgImgae{
    return ^id(UIImage *image, UIControlState state){
        [self setBackgroundImage:image forState:state];
        return self;
    };
}

- (YXYButton *(^)(UIImage *, UIControlState))setImgae{
    return ^id(UIImage *image, UIControlState state){
        [self setImage:image forState:state];
        return self;
    };
}
@end
