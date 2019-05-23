//
//  HelpClass.m
//  LoginAndRegister
//
//  Created by Mr.yang on 16/11/21.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "HelpClass.h"

@implementation HelpClass

//电话号码判断
+ (BOOL)phone:(NSString *)phoneStr
{
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:phoneStr];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:phoneStr];
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:phoneStr];
    
    if (isMatch1 || isMatch2 || isMatch3)
    {
        return YES;
    }
   
    return NO;
}

//邮箱判断
+ (BOOL)email:(NSString *)emailStr
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL ismatch = [emailTest evaluateWithObject:emailStr];
    
    if (ismatch)
    {
        return YES;
    }
 
    return NO;
}

//身份证验证
+ (BOOL)idCard:(NSString *)idcarStr
{
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *idcarTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL ismatch = [idcarTest evaluateWithObject:idcarStr];
    if (ismatch)
    {
        return YES;
    }
    
    return NO;
}

//纯数字判断
+ (BOOL)number:(NSString *)numberStr
{
    NSString *numberRegex = @"^[0-9]+$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    BOOL ismatch = [numberTest evaluateWithObject:numberStr];
    
    if (ismatch)
    {
        return YES;
    }
    
    return NO;
}
//数字、字母、符号判断
+ (BOOL)numberAndAlphabetAndSymbol:(NSString *)passwordStr
{
    NSString *numberRegex = @"[a-zA-Z0-9]+$|[^a-zA-Z0-9/D]+$";

    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    BOOL ismatch = [numberTest evaluateWithObject:passwordStr];
    
    if (ismatch)
    {
        return YES;
    }
    
    return NO;
}

/**
 *
 *  判断用户输入的密码是否符合规范，符合规范的密码要求：
 *  密码中必须同时包含数字和字母
*/
+(BOOL)judgePassWordLegal:(NSString *)pass
{
    BOOL result = false;

    // 判断长度大于6位后再接着判断是否同时包含数字和字符
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    result = [pred evaluateWithObject:pass];

    return result;
}


/*
 * 以下判断为OC语言对输入框输入时的限制
 * 上面的正则表达式是输入完成后对输入字符的总体格式判断
 * 正则表达式的判断一般用于发请求前对获取到的字符进行最后校验使用
 */

//OC输入框输入时限制输入为数字、字母、符号
+ (BOOL)numberAndAlphabetAndSymbolOfOC:(NSString *)string
{
    NSCharacterSet *cs;
    
    NSString *kAlphaNum = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789._%+-!@#$%^&*()[]{}\\|';/.,:\"?><";
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    
    //按cs分离出数组,数组按@""分离出字符串
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    BOOL ismatch = [string isEqualToString:filtered];
    
    if (ismatch)
    {
        return YES;
    }
    return NO;
}

//OC输入框输入时限制输入为数字
+ (BOOL)numberOfOC:(NSString *)string
{
    NSCharacterSet *cs;
    
    NSString *kAlphaNum = @"0123456789";
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    BOOL ismatch = [string isEqualToString:filtered];
    
    if (ismatch)
    {
        return YES;
    }
    
    return NO;
}

//OC输入框输入时限制输入为中文
+ (BOOL)chineseOfOC:(NSString *)string
{
    return YES;
}




@end
