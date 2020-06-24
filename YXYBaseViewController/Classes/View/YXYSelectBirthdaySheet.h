//
//  YXYSelectBirthdaySheet.h
//  GanJie
//
//  Created by 杨肖宇 on 2017/9/13.
//  Copyright © 2017年 yxy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BirthdayBlock)(NSString * birthday);

@interface YXYSelectBirthdaySheet : UIView<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, copy) BirthdayBlock block;

/// 初始化时间
@property (nonatomic, strong) NSString *defaultDate;


+ (instancetype)initWithSelectedBirthdayWithYears:(NSArray *)years confirmColor:(UIColor *)confirmColor cancelColor:(UIColor *)cancelColor completion:(BirthdayBlock)completion;


@end
