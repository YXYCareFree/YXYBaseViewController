//
//  YXYGCDTimer.m
//  趣睡
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 Yutao. All rights reserved.
//

#import "YXYGCDTimer.h"

@interface YXYGCDTimer ()

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, assign) BOOL using;
@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, assign) NSTimeInterval interval;

@end;

@implementation YXYGCDTimer

- (void)dealloc{
    NSLog(@"DEALLOC");
}

+ (instancetype)initWithSelector:(SEL)selector target:(id)target timeInterval:(NSTimeInterval)timeInterval{
    YXYGCDTimer *gcd = [YXYGCDTimer new];
    gcd.target = target;
    gcd.selector = selector;
    gcd.interval = timeInterval;
    gcd.using = YES;
    dispatch_resume(gcd.timer);
    return gcd;
}

- (void)stop{
    NSAssert(self.timer, @"YXYGCDTimer必须初始化");
    //不能多次调用suspend
    if (!self.using) return;
    dispatch_suspend(self.timer);
    self.using = NO;
}

- (void)cancel{
    NSAssert(self.timer, @"YXYGCDTimer必须初始化");
    NSAssert(self.using, @"YXYGCDTimer必须处于开启状态");
    dispatch_cancel(self.timer);
    self.timer = nil;
    self.using = NO;
}

- (void)resume{
    NSAssert(self.timer, @"YXYGCDTimer必须初始化");
    NSAssert(!self.using, @"YXYGCDTimer必须处于暂停状态");
    //不能多次调用resume
    if (self.using) return;
    dispatch_resume(self.timer);
    self.using = YES;
}

- (dispatch_source_t)timer{
    if (!_timer) {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, self.interval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(_timer, ^{
            if ([self.target respondsToSelector:self.selector]) {
                [self.target performSelector:self.selector];
            }
        });
    }
    return _timer;
}
@end
