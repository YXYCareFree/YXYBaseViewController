//
//  YXYUpdateVersionManager.h
//  AFNetworking
//
//  Created by yxy on 2020/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXYUpdateVersionManager : NSObject

/**
 检查更新
 */
+ (void)checkVersion:(NSString *)appId;

@end

NS_ASSUME_NONNULL_END
