//
//  YXYTimer.h
//  YXYBaseViewController_Example
//
//  Created by yxy on 2020/8/10.
//  Copyright © 2020 YXYCareFree. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXYTimer : NSObject

@property (nonatomic, weak) id target;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) SEL selector;


+ (YXYTimer *)timerWithTarget:(id)target sel:(SEL)sel duration:(CGFloat)duration;

@end

NS_ASSUME_NONNULL_END
