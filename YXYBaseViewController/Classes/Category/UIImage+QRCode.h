//
//  UIImage+QRCode.h
//  QRCode
//
//  Created by 杨肖宇 on 2017/10/24.
//  Copyright © 2017年 yxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCode)

/**
 生成带logo的二维码

 @param string 二维码的字符串
 @param Imagesize  二维码大小
 @param waterImagesize  二维码中间logo的大小
 @param logoImage  logo图片
 @return  生成带logo的二维码
 */
+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize logoImage:(UIImage *)image;


/**
 高斯模糊处理

 @param image 需要处理的image
 @param blur 0~1
 @return image
 */
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

@end
