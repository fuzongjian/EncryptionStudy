//
//  ViewController.m
//  EncryptionStudy
//
//  Created by 陈舒澳 on 16/4/21.
//  Copyright © 2016年 speeda. All rights reserved.
//

#import "ViewController.h"
#import "EncryptionTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // NSString * str = [EncryptionTool EncryptionTool_Base64_Encrypt:@"fuzongjian"];
    
  //  NSString * deStr = [EncryptionTool EncryptionTool_Base64_Decrypt:str];
    
    // NSLog(@"%@---%@---",str,deStr);
    
    
//    [self testAES_en];
    
//    [self testAES_de];
//    [self testDES_en];
    [self testDES_de];
}
- (void)testDES_de{
    NSString * ivStr = @"fuzongjian";
    NSData * iv = [ivStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString * keyStr = @"15268598930";
    NSString * destr = @"Xtbkff/d0qnbwJlCK1m8ZOSN+IL0XnjMKBvn+mco7hSFrxz5hl4wNFa4PAnA6Q0vvNYvuioCBp4=";
    
    NSString * custom = [EncryptionTool EncryptionTool_DES_Destring:destr KeyString:keyStr Iv:iv];
     NSLog(@"DES解密%@",custom);
}
- (void)testDES_en{
//    Xtbkff/d0qnbwJlCK1m8ZOSN+IL0XnjMKBvn+mco7hSFrxz5hl4wNFa4PAnA6Q0vvNYvuioCBp4=
    NSString * ivStr = @"fuzongjian";
    NSData * iv = [ivStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString * keyStr = @"15268598930";
    NSString * destr = @"ruguoyouyitianwolaowusuoyiqingbawomaizaizhechuntianli";
    
    NSString * custom = [EncryptionTool EncryptionTool_DES_Enstring:destr KeyString:keyStr Iv:iv];
     NSLog(@"DES加密%@",custom);
}

- (void)testAES_en{
//    iCJy1HzduIij0koqHI2yg4wItFKQAH/3JMr65y8ehmrVY4fbyXFVeIsS8PqJ2dz+osIWD33rqnKI+t0EobtyGw==
    NSString * ivStr = @"fuzongjian";
    NSData * iv = [ivStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString * keyStr = @"15268598930";
    NSString * destr = @"ruguoyouyitianwolaowusuoyiqingbawomaizaizhechuntianli";
    
    NSString * custom = [EncryptionTool EncryptionTool_AES_Enstring:destr KeyString:keyStr Iv:iv];
    NSLog(@"AES加密%@",custom);
}
- (void)testAES_de{
    NSString * ivStr = @"fuzongjian";
    NSData * iv = [ivStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString * keyStr = @"15268598930";
    NSString * destr = @"iCJy1HzduIij0koqHI2yg4wItFKQAH/3JMr65y8ehmrVY4fbyXFVeIsS8PqJ2dz+osIWD33rqnKI+t0EobtyGw==";
    NSString * custom = [EncryptionTool EncryptionTool_AES_Destring:destr KeyString:keyStr Iv:iv];
    NSLog(@"AES解密%@",custom);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
