//
//  UIViewController+Extension.m
//  Furniture
//
//  Created by 王小娜 on 2017/1/20.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "UIViewController+Extension.h"
#import <objc/runtime.h>

@implementation UIViewController (Extension)

//适用范围，tabbar的子视图都是NavigationController，其它情况可以根据情况调整
+ (UIViewController *)getCurrentViewController{
    
    UIViewController * result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app的windowLevel是UIWindowLevelNormal，如果不是，找到是UIWindowLevelNormal的Window
    if (window.windowLevel != UIWindowLevelNormal) {
        
        NSArray * windows = [[UIApplication sharedApplication] windows];
        for (UIWindow * tempWindow in windows) {
            
            if (tempWindow.windowLevel == UIWindowLevelNormal) {
                window = tempWindow;
                break;
            }
        }
    }
    id nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    nextResponder = appRootVC;
    //如果是present上来的vc，则appRootVC.presentedViewController不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.selectedViewController;
        result = nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}

- (void)setUIInterfaceOrientationPortrait{
    [self orientationToPortrait:UIInterfaceOrientationPortrait];
}

- (void)setUIInterfaceOrientationLandscapeLeft{
    [self orientationToPortrait:UIInterfaceOrientationLandscapeLeft];
}
// 当回到原来的视图时, 如果希望这个视图还是竖屏, 可强制旋转一下
//强制旋转屏幕
- (void)orientationToPortrait:(UIInterfaceOrientation)orientation {
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    NSInteger val = orientation;
    [invocation setArgument:&val atIndex:2];//前两个参数已被target和selector占用
    [invocation invoke];
}
@end
