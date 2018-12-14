//
//  UIImageView+Corner.h
//  AFNetworking
//
//  Created by apple on 2018/12/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Corner)

@property (nonatomic, strong) CAShapeLayer *masksLayer;

//@property (nonatomic, assign) CGFloat cornerRadius;

//- (void)setCornerRadius:(CGFloat)radius;

- (void)yxy_setImageWithURL:(NSURL *)url placeHolderImage:(UIImage *)placeHolderImage cornerRadius:(CGFloat)cornerRadius;

- (void)addMaskLayerCornerRadius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
