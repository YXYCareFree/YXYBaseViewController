//
//  YXYTimer.m
//  YXYBaseViewController_Example
//
//  Created by yxy on 2020/8/10.
//  Copyright © 2020 YXYCareFree. All rights reserved.
//

#import "YXYTimer.h"

@implementation YXYTimer

- (void)dealloc
{
    NSLog(@"YXYTimer dealloc===");
}

+ (YXYTimer *)timerWithTarget:(id)target sel:(SEL)sel duration:(CGFloat)duration{
    return [[YXYTimer alloc] initWithTarget:target sel:sel duration:duration];
}

- (YXYTimer *)initWithTarget:(id)target sel:(SEL)sel duration:(CGFloat)duration{
    self = [super init];
    self.target = target;
    self.timer = [NSTimer timerWithTimeInterval:duration target:self selector:@selector(run) userInfo:nil repeats:YES];
    self.selector = sel;
    [NSRunLoop.currentRunLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
    return self;
}

- (void)run{
    if (self.target) {
        [self.target performSelector:self.selector];
    }else{
        [self.timer invalidate];
    }
}

@end
