//
//  YXYHTTPRequestClient.m
//  AF
//
//  Created by 杨肖宇 on 2017/6/23.
//  Copyright © 2017年 杨肖宇. All rights reserved.
//

#import "YXYHTTPRequestClient.h"
#import "YYCache.h"
#import "NSString+MD5Addition.h"

#define WEAKSELF           typeof(self) __weak weakSelf = self;

@interface YXYHTTPRequestClient ()

@property (nonatomic, strong) NSMutableArray *taskArr;//正在执行的网络请求任务

@property (nonatomic, strong) NSMutableDictionary *runningRequest;//正在执行的网络请求

@property (nonatomic, strong) YYCache *cache;

@end

@implementation YXYHTTPRequestClient

+ (instancetype)shareManagerWithBaseUrl:(NSString *)urlStr cerPath:(NSString *)path AFSSLPinningMode:(AFSSLPinningMode)model{
    
    static YXYHTTPRequestClient * shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 25;
        shareManager.taskArr = NSMutableArray.new;
        shareManager.runningRequest = NSMutableDictionary.new;
        shareManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:urlStr] sessionConfiguration:config];
        shareManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"charset=UTF-8",@"Content-Type",@"application/json",nil];
        if (path) {
            NSData *certData = [NSData dataWithContentsOfFile:path];
            AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:model];
            if (certData) {
                securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
                [shareManager setSecurityPolicy:securityPolicy];
            }
        }
    });
    return shareManager;
}

- (void)startRequest:(YXYRequest *)request success:(void(^)(id responseObj, id cacheObj))success failure:(void(^)(NSError *error))failure{
    
    if (request.isCache && [self.cache objectForKey:[request.apiName stringFromMD5]]) {//缓存操作
        if (success) {
            success(nil, [self.cache objectForKey:[request.apiName stringFromMD5]]);
        }
    }
    
    BOOL isRepeat = NO;
    if (!self.runningRequest[request.apiName]) {
        [self.runningRequest setObject:[NSMutableArray new] forKey:request.apiName];
    }
    NSMutableArray *running = self.runningRequest[request.apiName];
    if ([running containsObject:request.params]) {
        isRepeat = YES;
    }else{
        [running addObject:request.params];
    }
    //重复的网络请求不发送，apiName和params都相同即为相同的请求
    if (isRepeat) return;
    
    __block YXYRequest * request_block = request;
    WEAKSELF;
    __block NSURLSessionDataTask *task = nil;
    //添加公共参数
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:request.params];
    [self.commonParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [params setObject:obj forKey:key];
    }];
    
    if (request.method == YXYHTTPMethodGET) {
      
        task = [self GET:request.apiName parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
            [weakSelf handleSuccess:success responseObj:responseObject request:request_block task:task];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          
            [weakSelf handleFailure:failure error:error request:request_block task:task];

        }];
    }else if (request.method == YXYHTTPMethodPOST){
      
        task = [self POST:request.apiName parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
            [weakSelf handleSuccess:success responseObj:responseObject request:request_block task:task];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [weakSelf handleFailure:failure error:error request:request_block task:task];
        }];
    }

    if (task) {
        [self.taskArr addObject:task];
    }
}

- (void)handleSuccess:(void(^)(id responseObj, id cacheObj))success responseObj:(id)responseObject request:(YXYRequest *)request task:(NSURLSessionDataTask *)task{
   
    if (success) {
        success(responseObject, nil);
    }
    
    if (request.isCache) {
        [self.cache setObject:responseObject forKey:[request.apiName stringFromMD5]];
    }
    
    NSMutableArray * running = self.runningRequest[request.apiName];
    if ([running containsObject:request.params]) {
        [running removeObject:request.params];
        if (running.count == 0) {
            NSLog(@"移除apiArr, %@", request.apiName);
            [self.runningRequest removeObjectForKey:request.apiName];
        }
    }
    
    if ([self.taskArr containsObject:task]) {
        [self.taskArr removeObject:task];
    }
}

- (void)handleFailure:(void(^)(NSError *error))failure error:(NSError *)error request:(YXYRequest *)request task:(NSURLSessionDataTask *)task{
    if (failure) {
        failure(error);
    }
    
    if ([self.taskArr containsObject:task]) {
        [self.taskArr removeObject:task];
    }
    
    NSMutableArray * running = self.runningRequest[request.apiName];
    if ([running containsObject:request.params]) {
        [running removeObject:request.params];
        if (running.count == 0) {
            NSLog(@"移除apiArr, %@", request.apiName);
            [self.runningRequest removeObjectForKey:request.apiName];
        }
    }
}

- (NSDictionary *)commonParams{
    if (!_commonParams) {
        _commonParams = [NSDictionary new];
    }
    return _commonParams;
}

- (YYCache *)cache{
    if (!_cache) {
        _cache = [YYCache cacheWithName:@"YXYNetworkCache"];
    }
    return _cache;
}

@end
