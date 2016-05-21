//
//  ViewController.m
//  EncryptionStudy
//
//  Created by 陈舒澳 on 16/4/21.
//  Copyright © 2016年 speeda. All rights reserved.
//

#import "ViewController.h"
#import "EncryptionTool.h"
#import <LocalAuthentication/LocalAuthentication.h>
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
#pragma mark --- 指纹解锁
/*
     首先要导入LocalAuthentication.framework包
     其次，导入头文件 #import <LocalAuthentication/LocalAuthentication.h>
 */
- (IBAction)fingerPrintLockButtonClicked:(id)sender {
    LAContext * context = [[LAContext alloc] init];
    __block NSString * msg;
    NSError * error;
    BOOL success;
    //判断是否支持指纹解锁
    success = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (success) {
        msg = [NSString stringWithFormat:NSLocalizedString(@"TOUCH_ID_IS_AVAILABLE", nil)];
        //开始验证指纹
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:NSLocalizedString(@"UNLOCK_ACCESS_TO_LOCKED_FATURE", nil) reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                msg = [NSString stringWithFormat:NSLocalizedString(@"EVALUATE_POLICY_SUCCESS", nil)];
                NSLog(@"成功");
            }else{
                msg = [NSString stringWithFormat:NSLocalizedString(@"EVALUATE_POLICY_WITH_ERROR", nil)];
            }
        }];
    }else{
        msg = [NSString stringWithFormat:NSLocalizedString(@"TOUCH_ID_IS_NOT_AVAILABLE", nil)];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
