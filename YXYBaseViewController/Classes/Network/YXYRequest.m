//
//  YXYRequest.m
//  AFNetworking
//
//  Created by apple on 2018/10/25.
//

#import "YXYRequest.h"

@implementation YXYRequest

+ (instancetype)new{
    YXYRequest *re = [super new];
    re.showErrMsg = YES;
    return re;
}

- (instancetype)init{
    if (self = [super init]) {
        self.showErrMsg = YES;
    }
    return self;
}

+ (YXYRequest *)initWithAPIName:(NSString *)apiName params:(NSDictionary *)params modelName:(NSString *)modelName succ:(YXYRequestSuccessBlock)succ fail:(YXYRequestFailureBlock)fail{
    return [[YXYRequest alloc] initWithAPIName:apiName params:params modelName:modelName succ:succ fail:fail];
}

- (YXYRequest *)initWithAPIName:(NSString *)apiName params:(NSDictionary *)params modelName:(NSString *)modelName succ:(YXYRequestSuccessBlock)succ fail:(YXYRequestFailureBlock)fail{
    if (self = [super init]) {
        self.apiName = apiName;
        self.params = params;
        self.modelClass = NSClassFromString(modelName);
        self.success = succ;
        self.failure = fail;
    }
    return self;
}

@end
