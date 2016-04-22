//
//  EncryptionTool.m
//  EncryptionStudy
//
//  Created by 陈舒澳 on 16/4/21.
//  Copyright © 2016年 speeda. All rights reserved.
//

#import "EncryptionTool.h"
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYXabcdefghijklmnopqrstuvwxyz0123456789+/";
@implementation EncryptionTool
+ (NSString *)EncryptionTool_MD5_Encrypt:(NSString *)str{
    const char * newStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(newStr, (unsigned int)strlen(newStr), result);
    NSMutableString * output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [output appendFormat:@"%02X",result[i]];
    }
    return output;
}
+ (NSString *)EncryptionTool_Base64_Encrypt:(NSString *)str{
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    if ([data length] == 0)
        return @"";
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}
+ (NSString *)EncryptionTool_Base64_Decrypt:(NSString *)str{
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [str cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([str length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    bytes = realloc(bytes, length);
    NSData * data = [NSData dataWithBytesNoCopy:bytes length:length];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
+ (NSString *)EncryptionTool_AES_Enstring:(NSString *)destring KeyString:(NSString *)keystring Iv:(NSData *)iv{
    return [[self EncryptionTool_AES_Endata:[destring dataUsingEncoding:NSUTF8StringEncoding] KeyString:keystring Iv:iv] base64EncodedStringWithOptions:0];
}
+ (NSData *)EncryptionTool_AES_Endata:(NSData *)endata KeyString:(NSString *)keystring Iv:(NSData *)iv{
    return [self EncryptionTool_EnDeData:endata KeyString:keystring Algorithm:kCCAlgorithmAES Operation:kCCEncrypt Iv:iv];
}
+ (NSString *)EncryptionTool_AES_Destring:(NSString *)destring KeyString:(NSString *)keystring Iv:(NSData *)iv{
    //base64 解码
    NSData * data = [[NSData alloc] initWithBase64EncodedString:destring options:0];
    return [[NSString alloc] initWithData:[self EncryptionTool_AES_Dedata:data KeyString:keystring Iv:iv] encoding:NSUTF8StringEncoding];
}
+ (NSData *)EncryptionTool_AES_Dedata:(NSData *)dedata KeyString:(NSString *)keystring Iv:(NSData *)iv{
    return [self EncryptionTool_EnDeData:dedata KeyString:keystring Algorithm:kCCAlgorithmAES Operation:kCCDecrypt Iv:iv];
}

+ (NSString *)EncryptionTool_DES_Enstring:(NSString *)destring KeyString:(NSString *)keystring Iv:(NSData *)iv{
    return [[self EncryptionTool_DES_Endata:[destring dataUsingEncoding:NSUTF8StringEncoding] KeyString:keystring Iv:iv] base64EncodedStringWithOptions:0];
}
+ (NSData *)EncryptionTool_DES_Endata:(NSData *)endata KeyString:(NSString *)keystring Iv:(NSData *)iv{
    return [self EncryptionTool_EnDeData:endata KeyString:keystring Algorithm:kCCAlgorithmDES Operation:kCCEncrypt Iv:iv];
}
+ (NSString *)EncryptionTool_DES_Destring:(NSString *)destring KeyString:(NSString *)keystring Iv:(NSData *)iv{
    // base64 解码
    NSData * data = [[NSData alloc] initWithBase64EncodedString:destring options:0];
    return [[NSString alloc] initWithData:[self EncryptionTool_DES_Dedata:data KeyString:keystring Iv:iv] encoding:NSUTF8StringEncoding];
}
+ (NSData *)EncryptionTool_DES_Dedata:(NSData *)dedata KeyString:(NSString *)keystring Iv:(NSData *)iv{
    return [self EncryptionTool_EnDeData:dedata KeyString:keystring Algorithm:kCCAlgorithmDES Operation:kCCDecrypt Iv:iv];
}
/**
 *  @brief 加密解密核心代码
 *
 *  @param data      要加密/解密的数据流
 *  @param keyString 秘钥
 *  @param algorithm 加密/解密的算法
 *  @param operation 加密还是解密
 *  @param iv        向量
 */
+ (NSData *)EncryptionTool_EnDeData:(NSData *)data KeyString:(NSString *)keyString Algorithm:(CCAlgorithm)algorithm Operation:(CCOperation)operation Iv:(NSData *)iv{
    int keySize = (algorithm == kCCAlgorithmAES) ? kCCKeySizeAES128 : kCCKeySizeDES;
    int blockSize = (algorithm == kCCAlgorithmAES) ? kCCBlockSizeAES128 : kCCBlockSizeDES;
    //设置秘钥
    NSData * keyData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t cKey[keySize];
    bzero(cKey, sizeof(cKey));
    [keyData getBytes:cKey length:keySize];
    //设置向量
    uint8_t cIv[blockSize];
    bzero(cIv, blockSize);
    //设置填充模式
    int option = kCCOptionECBMode | kCCOptionPKCS7Padding;
    if (iv) {
        [iv getBytes:cIv length:blockSize];
        option = kCCOptionPKCS7Padding;
    }
    //设置输出缓存区
    size_t bufferSize = [data length] + blockSize;
    void * buffer = malloc(bufferSize);
    //加密解密
    size_t numberBytesDeEn = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation, algorithm, option, cKey, keySize, cIv, [data bytes], [data length], buffer, bufferSize, &numberBytesDeEn);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numberBytesDeEn];
    }else{
         NSLog(@"加密/解密失败---%d",cryptStatus);
    }
    free(buffer);
    return nil;
}
#pragma mark --- CCCrypt 函数关键词的解释
- (void)CCCrypt_description{
    CCCryptorStatus CCCrypt(
                            CCOperation op,         /* kCCEncrypt, etc. 加密还是解密（2种选择）*/
                            CCAlgorithm alg,        /* kCCAlgorithmAES128, etc. 加密要用的算法（）*/
                            CCOptions options,      /* kCCOptionPKCS7Padding, etc. 填充模式（2种选择）*/
                            const void *key,        /* 加密/解密的秘钥 */
                            size_t keyLength,       /* 秘钥的长度 */
                            const void *iv,         /* optional initialization vector 向量偏移 */
                            const void *dataIn,     /* optional per op and alg 要加密/解密的数据 */
                            size_t dataInLength,    /* 要加密/解密数据的长度 */
                            void *dataOut,          /* data RETURNED here 加解密结果 */
                            size_t dataOutAvailable,/* 加密/解密后的数据的长度 */
                            size_t *dataOutMoved);  /* 实际加密/解密的数据长度（涉及补齐） */
    

}
@end
