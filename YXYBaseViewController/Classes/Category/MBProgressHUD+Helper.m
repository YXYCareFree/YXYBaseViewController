//
//  MBProgressHUD+Helper.m
//  AFNetworking
//
//  Created by apple on 2018/11/6.
//

#import "MBProgressHUD+Helper.h"
#define KEY_WINDOW [UIApplication sharedApplication].delegate.window

@implementation MBProgressHUD (Helper)

+ (void)showText:(NSString *)text{
    [MBProgressHUD showText:text afterDelay:3];
}

+ (void)showText:(NSString *)text afterDelay:(NSInteger)delay{
    MBProgressHUD *current = [MBProgressHUD HUDForView:KEY_WINDOW];
    [current hideAnimated:YES afterDelay:0];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:KEY_WINDOW animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:delay];
}

+ (instancetype)showLoadingWithText:(NSString *)text{
    MBProgressHUD *current = [MBProgressHUD HUDForView:KEY_WINDOW];
    [current hideAnimated:YES afterDelay:0];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:KEY_WINDOW animated:YES];
    hud.label.text = text;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (instancetype)showLoading{
    MBProgressHUD *current = [MBProgressHUD HUDForView:KEY_WINDOW];
    [current hideAnimated:YES afterDelay:0];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:KEY_WINDOW animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}
@end
