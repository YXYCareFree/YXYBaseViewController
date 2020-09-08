//
//  YXYTimerProxy.m
//  YXYBaseViewController_Example
//
//  Created by yxy on 2020/8/10.
//  Copyright © 2020 YXYCareFree. All rights reserved.
//

#import "YXYTimerProxy.h"

@implementation YXYTimerProxy
- (void)dealloc
{
    NSLog(@"proxy  dealloc");
}

+ (YXYTimerProxy *)initWithTarget:(id)target{
    return [[YXYTimerProxy alloc] initWithTarget:target];
}

- (YXYTimerProxy *)initWithTarget:(id)target{
    self.target = target;
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
//    if (self.target) {
//        return [self.target methodSignatureForSelector:sel];
//    }
//    return [NSObject methodSignatureForSelector:@selector(init)];
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    if ([self.target respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:self.target];
    }
//    void *null = NULL;
//    [invocation setReturnValue:&null];
}

//- (BOOL)respondsToSelector:(SEL)aSelector{
//    return [self.target respondsToSelector:aSelector];
//}
//- (NSUInteger)hash {
//    return [_target hash];
//}
//
//- (Class)superclass {
//    return [_target superclass];
//}
//
//- (Class)class {
//    return [_target class];
//}

//+ (BOOL)respondsToSelector:(SEL)aSelector{
//
//}
@end
