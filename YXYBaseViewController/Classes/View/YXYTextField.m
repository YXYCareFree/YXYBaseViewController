//
//  YXYTextField.m
//  趣睡
//
//  Created by apple on 2018/9/26.
//  Copyright © 2018年 Yutao. All rights reserved.
//

#import "YXYTextField.h"

@interface YXYTextField ()

@property (nonatomic, assign) BOOL changeFrame;

@end

@implementation YXYTextField

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addNotifi];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        [self addNotifi];
    }
    return self;
}

- (void)addNotifi{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notifi{
    //取出键盘最终的frame
    CGRect rect = [notifi.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //取出键盘弹出需要花费的时间
    double duration = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (self.baseView) {
        CGRect frame = [self.baseView convertRect:self.baseView.bounds toView:[UIApplication sharedApplication].delegate.window];
        CGFloat y = rect.origin.y - frame.origin.y - frame.size.height - 5;
        if (y < 0) {
            self.changeFrame = YES;
            [UIView animateWithDuration:duration animations:^{
                self.vc.view.frame = CGRectMake(0, y, self.vc.view.bounds.size.width, self.vc.view.bounds.size.height);
            }];
        }
    }else{
        CGRect frame = [self convertRect:self.bounds toView:[UIApplication sharedApplication].delegate.window];
        CGFloat y = rect.origin.y - frame.origin.y - frame.size.height - 5;
        if (y < 0) {
            self.changeFrame = YES;
            [UIView animateWithDuration:duration animations:^{
                self.vc.view.frame = CGRectMake(0, y, self.vc.view.bounds.size.width, self.vc.view.bounds.size.height);
            }];
        }
    }
}

- (void)keyboardWillHide:(NSNotification *)notifi{
    //取出键盘弹出需要花费的时间
    double duration = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (self.changeFrame) {
        [UIView animateWithDuration:duration animations:^{
            self.vc.view.frame = CGRectMake(0, 0, self.vc.view.bounds.size.width, self.vc.view.bounds.size.height);
        }];
        self.changeFrame = NO;
    }

}
@end
