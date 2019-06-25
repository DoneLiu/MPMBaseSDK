//
//  NSData+AES256.h
//  美平米
//
//  Created by Done.L on 2019/6/19.
//  Copyright © 2019 com.imicrothink. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (CMAES)

/**
 AES256加密
 
 @param key 加密字符串
 @return 加密数据
 */
- (NSData *)aes256_encrypt:(NSString *)key;


/**
 AES256解密
 
 @param key 解密字符串
 @return 解密数据
 */
- (NSData *)aes256_decrypt:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
