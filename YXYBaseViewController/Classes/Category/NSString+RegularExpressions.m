//
//  NSString+RegularExpressions.m
//  RegularExpression
//
//  Created by beyondSoft on 16/5/13.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "NSString+RegularExpressions.h"

@implementation NSString (RegularExpressions)

- (BOOL)isIDCard{

    NSString * idcard1 = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    NSString * idcard2 = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    return [self validateWithRegularExpression:idcard1]||[self validateWithRegularExpression:idcard2];
}

- (BOOL)isChinese{
    NSString * Chinese = @"^[\u4e00-\u9fa5]{0,}$";
    return [self validateWithRegularExpression:Chinese];
}

- (BOOL)testPasswordStrength{
    //密码的强度必须是包含大小写字母和数字的组合，不能使用特殊字符，长度在8-10之间。
    NSString * ps = @"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,10}$";
    return [self validateWithRegularExpression:ps];
}

- (BOOL)isEmail{
    NSString * email = @"^[a-zA-Z0-9]{4,}@[a-z0-9A-Z]{2,}\\.[a-zA-Z]{2,}$";
    return [self validateWithRegularExpression:email];

}
//神鲸使用的正则
- (BOOL)isValidEmail:(NSString *)email
{
    static NSPredicate *predicate = nil;
    if (!predicate) {
        NSString *EmailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", EmailRegex];
    }
    return [predicate evaluateWithObject:email];
}

- (BOOL)isNumber{
    NSString * num = @"^[0-9]+$";
    return [self validateWithRegularExpression:num];
}

- (BOOL)isPhoneNumber{

    NSString * phoneNum = @"^1\\d{10}$";
    return [self validateWithRegularExpression:phoneNum];
    
    //    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    //    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    return [phoneTest evaluateWithObject:self];
}

- (BOOL)isPassword{

    NSString * length = @"^\\w{6,20}$";
    NSString * num = @"^\\w*\\d+\\w*$";
    NSString * lower = @"^\\w*[a-z]\\w*$";
    NSString * upper = @"^\\w*[A-Z]\\w*$";
    
    BOOL leng = [self validateWithRegularExpression:length];
    
    int number = [self validateWithRegularExpression:num]? 1: 0;
    int low = [self validateWithRegularExpression:lower]? 1: 0;
    int up = [self validateWithRegularExpression:upper]? 1: 0;
    
    return  (leng && ((number + low + up) >= 2));
}

- (NSString *)mobileOperator{
    NSString * isChinaMobile = @"^134[0-8]\\d{7}$|^(?:13[5-9]|147|15[0-27-9]|178|1703|1705|1706|18[2-478])\\d{7,8}$"; //移动
    NSString * isChinaUnion = @"^(?:13[0-2]|145|15[56]|176|1704|1707|1708|1709|171|18[56])\\d{7,8}$"; //联通
    NSString * isChinaTelcom = @"^(?:133|153|1700|1701|1702|177|173|18[019])\\d{7,8}$"; // 电信
    if ([self validateWithRegularExpression:isChinaUnion]) {
        return @"联通";
    }
    if ([self validateWithRegularExpression:isChinaMobile]) {
        return @"移动";
    }
    if ([self validateWithRegularExpression:isChinaTelcom]) {
        return @"电信";
    }
    return @"未知";
}

- (BOOL)validateWithRegularExpression:(NSString *)regExp{

    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExp];
    return  [predicate evaluateWithObject:self];
}
@end
