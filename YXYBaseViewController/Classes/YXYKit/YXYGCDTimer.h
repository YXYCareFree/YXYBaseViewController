//
//  YXYGCDTimer.h
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 YXY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXYGCDTimer : NSObject

/**
 创建GCDTimer
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
