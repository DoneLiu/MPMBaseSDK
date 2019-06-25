//
//  NSString+AES256.h
//  美平米
//
//  Created by Done.L on 2019/6/19.
//  Copyright © 2019 com.imicrothink. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CMAES)

/**
 AES256加密数据
 
 @param key 加密字符串
 @return 加密结果
 */
- (NSString *)aes256_encrypt:(NSString *)key;

/**
 AES256解密数据
 
 @param key 解密字符串
 @return 解密结果
 */
- (NSString *)aes256_decrypt:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
