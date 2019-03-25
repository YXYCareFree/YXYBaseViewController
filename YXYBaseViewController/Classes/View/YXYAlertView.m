//
//  YXYAlertView.m
//  GanJie
//
//  Created by 杨肖宇 on 2017/9/13.
//  Copyright © 2017年 yxy. All rights reserved.
//

#import "YXYAlertView.h"
#import "YXYDefine.h"

#define Width   301
#define Height  121

@implementation YXYAlertView{
    UIButton * _cancelBtn;
    UILabel * _split;
}

+ (void)alertWithTitle:(NSString *)title fromeVC:(UIViewController *)vc{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:confirm];
    [vc presentViewController:alert animated:YES completion:nil];
}

+ (void)alertWithTitle:(NSString *)title fromeVC:(UIViewController *)vc completion:(AlertBlock)completion{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completion(YES);
    }];
    [alert addAction:confirm];
    [vc presentViewController:alert animated:YES completion:nil];
}

+ (void)alertWithTitle:(NSString *)title confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle fromeVC:(UIViewController *)vc completion:(AlertBlock)completion{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completion(YES);
    }];
    [alert addAction:confirm];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completion(NO);
    }];
    [alert addAction:cancel];
    [vc presentViewController:alert animated:YES completion:nil];
}

+ (instancetype)alertWithTitle:(NSString *)title completion:(AlertBlock)completion{
    YXYAlertView * alertView = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds title:title confirmTitle:@"确认" cancelTitle:@"取消" completion:completion];
    return alertView;
}

+ (instancetype)alertWithTitle:(NSString *)title confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle completion:(AlertBlock)completion{
    YXYAlertView * alertView = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds title:title confirmTitle:confirmTitle cancelTitle:cancelTitle completion:completion];
    return alertView;
    
}


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle completion:(AlertBlock)completion{
    if (self = [super initWithFrame:frame]) {
        self.title = title;
        self.block = completion;
        self.cancelTitle = cancelTitle;
        self.confirmTitle = confirmTitle;
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
    UIView * view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self addSubview:view];
    
    UIView * centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    centerView.center = self.center;
    centerView.layer.cornerRadius = 2;
    centerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:centerView];
    
    _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 81, (Width - 1) / 2, 40)];
    [_cancelBtn setTitle:self.cancelTitle forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:ColorFromHex(0x666666) forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:_cancelBtn];
    
    UIButton * confrmBtn = [[UIButton alloc] initWithFrame:CGRectMake((Width - 1) / 2 + 1, 81, (Width - 1) / 2, 40)];
    [confrmBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [confrmBtn setTitle:self.confirmTitle forState:UIControlStateNormal];
    [confrmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:confrmBtn];
    
    _split = [[UILabel alloc] initWithFrame:CGRectMake((Width - 1) / 2, 81, 1, 40)];
    _split.backgroundColor = ColorFromHex(0x999999);
    [centerView addSubview:_split];
    UILabel * split = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, Width, 1)];
    split.backgroundColor = ColorFromHex(0x999999);
    [centerView addSubview:split];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, Width, 40)];
    titleLabel.text = self.title;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = ColorFromHex(0x333333);
    [centerView addSubview:titleLabel];
    
    [KEY_WINDOW addSubview:self];
}

- (void)cancel{
    
    if (self.block) {
        self.block(NO);
    }
    [self removeFromSuperview];
}

- (void)confirm{
    if (self.block) {
        self.block(YES);
    }
    [self removeFromSuperview];
}

- (void)setCancelTitle:(NSString *)cancelTitle{
    _cancelTitle = cancelTitle;
    [_cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
    if ([cancelTitle isEqualToString:@""]) {
        [_cancelBtn removeFromSuperview];
        [_split removeFromSuperview];
    }
}

@end
