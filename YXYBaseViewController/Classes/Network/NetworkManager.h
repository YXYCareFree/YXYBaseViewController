//
//  NetworkManager.h
//  Furniture
//
//  Created by 王小娜 on 2017/3/14.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTCellularData.h>

@interface NetworkManager : NSObject

+ (void)getCurrentNetworkType:(void(^)(NSString *status))completion;

//获取App是否被禁止使用蜂窝数据
+ (void)getCellularDataRestrictedState:(void(^)(CTCellularDataRestrictedState state))completion API_AVAILABLE(ios(9.0));

@end
