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
    NSString * str = [EncryptionTool EncryptionTool_Base64_Encrypt:@"fuzongjian"];
    
    NSString * deStr = [EncryptionTool EncryptionTool_Base64_Decrypt:str];
    
     NSLog(@"%@---%@---",str,deStr);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
