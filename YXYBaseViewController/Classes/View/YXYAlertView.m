//
//  YXYAlertView.m
//  GanJie
//
//  Created by 杨肖宇 on 2017/9/13.
//  Copyright © 2017年 yxy. All rights reserved.
//

#import "YXYAlertView.h"
#import "YXYDefine.h"
#import "YXYLabel.h"
#import "YXYButton.h"

#define Width   301
#define Height  121

@interface YXYAlertView ()

@property (nonatomic, strong) YXYLabel *lblTitle;
@property (nonatomic, strong) YXYButton *btnConfirm;
@property (nonatomic, strong) YXYButton *btnCancel;

@end

@implementation YXYAlertView{
    UIButton * _cancelBtn;
    UILabel * _split;
}

+ (void)alertWithMessage:(NSString *)message fromeVC:(UIViewController *)vc{
    [YXYAlertView alertWithTitle:nil message:message confirmTitle:nil cancelTitle:nil fromeVC:vc completion:nil];
}

+ (void)alertWithMessage:(NSString *)message fromeVC:(UIViewController *)vc completion:(AlertBlock)completion{
    [YXYAlertView alertWithTitle:nil message:message confirmTitle:nil cancelTitle:nil fromeVC:vc completion:completion];
}

+ (void)alertWithMessage:(NSString *)message confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle fromeVC:(UIViewController *)vc completion:(AlertBlock)completion{
    [YXYAlertView alertWithTitle:nil message:message confirmTitle:confirmTitle cancelTitle:cancelTitle fromeVC:vc completion:completion];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle fromeVC:(UIViewController *)vc completion:(AlertBlock)completion{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title?:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:confirmTitle?:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (completion) {
            completion(YES);
        }
    }];
    [alert addAction:confirm];
    
    if (cancelTitle) {
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (completion) {
                completion(NO);
            }
        }];
        [alert addAction:cancel];
    }
    if ([vc isKindOfClass:[UIViewController class]]) {
        [vc presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark Custom
+ (void)customAlertMessage:(NSString *)msg confirmTitle:(NSString *)confirmTitle confirmColor:(UIColor *)confirmColor cancelTitle:(NSString *)cancelTitle cancelColor:(UIColor *)cancelColor completion:(AlertBlock)completion{
    YXYAlertView *alert = [[YXYAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alert.block = completion;
    alert.lblTitle.title(msg).color(ColorFromHex(0x4d4d4d)).titleFont(Font_PingFang_Medium(18));
    alert.btnConfirm.titleFont(Font(18)).color(confirmColor, UIControlStateNormal).title(confirmTitle, UIControlStateNormal);
    alert.btnCancel.titleFont(Font(18)).color(cancelColor, UIControlStateNormal).title(cancelTitle, UIControlStateNormal);
    [alert setUI];
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
}

- (void)setUI{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    UIView *vBg = [[UIView alloc] init];
    vBg.backgroundColor = UIColor.whiteColor;
    vBg.layer.cornerRadius = 5;
    vBg.clipsToBounds = YES;
    [self addSubview:vBg];
    [vBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.equalTo(@47);
        make.right.equalTo(@(-47));
    }];
    
    [vBg addSubview:self.lblTitle];
    [vBg addSubview:self.btnConfirm];
    [vBg addSubview:self.btnCancel];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(@20);
        make.right.equalTo(@(-20));
    }];
    
    UIView *vH = [[UIView alloc] init];
    vH.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    [vBg addSubview:vH];
    [vH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblTitle.mas_bottom).offset(20);
        make.height.equalTo(@1);
        make.left.right.equalTo(@0);
    }];
    
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    [vBg addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vH.mas_bottom);
        make.centerX.equalTo(vH);
        make.bottom.equalTo(vBg);
        make.width.equalTo(@1);
    }];
    
    [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vH.mas_bottom).offset(0);
        make.centerX.equalTo(vBg).offset(-(kScreenWidth - 47 * 2) / 4);
        make.height.equalTo(@48);
        make.left.bottom.equalTo(@0);
        make.width.equalTo(@(kScreenWidth / 2 - 47));
    }];
    
    [self.btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vH.mas_bottom).offset(0);
        make.centerX.equalTo(vBg).offset((kScreenWidth - 47 * 2) / 4);
        make.height.equalTo(@48);
        make.right.bottom.equalTo(@0);
        make.width.equalTo(@(kScreenWidth / 2 - 48));
    }];
}

- (void)btnCancelClicked{
    if (self.block) {
        self.block(NO);
    }
    [self removeFromSuperview];
}

- (void)btnConfirmClicked{
    if (self.block) {
        self.block(YES);
    }
    [self removeFromSuperview];
}

- (YXYLabel *)lblTitle{
    if (!_lblTitle) {
        _lblTitle = [[YXYLabel alloc] init];
        _lblTitle.numberOfLines = 0;
        _lblTitle.alignment(NSTextAlignmentCenter);
    }
    return _lblTitle;
}

- (YXYButton *)btnCancel{
    if (!_btnCancel) {
        _btnCancel = [[YXYButton alloc] init];
        [_btnCancel addTarget:self action:@selector(btnCancelClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCancel;
}

- (YXYButton *)btnConfirm{
    if (!_btnConfirm) {
        _btnConfirm = [[YXYButton alloc] init];
        [_btnConfirm addTarget:self action:@selector(btnConfirmClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnConfirm;
}
@end
