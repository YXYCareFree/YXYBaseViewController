//
//  YXYSelectView.m
//  GanJie
//
//  Created by 杨肖宇 on 2017/10/7.
//  Copyright © 2017年 yxy. All rights reserved.
//

#import "YXYSelectView.h"
#import "Masonry.h"

#define kScreenWidth       [UIScreen mainScreen].bounds.size.width
#define kScreenHeight      [UIScreen mainScreen].bounds.size.height

@interface YXYSelectView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSString *selectedStr;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, assign) NSInteger selectedRow;
@property (nonatomic, strong) UIColor *colorCancel;
@property (nonatomic, strong) UIColor *colorConfirm;
@property (nonatomic, strong) NSString *title;

@end

@implementation YXYSelectView

+ (instancetype)initWithDataSource:(NSArray *)dataSource title:(NSString *)title confirmBtnColor:(UIColor *)confirmColor cancelBtnColor:(UIColor *)cancelColor completion:(SelectBlock)completion{
    YXYSelectView * select = [YXYSelectView new];
    select.colorCancel = cancelColor;
    select.colorConfirm = confirmColor;
    select.block = completion;
    select.dataSource = dataSource;
    select.title = title;
    [select setupView];
    return select;
}

+ (instancetype)initWithDataSource:(NSArray *)dataSource confirmBtnColor:(UIColor *)confirmColor cancelBtnColor:(UIColor *)cancelColor completion:(SelectBlock)completion{
    YXYSelectView * select = [YXYSelectView new];
    select.colorCancel = cancelColor;
    select.colorConfirm = confirmColor;
    select.block = completion;
    select.dataSource = dataSource;
    [select setupView];
    return select;
}

- (void)setupView{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];

    _selectedStr = _dataSource[0];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
    
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 240)];
    contentView.backgroundColor = [UIColor whiteColor];
    _contentView = contentView;
    [self addSubview:contentView];

    UIPickerView * pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, 200)];
    pickView.delegate = self;
    pickView.dataSource = self;
    [contentView addSubview:pickView];
    
    UIButton * cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 0, 50, 40)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:self.colorCancel forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelBtn];
    
    UIButton * confrmBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 60, 0, 50, 40)];
    [confrmBtn setTitleColor:_colorConfirm forState:UIControlStateNormal];
    [confrmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confrmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:confrmBtn];
    [confrmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-30));
        make.top.equalTo(@0);
    }];
    
    if (self.title) {
        UILabel *lbl = [[UILabel alloc] init];
        lbl.text = self.title;
        lbl.font = [UIFont systemFontOfSize:18];
        [contentView addSubview:lbl];
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(confrmBtn);
            make.centerX.equalTo(contentView);
        }];
    }
    
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([subView isKindOfClass:[self class]]) {
            return;
        }
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:.3 animations:^{
        contentView.frame = CGRectMake(0, kScreenHeight - 240, kScreenWidth, 240);
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _dataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectedStr = _dataSource[row];
    _selectedRow = row;
}

- (void)cancel{
    [self dismiss];
}

- (void)confirm{
    if (self.block && _selectedStr) {
        self.block(_selectedStr, _selectedRow);
    }
    [self dismiss];
}

- (void)dismiss{
    [UIView animateWithDuration:.3 animations:^{
        self.contentView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 240);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
