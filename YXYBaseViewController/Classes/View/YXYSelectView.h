//
//  YXYSelectView.h
//  GanJie
//
//  Created by 杨肖宇 on 2017/10/7.
//  Copyright © 2017年 yxy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectBlock)(NSString * str, NSInteger idx);

@interface YXYSelectView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, copy) SelectBlock block;

+ (instancetype)initWithDataSource:(NSArray *)dataSource confirmBtnColor:(UIColor *)confirmColor cancelBtnColor:(UIColor *)cancelColor completion:(SelectBlock)completion;

+ (instancetype)initWithDataSource:(NSArray *)dataSource title:(NSString *)title confirmBtnColor:(UIColor *)confirmColor cancelBtnColor:(UIColor *)cancelColor completion:(SelectBlock)completion;

@end

