//
//  UIImageView+Corner.h
//  AFNetworking
//
//  Created by apple on 2018/12/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Corner)

- (void)yxy_setImageWithURL:(NSURL *)url placeHolderImage:(UIImage *)placeHolderImage cornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
