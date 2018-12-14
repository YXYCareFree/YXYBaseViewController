//
//  UIImageView+Corner.m
//  AFNetworking
//
//  Created by apple on 2018/12/11.
//

#import "UIImageView+Corner.h"
#import <objc/runtime.h>
#import "UIImage+Corner.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (Corner)

//+ (void)load{
//    Method systemMethod = class_getInstanceMethod(self, @selector(setImage:));
//    Method my_Method = class_getInstanceMethod(self, @selector(yxy_setImage:));
//    method_exchangeImplementations(systemMethod, my_Method);
//}


- (void)yxy_setImageWithURL:(NSURL *)url placeHolderImage:(UIImage *)placeHolderImage cornerRadius:(CGFloat)cornerRadius{
//    self.cornerRadius = cornerRadius;
//    SDWebImageDownloader *manager = [SDWebImageDownloader sharedDownloader];
//    [manager downloadImageWithURL:url options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//        [self performSelector:@selector(setImage:) withObject:image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
//    }];
    [self sd_setImageWithURL:url placeholderImage:placeHolderImage];
}


//- (void)yxy_setImage:(UIImage *)image{
//    UIImage *temp = image;
//    if (self.cornerRadius) {
//        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
//        [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.cornerRadius];
//        [image drawInRect:self.bounds];
//        temp = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//    }
//
//    [self yxy_setImage:temp];
//}

//- (void)setCornerRadius:(CGFloat)radius{

//}


//- (void)setCornerRadius:(CGFloat)cornerRadius{
//    objc_setAssociatedObject(self, "yxy_corner", @(cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (CGFloat)cornerRadius{
//    return [objc_getAssociatedObject(self, "yxy_corner") floatValue];
//}

- (void)setMasksLayer:(CAShapeLayer *)masksLayer{
    objc_setAssociatedObject(self, "yxy_masksLayer", masksLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAShapeLayer *)masksLayer{
    CAShapeLayer *layer = objc_getAssociatedObject(self, "yxy_masksLayer");
    if (!layer) {
        layer = [[CAShapeLayer alloc] init];
//        layer.fillColor = UIColor.grayColor.CGColor;
//        layer.backgroundColor = UIColor.redColor.CGColor;
        objc_setAssociatedObject(self, "yxy_masksLayer", layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return layer;
}

@end
