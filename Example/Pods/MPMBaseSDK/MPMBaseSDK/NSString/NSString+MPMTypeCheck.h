//
//  NSString+MPMTypeCheck.h
//  MPMCategorys
//
//  Created by Done.L on 2019/6/26.
//  Copyright © 2019 Done.L. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MPMTypeCheck)

/**
 判断字符串是否为空
 
 @param string 字符串
 @return bool
 */
+ (BOOL)isBlankString:(NSString *)string;

/**
 验证密码合法性，判断是否有非法字符
 
 @param password 密码
 @return bool
 */
+ (BOOL)isValidatePasswrod:(NSString *)password;

/**
 判断A字符串是否包含B字符串
 
 @param parentString A字符串
 @param subString B字符串
 @return bool
 */
+ (BOOL)isContainsString:(NSString *)parentString subString:(NSString *)subString;

/**
 判断字符串是否包含emoji表情
 
 @param string 字符串
 @return bool
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

/**
 判断身份证是否合法
 
 @param value 身份证号码
 @return bool
 */
+ (BOOL)validateIDCardNumber:(NSString *)value;

/**
 判断字符串是否为数字
 
 @param aString 字符串
 @return bool
 */
+ (BOOL)isNumber:(NSString *)aString;

/**
 判断电话是否手机
 
 @param phone 电话号码
 @return bool
 */
+ (BOOL)isPhoneNumber:(NSString *)phone;

/**
 判断电话是否固定电话
 
 @param phone 电话号码
 @return bool
 */
+ (BOOL)isFixedTelephone:(NSString *)phone;

/**
 判断字符串是数字或字母
 
 @param aString 字符串
 @return bool
 */
+ (BOOL)isLetterOrNumber:(NSString *)aString;

/**
 判断是不是浮点型
 
 @param string 字符串
 @return bool
 */
+ (BOOL)isPureFloat:(NSString *)string;

/**
 判断是否为汉字
 
 @param string 字符串
 @return 汉字
 */
+ (BOOL)isValidChinese:(NSString *)string;

/**
 判断是不是支付宝账号
 @param string 字符串
 @return bool
 */
+ (BOOL)isAlipayAccount:(NSString *)string;

/**
 字符串是否包含链接
 @param string 字符串
 @return NSRange
 */
+ (NSRange)rangeOfwwwString:(NSString *)string;

/**
 字符串是否包含中文
 @param string 字符串
 @return bool
 */
+ (BOOL)IsContanChinese:(NSString *)string;

/**
 字符串是否包含空格
 @param string 字符串
 @return bool
 */
+ (BOOL)isContainBlank:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
