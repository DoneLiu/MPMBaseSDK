//
//  NSString+MPMUtils.m
//  MPMCategorys
//
//  Created by Done.L on 2019/6/26.
//  Copyright © 2019 Done.L. All rights reserved.
//

#import "NSString+MPMUtils.h"

#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"
#import <CoreText/CoreText.h>
#import <YYText.h>

#import "NSString+MPMTypeCheck.h"

@implementation NSString (MPMUtils)

/**
 16进制字符串
 */
- (instancetype)hexString {
    if ([self class] == [NSNull class]) {
        return nil;
    }
    
    NSData *myD = [self dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    NSString *hexStr = @"";
    for (int i = 0;i < [myD length]; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if ([newHexStr length] == 1) {
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }  else {
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    return hexStr;
}

/*
 MD5加密
 */
- (instancetype)md5String {
    if ([NSString isBlankString:self]) {
        return @"";//防止crash
    }
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)substringAvoidBreakingUpCharacterSequencesWithRange:(NSRange)range lessValue:(BOOL)lessValue countingNonASCIICharacterAsTwo:(BOOL)countingNonASCIICharacterAsTwo {
    range = countingNonASCIICharacterAsTwo ? [self transformRangeToDefaultModeWithRange:range] : range;
    NSRange characterSequencesRange = lessValue ? [self downRoundRangeOfComposedCharacterSequencesForRange:range] : [self rangeOfComposedCharacterSequencesForRange:range];
    NSString *resultString = [self substringWithRange:characterSequencesRange];
    return resultString;
}

- (NSString *)substringAvoidBreakingUpCharacterSequencesWithRange:(NSRange)range {
    return [self substringAvoidBreakingUpCharacterSequencesWithRange:range lessValue:YES countingNonASCIICharacterAsTwo:NO];
}

- (NSRange)downRoundRangeOfComposedCharacterSequencesForRange:(NSRange)range {
    if (range.length == 0) {
        return range;
    }
    
    NSRange resultRange = [self rangeOfComposedCharacterSequencesForRange:range];
    if (NSMaxRange(resultRange) > NSMaxRange(range)) {
        return [self downRoundRangeOfComposedCharacterSequencesForRange:NSMakeRange(range.location, range.length - 1)];
    }
    return resultRange;
}

- (NSRange)transformRangeToDefaultModeWithRange:(NSRange)range {
    CGFloat strlength = 0.f;
    NSRange resultRange = NSMakeRange(NSNotFound, 0);
    NSUInteger i = 0;
    for (i = 0; i < self.length; i++) {
        unichar character = [self characterAtIndex:i];
        if (isascii(character)) {
            strlength += 1;
        } else {
            strlength += 2;
        }
        if (strlength >= range.location + 1) {
            if (resultRange.location == NSNotFound) {
                resultRange.location = i;
            }
            
            if (range.length > 0 && strlength >= NSMaxRange(range)) {
                resultRange.length = i - resultRange.location + (strlength == NSMaxRange(range) ? 1 : 0);
                return resultRange;
            }
        }
    }
    return resultRange;
}

/**
 去除空格
 */
+ (NSString *)trimBlankString:(NSString *)str {
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/**
 获取随机获取唯一字符串
 */
+ (NSString *)getUniqueString {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    
    CFRelease(uuidRef);
    
    NSString *uniqueId = (__bridge NSString *)(uuidStringRef);
    
    CFRelease(uuidStringRef);
    
    return uniqueId;
}

/**
 中文转拼音，并获取每个字的首字母
 
 @param string 中文
 @return key:pinyin, value:拼音全拼；key:firstLetter, value:每个字的首字母
 */
+ (NSDictionary *)chineseTurnToPinyinAndFirstLetters:(NSString *)string {
    string = [NSString getAStringOfChineseCharacters:string];
    if ([NSString isBlankString:string]) {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"", @"pinyin", @"", @"firstLetters", nil];
    }
    
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:string];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinyin = [str capitalizedString];
    
    NSString *firstLetters = @"";
    for (NSInteger i = 0; i< pinyin.length; i++) {
        unichar _c = [pinyin characterAtIndex:i];
        // 找出所有的大写字母
        if(_c <= 'Z' && _c >='A') {
            firstLetters = [firstLetters stringByAppendingFormat:@"%C",_c];
        }
    }
    pinyin = [pinyin uppercaseString];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:pinyin, @"pinyin", firstLetters, @"firstLetters", nil];
    
    return dict;
}

/**
 获取字符串中的中文
 
 @param string 原始字符串
 */
+ (NSString *)getAStringOfChineseCharacters:(NSString *)string {
    if ([NSString isBlankString:string]){
        return @"";
    }
    
    NSString *resultString = @"";
    
    for (int i = 0; i< [string length]; i++) {
        int a = [string characterAtIndex:i];
        if (a < 0x9fff && a > 0x4e00){
            resultString = [resultString stringByAppendingString:[string substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    
    return resultString;
}

+ (NSArray *)getChineseStringLocation:(NSString *)string {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if ([NSString isBlankString:string]){
        return array;
    }
    for (int i = 0; i< [string length]; i++) {
        int a = [string characterAtIndex:i];
        if (a < 0x9fff && a > 0x4e00){
            [array addObject:@(i)];
        }
    }
    
    return array;
}

/**
 获取每一行显示的字符串
 
 @param string 原始字符串
 @param font 文字font
 @param width 宽度
 */
+ (NSArray *)getLinesArrayOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width {
    CTFontRef myFont = CTFontCreateWithName((CFStringRef)font.fontName,
                                            font.pointSize,
                                            NULL);
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines){
        CTLineRef lineRef = (__bridge CTLineRef)line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [string substringWithRange:range];
        [linesArray addObject:lineString];
    }
    
    CFRelease(myFont);
    CFRelease(frameSetter);
    CFRelease(frame);
    CGPathRelease(path);
    
    return (NSArray *)linesArray;
}

/**
 属性字符串处理
 
 @param originStr 原始字符串
 @param containStr 处理字符串
 @param attributes 属性
 @param range 范围
 */
+ (NSMutableAttributedString *)withString:(NSString *)originStr contain:(NSString *)containStr attributes:(NSDictionary *)attributes range:(NSRange )range {
    
    if ([NSString isBlankString:originStr]) {
        return nil;
    }
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:originStr];
    if ([originStr containsString:containStr]) {
        [attr addAttributes:attributes range:range];
    }
    
    if (containStr == nil) {
        [attr addAttributes:attributes range:range];
    }
    
    return attr;
}

/**
 获取字符串字符长度
 */
+ (NSInteger)lengthOfText:(NSString *)text {
    NSUInteger asciiLength = 0;
    
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    
    NSUInteger unicodeLength = asciiLength;
    
    return unicodeLength;
}

+ (NSMutableAttributedString *)configPriceSting:(NSString *)priceSting priceColor:(UIColor *)priceColor priceFont:(UIFont *)priceFont symbolColor:(UIColor *)symbolColor symbolFont:(UIFont *)symbolFont {
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:priceSting];
    
    // 价格部分
    if ([NSString isBlankString:priceSting]) {
        return nil;
    }
    
    [attr yy_setColor:priceColor range:NSMakeRange(0, priceSting.length)];
    [attr yy_setFont:priceFont range:NSMakeRange(0, priceSting.length)];
    
    // 如果包含¥
    if ([NSString isContainsString:priceSting subString:@"¥"]) {
        [attr yy_setColor:symbolColor range:[priceSting rangeOfString:@"¥"]];
        [attr yy_setFont:symbolFont range:[priceSting rangeOfString:@"¥"]];
    }
    
    return attr;
}

+ (NSMutableAttributedString *)configFixSting:(NSString *)fixSting fixColor:(UIColor *)fixColor fixFont:(UIFont *)fixFont priceSting:(NSString *)priceSting priceColor:(UIColor *)priceColor priceFont:(UIFont *)priceFont symbolColor:(UIColor *)symbolColor symbolFont:(UIFont *)symbolFont {
    
    NSString *origiString = [NSString stringWithFormat:@"%@%@", fixSting, priceSting];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:origiString];
    
    // 固定的部分
    [attr yy_setColor:fixColor range:[origiString rangeOfString:fixSting]];
    [attr yy_setFont:fixFont range:[origiString rangeOfString:fixSting]];
    
    // 价格部分
    if ([NSString isBlankString:priceSting]) {
        return nil;
    }
    [attr yy_setColor:priceColor range:[origiString rangeOfString:priceSting]];
    [attr yy_setFont:priceFont range:[origiString rangeOfString:priceSting]];
    
    // 如果包含¥
    if ([NSString isContainsString:origiString subString:@"¥"]) {
        [attr yy_setColor:symbolColor range:[origiString rangeOfString:@"¥"]];
        [attr yy_setFont:symbolFont range:[origiString rangeOfString:@"¥"]];
    }
    
    return attr;
}

@end
