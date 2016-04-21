//
//  EncryptionTool.h
//  EncryptionStudy
//
//  Created by 陈舒澳 on 16/4/21.
//  Copyright © 2016年 speeda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
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
@end
