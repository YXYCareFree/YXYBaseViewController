//
//  YXYRequest.h
//  AFNetworking
//
//  Created by apple on 2018/10/25.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, YXYHTTPMethod){
    YXYHTTPMethodPOST,
    YXYHTTPMethodGET
};

typedef void(^YXYRequestSuccessBlock)(id obj);
typedef void(^YXYRequestFailureBlock)(NSString *msg, NSError *error);

//NS_ASSUME_NONNULL_BEGIN

@interface YXYRequest : NSObject

@property (nonatomic, strong) NSString *apiName;

@property (nonatomic, strong) NSDictionary *params;

@property (nonatomic, assign) YXYHTTPMethod method;

/**
 默认不缓存NO
 */
@property (nonatomic, assign) BOOL isCache;//是否缓存

@property (nonatomic, copy) YXYRequestSuccessBlock success;

@property (nonatomic, copy) YXYRequestFailureBlock failure;

/**
 默认为YES，展示errMsg
 */
@property (nonatomic, assign) BOOL showErrMsg;
/**
 请求数据转化成Model
 */
@property (nonatomic, assign) Class modelClass;



- (YXYRequest *(^)(NSString *apiName))APIName;

- (YXYRequest *(^)(NSDictionary *params))Params;

- (YXYRequest *(^)(BOOL isCache))cache;

- (YXYRequest *(^)(YXYHTTPMethod method))Method;

- (YXYRequest *(^)(YXYRequestSuccessBlock succ))succ;

- (YXYRequest *(^)(YXYRequestFailureBlock fail))fail;

- (YXYRequest *(^)(BOOL showErrorMsg))ShowErrorMsg;

/**
 请求结果需要转化的Model的类名
 */
- (YXYRequest *(^)(NSString *modelName))modelName;

@end

//NS_ASSUME_NONNULL_END
