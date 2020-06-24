//
//  YXYPickView.h
//  GanJie
//
//  Created by 杨肖宇 on 2017/10/7.
//  Copyright © 2017年 yxy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectBlock)(NSArray *arr);

/**
 单列的PickView
 */
@interface YXYPickView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, copy) SelectBlock block;

+ (instancetype)initWithDataSource:(NSArray<NSArray *> *)dataSource confirmBtnColor:(UIColor *)confirmColor cancelBtnColor:(UIColor *)cancelColor completion:(SelectBlock)completion;

+ (instancetype)initWithDataSource:(NSArray<NSArray *> *)dataSource title:(NSString *)title confirmBtnColor:(UIColor *)confirmColor cancelBtnColor:(UIColor *)cancelColor completion:(SelectBlock)completion;

@end

