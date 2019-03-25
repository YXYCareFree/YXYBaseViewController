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

+ (instancetype)alertWithTitle:(NSString *)title completion:(AlertBlock)completion;

+ (instancetype)alertWithTitle:(NSString *)title confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle completion:(AlertBlock)completion;

/**
 系统样式的弹窗提示，只有确定按钮
 @param title title
 @param vc 从哪个VC上弹窗
 */
+ (void)alertWithTitle:(NSString *)title fromeVC:(UIViewController *)vc;


/**
 系统样式的弹窗提示，只有确定按钮
 @param title title
 @param vc 从哪个VC上弹窗
 @param completion 回调
 */
+ (void)alertWithTitle:(NSString *)title fromeVC:(UIViewController *)vc completion:(AlertBlock)completion;

+ (void)alertWithTitle:(NSString *)title confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle fromeVC:(UIViewController *)vc completion:(AlertBlock)completion;

@end

