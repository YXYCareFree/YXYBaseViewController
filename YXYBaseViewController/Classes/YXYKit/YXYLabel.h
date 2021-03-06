//
//  YXYLabel.h
//  Test
//
//  Created by apple on 2018/9/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXYLabel : UILabel

+ (YXYLabel *)labelWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment;


- (YXYLabel *(^)(NSString *title))title;

- (YXYLabel *(^)(UIFont *font))titleFont;

- (YXYLabel *(^)(UIColor *color))color;

- (YXYLabel *(^)(NSTextAlignment alignment))alignment;

@end
