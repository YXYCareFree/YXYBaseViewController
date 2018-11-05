//
//  YXYNavigationController.h
//  AFNetworking
//
//  Created by apple on 2018/11/5.
//

#import <UIKit/UIKit.h>

@interface YXYNavigationController : UINavigationController

@property (nonatomic, strong) UIButton *btnBack;

- (void)setTabbarTitle:(NSString *)title normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;

@end
