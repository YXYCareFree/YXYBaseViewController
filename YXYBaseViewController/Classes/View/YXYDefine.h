//
//  YXYDefine.h
//  Pods
//
//  Created by apple on 2019/1/5.
//

#ifndef YXYDefine_h
#define YXYDefine_h

#import "Masonry.h"


#define kScreenWidth       [UIScreen mainScreen].bounds.size.width
#define kScreenHeight      [UIScreen mainScreen].bounds.size.height

#define KEY_WINDOW [UIApplication sharedApplication].delegate.window

#define WEAKSELF           typeof(self) __weak weakSelf = self;


#define ColorFromHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

#define Font_PingFang_Medium(x) [UIFont fontWithName:@"PingFangSC-Medium" size:x]
#define Font(x) [UIFont fontWithName:@"PingFangSC-Regular" size:x]


#define iPhoneX  [UIScreen mainScreen].bounds.size.height >= 812
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)


#endif /* YXYDefine_h */
