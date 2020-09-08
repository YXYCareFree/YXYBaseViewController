//
//  YXYGCDTimer.m
//
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 YXY. All rights reserved.
//

#import "YXYGCDTimer.h"

@interface YXYGCDTimer ()

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, assign) BOOL using;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, assign) NSTimeInterval interval;

@end;

@implementation YXYGCDTimer

- (void)dealloc{
    NSLog(@"YXYGCDTimer DEALLOC");
}

+ (instancetype)initWithSelector:(SEL)selector target:(id)target timeInterval:(NSTimeInterval)timeInterval{
    YXYGCDTimer *gcd = [YXYGCDTimer new];
    gcd.target = target;
    gcd.selector = selector;
    gcd.interval = timeInterval;
    return gcd;
}

- (void)stop{
    //不能多次调用suspend
    if (!self.using || !_timer) return;
    dispatch_suspend(self.timer);
    self.using = NO;
}

- (void)cancel{
    //不能多次调用cancel
    if (_timer && self.using) {
        dispatch_cancel(self.timer);
        self.timer = nil;
        self.using = NO;
    }
}

- (void)resume{
    //不能多次调用resume
    if (self.using) return;
    dispatch_resume(self.timer);
    self.using = YES;
}

- (void)run{
    if (self.target && [self.target respondsToSelector:self.selector]) {
        [self.target performSelector:self.selector];
    }else{
        [self cancel];
    }
}

- (dispatch_source_t)timer{
    if (!_timer) {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, self.interval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(_timer, ^{
            [self run];
        });
    }
    return _timer;
}
@end
