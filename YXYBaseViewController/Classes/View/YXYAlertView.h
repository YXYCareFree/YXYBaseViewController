//
//  YXYAlertView.h
//  GanJie
//
//  Created by 杨肖宇 on 2017/9/13.
//  Copyright © 2017年 yxy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertBlock)(BOOL isConfirm);

@interface YXYAlertView : UIView

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * confirmTitle;
@property (nonatomic, strong) NSString * cancelTitle;

@property (nonatomic, copy) AlertBlock block;

/**
 系统样式的弹窗提示，只有确定按钮，默认title为“提示”
 @param message message
 @param vc 从哪个VC上弹窗
 */
+ (void)alertWithMessage:(NSString *)message fromeVC:(UIViewController *)vc;


/**
 系统样式的弹窗提示，只有确定按钮，默认title为“提示”
 @param message message
 @param vc 从哪个VC上弹窗
 @param completion 回调
 */
+ (void)alertWithMessage:(NSString *)message fromeVC:(UIViewController *)vc completion:(AlertBlock)completion;
/**
 系统样式的弹窗提示，只有确定按钮，默认title为“提示”
 @param message message
 @param vc 从哪个VC上弹窗
 @param completion 回调
 */
+ (void)alertWithMessage:(NSString *)message confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle fromeVC:(UIViewController *)vc completion:(AlertBlock)completion;
/**
 系统样式的弹窗提示
 @param title title
 @param message message
 @param vc 从哪个VC上弹窗
 @param completion 回调
 */
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle fromeVC:(UIViewController *)vc completion:(AlertBlock)completion;

/**
 自定义(直接加载到keywindow)
 
 @param msg msg
 @param confirmTitle 右边→_→的按钮文字。默认为“确定”
 @param confirmColor 默认黑色
 @param cancelTitle 👈左边按钮的文字。默认为“取消”
 @param cancelColor 默认黑色
 @param completion 回调
 */
+ (void)customAlertMessage:(NSString *)msg confirmTitle:(NSString *)confirmTitle confirmColor:(UIColor *)confirmColor cancelTitle:(NSString *)cancelTitle cancelColor:(UIColor *)cancelColor completion:(AlertBlock)completion;

@end

