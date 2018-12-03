//
//  YXYTextField.h
//  趣睡
//
//  Created by apple on 2018/9/26.
//  Copyright © 2018年 Yutao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXYTextField : UITextField

/**
 键盘不能遮盖的View
 */
@property (nonatomic, weak) UIView *baseView;

/**
 持有textField的VC
 */
@property (nonatomic, weak) UIViewController *vc;

@end
