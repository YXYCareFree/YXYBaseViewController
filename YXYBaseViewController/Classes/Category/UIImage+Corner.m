//
//  UIImage+Corner.m
//  AFNetworking
//
//  Created by apple on 2018/12/11.
//

#import "UIImage+Corner.h"

@implementation UIImage (Corner)

- (UIImage *)drawCircleImage:(CGFloat)cornerRadius{
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(self.size, false, [UIScreen mainScreen].scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [self drawInRect:rect];
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}

- (UIImage *)masksCorner:(CGFloat)cornerRadius{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, self.size.width, self.size.height);
    imageLayer.contents = (id) self.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = cornerRadius;
    
    UIGraphicsBeginImageContext(self.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

@end
