//
//  NetworkManager.h
//  Furniture
//
//  Created by 王小娜 on 2017/3/14.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+ (void)getCurrentNetwork:(void(^)(NSString *status))completion;

@end
