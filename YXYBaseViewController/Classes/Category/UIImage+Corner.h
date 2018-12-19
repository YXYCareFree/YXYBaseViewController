//
//  UIImage+Corner.h
//  AFNetworking
//
//  Created by apple on 2018/12/11.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Corner)

- (void)drawInRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode;

- (UIImage *)drawCircleImage:(CGFloat)cornerRadius;

- (UIImage *)masksCorner:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
