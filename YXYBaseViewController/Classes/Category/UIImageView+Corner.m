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

- (void)yxy_setImageWithURL:(NSURL *)url placeHolderImage:(UIImage *)placeHolderImage cornerRadius:(CGFloat)cornerRadius{
//    self.image = placeHolderImage;
    if (cornerRadius) self.clipsToBounds = YES;
    SDWebImageDownloader *manager = [SDWebImageDownloader sharedDownloader];
    [manager downloadImageWithURL:url options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (finished) {
            CGSize size = self.frame.size;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage *temp = [self cutCircleImageWithImage:image size:size radious:cornerRadius];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = temp;
                });
            });
        }

//        [self performSelector:@selector(setImage:) withObject:image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
    }];
    
    
//    [self sd_setImageWithURL:url placeholderImage:placeHolderImage];
//    __weak UIImageView *weakS = self;
//    [self sd_setImageWithURL:url placeholderImage:placeHolderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        CGSize size = weakS.frame.size;
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            UIImage *temp = [weakS cutCircleImageWithImage:image size:size radious:cornerRadius];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                weakS.image = temp;
//            });
//        });
//    }];
}

- (UIImage *)cutCircleImageWithImage:(UIImage *)image size:(CGSize)size radious:(CGFloat)radious {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);

    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radious].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());

    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//- (void)addMaskLayerRect:(CGRect)rect radius:(CGFloat)radius{
//    CAShapeLayer *maskLayer = self.layer.mask;
//    if (!maskLayer) {
//        maskLayer = [CAShapeLayer layer];
//        maskLayer.fillColor = UIColor.clearColor.CGColor;
//    }
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
//    maskLayer.path = maskPath.CGPath;
//    maskLayer.frame = rect;
//    self.layer.mask = maskLayer;
//}
@end
