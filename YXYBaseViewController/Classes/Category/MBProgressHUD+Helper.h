//
//  MBProgressHUD+Helper.h
//  AFNetworking
//
//  Created by apple on 2018/11/6.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Helper)

/**
 默认3s后消失

 @param text 展示的text
 */
+ (void)showText:(NSString *)text;

+ (void)showText:(NSString *)text afterDelay:(NSInteger)delay;

+ (instancetype)showLoadingWithText:(NSString *)text;

+ (instancetype)showLoading;

@end

NS_ASSUME_NONNULL_END
