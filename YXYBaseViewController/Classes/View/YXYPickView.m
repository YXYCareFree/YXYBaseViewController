//
//  YXYPickView.m
//  GanJie
//
//  Created by 杨肖宇 on 2017/10/7.
//  Copyright © 2017年 yxy. All rights reserved.
//

#import "YXYPickView.h"
#import "YXYDefine.h"

@interface YXYPickView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSMutableArray *selectedArr;
@property (nonatomic, strong) NSArray<NSArray *> *dataSource;
@property (nonatomic, strong) UIColor *colorCancel;
@property (nonatomic, strong) UIColor *colorConfirm;
@property (nonatomic, strong) NSString *title;

@end

@implementation YXYPickView

+ (instancetype)initWithDataSource:(NSArray *)dataSource title:(NSString *)title confirmBtnColor:(UIColor *)confirmColor cancelBtnColor:(UIColor *)cancelColor completion:(SelectBlock)completion{
    YXYPickView * select = [YXYPickView new];
    select.colorCancel = cancelColor;
    select.colorConfirm = confirmColor;
    select.block = completion;
    select.dataSource = dataSource;
    select.title = title;
    [select setupView];
    return select;
}

+ (instancetype)initWithDataSource:(NSArray *)dataSource confirmBtnColor:(UIColor *)confirmColor cancelBtnColor:(UIColor *)cancelColor completion:(SelectBlock)completion{
    YXYPickView * select = [YXYPickView new];
    select.colorCancel = cancelColor;
    select.colorConfirm = confirmColor;
    select.block = completion;
    select.dataSource = dataSource;
    [select setupView];
    return select;
}

- (void)setupView{
    [[UIApplication sharedApplication].delegate.window endEditing:YES];
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    
    self.selectedArr = NSMutableArray.new;
    for (int i = 0; i < self.dataSource.count; i++) {
        NSArray *arr = self.dataSource[i];
        [self.selectedArr addObject:arr[0]];
    }
    
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
    
    [KEY_WINDOW addSubview:self];
    
    [UIView animateWithDuration:.3 animations:^{
        contentView.frame = CGRectMake(0, kScreenHeight - 240, kScreenWidth, 240);
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dataSource.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataSource[component].count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _dataSource[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.selectedArr replaceObjectAtIndex:component withObject:self.dataSource[component][row]];
}

- (void)cancel{
    [self dismiss];
}

- (void)confirm{
    if (self.block) {
        self.block(self.selectedArr);
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
