//
//  NetworkManager.m
//  Furniture
//
//  Created by 王小娜 on 2017/3/14.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworking.h"

@implementation NetworkManager

+ (void)getCurrentNetwork:(void(^)(NSString *status))completion{

    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                if (completion) {
                    completion(@"NoNetwork");
                }
                break;
                
            default:
                if (completion) {
                    completion([NetworkManager getCurrentNetwork]);
                }
                break;
        }
    }];
    [manager startMonitoring];
}

+ (NSString *)getCurrentNetwork{
    NSString *stateString = @"";
    
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    if ([[app valueForKeyPath:@"_statusBar"] isKindOfClass:NSClassFromString(@"UIStatusBar_Modern")]) {
        //适配iPhone X
        NSArray * children = [[[[app valueForKeyPath:@"_statusBar"] valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
        for (UIView *view in children) {
            for (id child in view.subviews) {
                //wifi
                if ([child isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                    stateString = @"wifi";
                }
                //2G 3G 4G
                if ([child isKindOfClass:NSClassFromString(@"_UIStatusBarStringView")]) {
                    if ([[child valueForKey:@"_originalText"] containsString:@"G"]) {
                        stateString = [child valueForKey:@"_originalText"];
                    }
                }
            }
        }
        if (!stateString.length) {
            stateString = @"NoNetwork";
        }
    }else{
        NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
        
        int type = 0;
        for (id child in children) {
            if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
                type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            }
        }
        
        switch (type) {
            case 0:
                stateString = @"NoNetwork";
                break;
                
            case 1:
                stateString = @"2G";
                break;
                
            case 2:
                stateString = @"3G";
                break;
                
            case 3:
                stateString = @"4G";
                break;
                
            case 4:
                stateString = @"LTE";
                break;
                
            case 5:
                stateString = @"wifi";
                break;
                
            default:
                break;
        }
    }
    return stateString;
}
@end
