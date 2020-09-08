//
//  YXYTimerProxy.h
//  YXYBaseViewController_Example
//
//  Created by yxy on 2020/8/10.
//  Copyright © 2020 YXYCareFree. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXYTimerProxy : NSProxy

@property (nonatomic, weak) id target;

+ (YXYTimerProxy *)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
