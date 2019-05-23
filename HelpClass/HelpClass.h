//
//  HelpClass.h
//  LoginAndRegister
//
//  Created by Mr.yang on 16/11/21.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HelpClass : NSObject

//手机号码验证
+ (BOOL)phone:(NSString *)phoneStr;
//邮箱验证
+ (BOOL)email:(NSString *)emailStr;
//身份证验证
+ (BOOL)idCard:(NSString *)idcarStr;
//纯数字判断
+ (BOOL)number:(NSString *)numberStr;
//数字、字母、符号判断
+ (BOOL)numberAndAlphabetAndSymbol:(NSString *)numberStr;

//判断是否同时包含字母和数字
+(BOOL)judgePassWordLegal:(NSString *)pass;

/*
 * 以下判断为OC语言对输入框输入时的限制
 * 上面的正则表达式是输入完成后对输入字符的总体格式判断
 * 正则表达式的判断一般用于发请求前对获取到的字符进行最后校验使用
 */

//OC输入框输入时限制输入为数字、字母、符号(用于输入时判断限制输入框使用)
+ (BOOL)numberAndAlphabetAndSymbolOfOC:(NSString *)string;

//OC输入框输入时限制输入为数字
+ (BOOL)numberOfOC:(NSString *)string;


@end
