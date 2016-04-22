//
//  EncryptionTool.h
//  EncryptionStudy
//
//  Created by 陈舒澳 on 16/4/21.
//  Copyright © 2016年 speeda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
@interface EncryptionTool : NSObject
/** MD5加密  不可逆  返回32位*/
+ (NSString *)EncryptionTool_MD5_Encrypt:(NSString *)str;
/** Base64加密  可逆*/
+ (NSString *)EncryptionTool_Base64_Encrypt:(NSString *)str;
/** Base64解密  可逆*/
+ (NSString *)EncryptionTool_Base64_Decrypt:(NSString *)str;
#pragma mark --- AES DES 加密
/**
 *  AES与DES加密属于对称加密
 *  ("DES/CBC/PKCS5Padding");
 *  CBC是工作模式
 *  DES有四种模式：电子密码本模式（ECB）、加密分组链接模式（CBC）、加密反馈模式（CFB）、输出反馈模式（OFB）
 *  PKCS5Padding 填充模式
 *  
 */
/** AES加密 destring 加密字符串  keystring 秘钥  iv 向量偏移  返回加密后 base64编码 字符串 */
+ (NSString *)EncryptionTool_AES_Enstring:(NSString *)enstring KeyString:(NSString *)keystring Iv:(NSData *)iv;
/** AES加密 endata 加密二进制数据  keystring 秘钥  iv 向量偏移  返回加密后二进制数据 */
+ (NSData *)EncryptionTool_AES_Endata:(NSData *)endata KeyString:(NSString *)keystring Iv:(NSData *)iv;
/** AES解密 destring 解密字符串  keystring 秘钥  iv 向量偏移   解密后字符串 */
+ (NSString *)EncryptionTool_AES_Destring:(NSString *)destring KeyString:(NSString *)keystring Iv:(NSData *)iv;
/** AES解密 dedata 解密二进制数据  keystring 秘钥  iv 向量偏移   解密后二进制数据 */
+ (NSData *)EncryptionTool_AES_Dedata:(NSData *)dedata KeyString:(NSString *)keystring Iv:(NSData *)iv;

/** DES加密 destring 加密字符串  keystring 秘钥  iv 向量偏移  返回加密后 base64编码 字符串 */
+ (NSString *)EncryptionTool_DES_Enstring:(NSString *)enstring KeyString:(NSString *)keystring Iv:(NSData *)iv;
/** DES加密 endata 加密二进制数据  keystring 秘钥  iv 向量偏移  返回加密后二进制数据 */
+ (NSData *)EncryptionTool_DES_Endata:(NSData *)endata KeyString:(NSString *)keystring Iv:(NSData *)iv;
/** DES解密 destring 解密字符串  keystring 秘钥  iv 向量偏移   解密后字符串 */
+ (NSString *)EncryptionTool_DES_Destring:(NSString *)destring KeyString:(NSString *)keystring Iv:(NSData *)iv;
/** DES解密 dedata 解密二进制数据  keystring 秘钥  iv 向量偏移   解密后二进制数据 */
+ (NSData *)EncryptionTool_DES_Dedata:(NSData *)dedata KeyString:(NSString *)keystring Iv:(NSData *)iv;
@end
