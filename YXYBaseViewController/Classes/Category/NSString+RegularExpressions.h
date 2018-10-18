//
//  NSString+RegularExpressions.h
//  RegularExpression
//
//  Created by beyondSoft on 16/5/13.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegularExpressions)

- (BOOL)isEmail;

- (BOOL)isPassword;

- (BOOL)isNumber;

- (BOOL)isPhoneNumber;

- (BOOL)testPasswordStrength;

- (BOOL)isChinese;

- (BOOL)isIDCard;

- (NSString *)mobileOperator;

@end
