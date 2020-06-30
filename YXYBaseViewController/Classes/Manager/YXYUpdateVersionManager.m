//
//  YXYUpdateVersionManager.m
//  AFNetworking
//
//  Created by yxy on 2020/6/24.
//

#import "YXYUpdateVersionManager.h"
#import <AFNetworking.h>
#import "YXYAlertView.h"
#import "YXYDefine.h"

@implementation YXYUpdateVersionManager

+ (void)checkVersion:(NSString *)appId{
    //查看本地版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = infoDic[@"CFBundleShortVersionString"];    
    //查看App Store上面版本号
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/javascript",nil];
    NSString *appstoreAddress = [@"https://itunes.apple.com/cn/lookup?id=" stringByAppendingString:appId];
    [manager POST:appstoreAddress parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = responseObject[@"results"];
        NSDictionary *dic = array[0];
        NSString *appStoreVersion = dic[@"version"];
        
        //本地版本号与App Store版本号不一致，要求更新版本
        NSArray * currentVersionArr = [currentVersion componentsSeparatedByString:@"."];
        NSArray * appStoreVersionArr = [appStoreVersion componentsSeparatedByString:@"."];
        for (NSInteger i = 0; i < currentVersionArr.count; i++) {
            if ([appStoreVersionArr[i] integerValue] > [currentVersionArr[i] integerValue]) {
                [YXYAlertView alertWithMessage:@"检测到新版本请更新" confirmTitle:@"确认" cancelTitle:@"取消" fromeVC:KEY_WINDOW.rootViewController completion:^(BOOL isConfirm) {
                    if (isConfirm) {
                        NSURL *url = [NSURL URLWithString:[@"https://apps.apple.com/cn/app/id" stringByAppendingString:appId]];
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }];
                return ;
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
