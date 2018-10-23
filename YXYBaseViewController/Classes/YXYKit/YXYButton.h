//
//  YXYButton.h
//  Test
//
//  Created by apple on 2018/9/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXYButton : UIButton

- (YXYButton *(^)(NSString *title, UIControlState state))title;

- (YXYButton *(^)(UIColor *color, UIControlState state))color;

- (YXYButton *(^)(UIFont *font))titleFont;

- (YXYButton *(^)(UIImage *image, UIControlState state))bgImgae;

@end
