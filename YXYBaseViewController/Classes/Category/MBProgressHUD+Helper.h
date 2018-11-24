//
//  MBProgressHUD+Helper.h
//  AFNetworking
//
//  Created by apple on 2018/11/6.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Helper)

+ (void)showText:(NSString *)text;

+ (instancetype)showLoadingWithText:(NSString *)text;

+ (instancetype)showLoading;

@end

NS_ASSUME_NONNULL_END
