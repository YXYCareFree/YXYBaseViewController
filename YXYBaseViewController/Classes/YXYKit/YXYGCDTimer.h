//
//  YXYGCDTimer.h
//  趣睡
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 Yutao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXYGCDTimer : NSObject

/**
 创建GCDTimer并自动开始运行,创建后会马上执行一次selector
 @param selector sel
 @param target target
 @param timeInterval interval
 @return YXYGCDTimer
 */
+ (instancetype)initWithSelector:(SEL)selector target:(id)target timeInterval:(NSTimeInterval)timeInterval;

- (void)cancel;

- (void)stop;

-(void)resume;

@end
