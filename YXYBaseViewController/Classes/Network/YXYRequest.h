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

NS_ASSUME_NONNULL_BEGIN

@interface YXYRequest : NSObject

@property (nonatomic, strong) NSString * apiName;

@property (nonatomic, strong) NSDictionary * params;

@property (nonatomic, assign) YXYHTTPMethod method;

@property (nonatomic, assign) BOOL isCache;//是否缓存

@end

NS_ASSUME_NONNULL_END
