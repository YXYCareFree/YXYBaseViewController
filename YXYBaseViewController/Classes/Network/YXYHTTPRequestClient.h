//
//  YXYHTTPRequestClient.h
//  AF
//
//  Created by 杨肖宇 on 2017/6/23.
//  Copyright © 2017年 杨肖宇. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "YXYRequest.h"

typedef void(^CompletionBlock)(BOOL success, id result, NSString * errorMsg);

@interface YXYHTTPRequestClient : AFHTTPSessionManager

@property (nonatomic, strong) NSDictionary *commonParams;
/**
 @param urlStr BASE_URL
 @param path ssl证书的路径
 @param model 证书的验证方法
 @return YXYHTTPRequestClient实例
 */
+ (instancetype)shareManagerWithBaseUrl:(NSString *)urlStr cerPath:(NSString *)path AFSSLPinningMode:(AFSSLPinningMode)model;

- (void)startRequest:(YXYRequest *)request success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

@end
