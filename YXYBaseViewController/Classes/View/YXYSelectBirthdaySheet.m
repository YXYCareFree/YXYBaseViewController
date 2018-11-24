//
//  YXYSelectBirthdaySheet.m
//  GanJie
//
//  Created by 杨肖宇 on 2017/9/13.
//  Copyright © 2017年 yxy. All rights reserved.
//

#import "YXYSelectBirthdaySheet.h"
#import "Masonry.h"

#define kScreenWidth       [UIScreen mainScreen].bounds.size.width
#define kScreenHeight      [UIScreen mainScreen].bounds.size.height

@implementation YXYSelectBirthdaySheet{
    NSMutableArray *_yearsArr;
    NSMutableArray *_monthsArr;
    NSMutableArray *_daysArr;
    UIView *_contentView;
    NSString *_birthday;
    NSString *_year;
    NSString *_month;
    NSString *_day;
    UIColor *_colorConfirm;
    UIColor *_colorCancel;
}

+ (instancetype)initWithSelectedBirthdayConfirmColor:(UIColor *)confirmColor cancelColor:(UIColor *)cancelColor completion:(BirthdayBlock)completion{
    YXYSelectBirthdaySheet *view = [[YXYSelectBirthdaySheet alloc] initWithFrame:[UIScreen mainScreen].bounds confirmColor:confirmColor cancelColor:cancelColor completion:completion];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame confirmColor:(UIColor *)confirmColor cancelColor:(UIColor *)cancelColor completion:(BirthdayBlock)completion{
    if (self = [super initWithFrame:frame]) {
        self.block = completion;
        _colorConfirm = confirmColor;
        _colorCancel = cancelColor;
        [self setDataSource];
        [self setupView];
    }
    return self;
}

- (void)setDataSource{
   
    _yearsArr = [NSMutableArray new];
    _monthsArr = [NSMutableArray new];
    _daysArr = [NSMutableArray new];
    
    for (int i = 1950; i < 2018; i++) {
        [_yearsArr addObject:[NSString stringWithFormat:@"%d", i]];
    }
    for (int i = 1; i < 13; i++) {
        [_monthsArr addObject:[NSString stringWithFormat:@"%d", i]];
    }
    for (int i = 1; i < 32; i++) {
        [_daysArr addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    _year = _yearsArr[0];
    _month = _monthsArr[0];
    _day = _daysArr[0];
    _birthday = [NSString stringWithFormat:@"%@-%@-%@", _year, [self handle:_month], [self handle:_day]];
}

- (void)setupView{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
    
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 200)];
    contentView.backgroundColor = [UIColor whiteColor];
    _contentView = contentView;
    [self addSubview:contentView];
    
    UIPickerView * pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, 160)];
    pickView.delegate = self;
    pickView.dataSource = self;
    [contentView addSubview:pickView];
    
    UIButton * cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 0, 50, 40)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:_colorCancel forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelBtn];
    
    UIButton * confrmBtn = [[UIButton alloc] init];
    [confrmBtn setTitleColor:_colorConfirm forState:UIControlStateNormal];
    [confrmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confrmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:confrmBtn];
    [confrmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-30));
        make.top.equalTo(@0);
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:.3 animations:^{
        contentView.frame = CGRectMake(0, kScreenHeight - 200, kScreenWidth, 200);
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _yearsArr.count;
    }
    if (component == 1) {
        return _monthsArr.count;
    }
    if (component == 2) {
        int month = [_month intValue];
        switch (month) {
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12: return 31; break;
                
            case 4:
            case 6:
            case 9:
            case 11:         if ([_day intValue] > 30) {
                _day = @"30";
                _birthday = [NSString stringWithFormat:@"%@-%@-%@", _year, [self handle:_month], [self handle:_day]];
            } return 30; break;
           
            case 2:{
                int year = [_year intValue];
                if ((year % 4 == 0 && year % 100 != 0)||(year %400 == 0)) {
                    if ([_day intValue] > 29) {
                        _day = @"29";
                        _birthday = [NSString stringWithFormat:@"%@-%@-%@", _year, [self handle:_month], [self handle:_day]];
                    }
                    return 29; break;
                }else{
                    if ([_day intValue] > 28) {
                        _day = @"28";
                        _birthday = [NSString stringWithFormat:@"%@-%@-%@", _year, [self handle:_month], [self handle:_day]];
                    }
                    return 28; break;
                }
            }
            default:
                break;
        }
    }

    return 30;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return _yearsArr[row];
            break;
        case 1:
            return _monthsArr[row];
            break;
        case 2:
            return _daysArr[row];
            break;
        default:
            break;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:
            _year = _yearsArr[row];
            break;
        case 1:
            _month = _monthsArr[row];
            break;
        case 2:
            _day = _daysArr[row];
            break;
            
        default:
            break;
    }

    _birthday = [NSString stringWithFormat:@"%@-%@-%@", _year, [self handle:_month], [self handle:_day]];
    [pickerView reloadAllComponents];
}

- (NSString *)handle:(NSString *)str{
    if (str.length > 1) {
        return str;
    }
    return [NSString stringWithFormat:@"0%@", str];
}

- (void)cancel{
    [self dismiss];
}

- (void)confirm{
    if (self.block && _birthday) {
        self.block(_birthday);
    }
    [self dismiss];
}

- (void)dismiss{
    [UIView animateWithDuration:.3 animations:^{
        _contentView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 200);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
