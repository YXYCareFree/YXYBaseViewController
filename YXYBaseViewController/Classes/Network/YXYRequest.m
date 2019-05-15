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

- (YXYRequest * _Nonnull (^)(NSString * _Nonnull))APIName{
   return ^YXYRequest *(NSString *apiName){
        self.apiName = apiName;
        return self;
    };
}

- (YXYRequest *(^)(NSDictionary *))Params{
    return ^YXYRequest *(NSDictionary *params){
        self.params = params;
        return self;
    };
}

- (YXYRequest *(^)(BOOL))cache{
    return ^YXYRequest *(BOOL cache){
        self.isCache = cache;
        return self;
    };
}

- (YXYRequest *(^)(YXYHTTPMethod))Method{
    return ^YXYRequest *(YXYHTTPMethod method){
        self.method = method;
        return self;
    };
}

- (YXYRequest *(^)(YXYRequestSuccessBlock))succ{
    return ^YXYRequest *(YXYRequestSuccessBlock succ){
        self.success = succ;
        return self;
    };
}

- (YXYRequest *(^)(YXYRequestFailureBlock))fail{
    return ^YXYRequest *(YXYRequestFailureBlock fail){
        self.failure = fail;
        return self;
    };
}

- (YXYRequest *(^)(BOOL))ShowErrorMsg{
    return ^YXYRequest *(BOOL show){
        self.showErrMsg = show;
        return self;
    };
}

- (YXYRequest *(^)(NSString *))modelName{
    return ^YXYRequest *(NSString *modelName){
        self.modelClass = NSClassFromString(modelName);
        return self;
    };
}

@end
