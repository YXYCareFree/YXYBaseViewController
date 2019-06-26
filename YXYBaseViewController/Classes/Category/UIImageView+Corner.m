//
//  UIImageView+Corner.m
//  AFNetworking
//
//  Created by apple on 2018/12/11.
//

#import "UIImageView+Corner.h"
#import <objc/runtime.h>
#import "UIImage+Corner.h"
#import "SDWebImageDownloader.h"

@implementation UIImageView (Corner)

- (void)yxy_setImageWithURL:(NSURL *)url placeHolderImage:(UIImage *)placeHolderImage cornerRadius:(CGFloat)cornerRadius{

    [self setRadiusImage:placeHolderImage radius:cornerRadius];
    if (cornerRadius) self.clipsToBounds = YES;
    SDWebImageDownloader *manager = [SDWebImageDownloader sharedDownloader];
    [manager downloadImageWithURL:url options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (finished) {
            [self setRadiusImage:image radius:cornerRadius];
        }
    }];
}

- (void)setRadiusImage:(UIImage *)image radius:(CGFloat)radius{
    CGSize size = self.frame.size;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *temp = [self cutCircleImageWithImage:image size:size radious:radius];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = temp;
        });
    });
}

- (UIImage *)cutCircleImageWithImage:(UIImage *)image size:(CGSize)size radious:(CGFloat)radious {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);

    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radious].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());

    [image drawInRect:CGRectMake(0, 0, size.width, size.height) withContentMode:UIViewContentModeScaleAspectFill];

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
