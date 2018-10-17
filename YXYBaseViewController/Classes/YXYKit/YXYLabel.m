//
//  YXYLabel.m
//  Test
//
//  Created by apple on 2018/9/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYLabel.h"

@implementation YXYLabel

- (YXYLabel *(^)(NSString *))title{
    return ^id(NSString *title){
        self.text = title;
        return self;
    };
}

- (YXYLabel *(^)(UIColor *))color{
    return ^id(UIColor *color){
        self.textColor = color;
        return self;
    };
}

- (YXYLabel *(^)(NSTextAlignment))alignment{
    return ^id(NSTextAlignment alignment){
        self.textAlignment = alignment;
        return self;
    };
}

- (YXYLabel *(^)(UIFont *))titleFont{
    return ^id(UIFont *font){
        self.font = font;
        return self;
    };
}
@end
