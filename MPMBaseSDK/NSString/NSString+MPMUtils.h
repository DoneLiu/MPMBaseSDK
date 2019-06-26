//
//  NSString+MPMUtils.h
//  MPMCategorys
//
//  Created by Done.L on 2019/6/26.
//  Copyright © 2019 Done.L. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MPMUtils)

/**
 16进制字符串
 */
- (instancetype)hexString;

/*
 MD5加密
 */
- (instancetype)md5String;

/*
 *  textfield输入，特定需求使用（忽略）
 */
- (NSString *)substringAvoidBreakingUpCharacterSequencesWithRange:(NSRange)range lessValue:(BOOL)lessValue countingNonASCIICharacterAsTwo:(BOOL)countingNonASCIICharacterAsTwo;

/**
 去除空格
 */
+ (NSString *)trimBlankString:(NSString *)str;

/**
 获取随机获取唯一字符串
 */
+ (NSString *)getUniqueString;

/**
 中文转拼音，并获取每个字的首字母
 
 @param string 中文
 @return key:pinyin, value:拼音全拼；key:firstLetter, value:每个字的首字母
 */
+ (NSDictionary *)chineseTurnToPinyinAndFirstLetters:(NSString *)string;

/**
 获取每一个中文汉字，在string中的index
 
 @param string 原始字符串
 */
+ (NSArray *)getChineseStringLocation:(NSString *)string;

/**
 获取每一行显示的字符串
 
 @param string 原始字符串
 @param font 文字font
 @param width 宽度
 */
+ (NSArray *)getLinesArrayOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width;

/**
 属性字符串处理
 
 @param originStr 原始字符串
 @param containStr 处理字符串
 @param attributes 属性
 @param range 范围
 */
+ (NSMutableAttributedString *)withString:(NSString *)originStr contain:(NSString *)containStr attributes:(NSDictionary *)attributes range:(NSRange )range;

/**
 获取字符串字符长度
 */
+ (NSInteger)lengthOfText:(NSString *)text;

/**
 属性名
 
 @param priceSting 价格字段
 @param priceColor 价格字段颜色
 @param priceFont 价格字段字体
 @param symbolColor 符号字段字体
 @param symbolFont 符号字段字体
 @return 实例
 */

+ (NSMutableAttributedString *)configPriceSting:(NSString *)priceSting priceColor:(UIColor *)priceColor priceFont:(UIFont *)priceFont symbolColor:(UIColor *)symbolColor symbolFont:(UIFont *)symbolFont;

/**
 属性名
 
 @param fixSting 固定字段
 @param fixColor 固定字段颜色
 @param fixFont 固定字段字体
 @param priceSting 价格字段
 @param priceColor 价格字段颜色
 @param priceFont 价格字段字体
 @param symbolColor 符号字段字体
 @param symbolFont 符号字段字体
 @return 实例
 */
+ (NSMutableAttributedString *)configFixSting:(NSString *)fixSting fixColor:(UIColor *)fixColor fixFont:(UIFont *)fixFont priceSting:(NSString *)priceSting priceColor:(UIColor *)priceColor priceFont:(UIFont *)priceFont symbolColor:(UIColor *)symbolColor symbolFont:(UIFont *)symbolFont;

@end

NS_ASSUME_NONNULL_END
