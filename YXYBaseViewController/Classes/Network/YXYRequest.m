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

@end
