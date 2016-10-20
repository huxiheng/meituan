//
//  LogInBindIphoneViewController.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/18.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LogInBindIphoneViewController.h"
#import "BuildPhoneNumView.h"
#import "LSDevice.h"
#import "AppDelegate.h"
#import "UIViewController+KeyboardShowAndHide.h"
#import "TextFieldLimiter.h"

@interface LogInBindIphoneViewController ()
@property (nonatomic, strong)BuildPhoneNumView *checkPhoneView;
@property (retain,nonatomic) NSString *token;
@end

@implementation LogInBindIphoneViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self.view viewWithTag:1001] removeFromSuperview];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, DeviceWidth, DeviceHeight)];
    imageView.image = [UIImage imageWithScreenContents:self.navigationController.view];
    imageView.tag = 1001;
    imageView.userInteractionEnabled =YES;
    [self.view addSubview:imageView];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[self.view viewWithTag:1001] removeFromSuperview];
}

- (void)setData {
    self.titleForNav = @"绑定";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:64.0/255.0 green:170.0/255.0 blue:216.0/255.0 alpha:1.0];
    
    self.checkPhoneView = [[BuildPhoneNumView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64)];
    [self.view addSubview:self.checkPhoneView];
    
    dpBlockSelf;
    self.checkPhoneView.blockClickGetCode = ^(NSString *str){
        [_self getCodeNumber:str];
//        [_self getCodeNumberForCeShi:str];
    };
    
    self.checkPhoneView.blockClickLogIn = ^(NSString *str1, NSString *str2){
        [_self getLogIn:str1 codeNumber:str2];
    };
}

#pragma mark ---获取验证码 －－－－－
- (void)getCodeNumberForCeShi:(NSString *)str{
    NSDictionary *params = @{
//                             @"UserName" : _userName,
//                             @"PassWord" : _password,
                             @"TOKEN": str,
//                             @"Deviceid"    :[[XSConnectPool shareInstance] getUuid]
                             };
    
    
    APIConnection *connection = [[USTApi sharedInstance]connectionWithApiName:APIMETHOD_UST_SearchYanZhengMa params:params];
    [connection setOnSuccess:^(id result) {
        
        _token = result[kAPIConnectionStandartDataKey][@"Token"];
        
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
    }];
    //    [SVProgressHUD show];
    [connection startAsynchronous];
}

- (void)getLogIn:(NSString *)strPhoneNum codeNumber:(NSString *)strCode{
    [LoginUtil setToken:_token];
    

    if (_token == nil) {
        [LSDialog showMessage:@"请先获取验证码"];
        return ;
    }
    if (self.checkPhoneView.textFieldCode.text.length != 4) {
        [LSDialog showMessage:@"请正确输入验证码"];
    }
    
    
    NSDictionary *params = @{
                             @"Token"    :_token,
                             @"CheckCode":strCode
                             };
    APIConnection *connection = [[USTApi sharedInstance]connectionWithApiName:APIMETHOD_UST_BindEnd params:params];
    [connection setOnSuccess:^(id result) {
        NSDictionary *data = result[kAPIConnectionStandartDataKey];
        //        [LoginUtil setToken:data[@"Token"]];
        //bug #23
       
        [LoginUtil setLoginUserName:_userName];
        [LoginUtil setLoginPassword:_password];
        [LoginUtil setnumberPhone:_numberPhone];
        [[NSUserDefaults standardUserDefaults] setValue:_numberPhone forKey:@"IphoneNumberForCode"];
        [[NSUserDefaults standardUserDefaults] setValue:data[@"IsFirstLogin"] forKey:@"isFirstLogInto"];
        NSLog(@"%@", [LoginUtil loginUserName]);
        NSLog(@"%@", [LoginUtil loginPassword]);
        NSLog(@"%@", [LoginUtil numberPhone]);
        
//        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            APP_DELEGATE.rootMainViewController=[[XieshiMainViewController alloc]init];
            APP_DELEGATE.window.rootViewController = APP_DELEGATE.rootMainViewController;
            APP_DELEGATE.rootMainViewController.userPowerString = data[@"UserPower"];
            [[NSUserDefaults standardUserDefaults] setValue: data[@"UserPower"] forKey:@"userPowerStr"];
        });
        
        [SVProgressHUD dismiss];
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
    }];
    
    [SVProgressHUD show];
    [connection startAsynchronous];
}

- (void)getCodeNumber:(NSString *)str{
    NSDictionary *params = @{
                             @"UserName" : _userName,
                             @"PassWord" : _password,
                             @"PhoneNumber": str,
                             @"Deviceid"    :[[XSConnectPool shareInstance] getUuid]
                             };
    self.numberPhone = str;
    [[NSUserDefaults standardUserDefaults] setValue:str forKey:@"IphoneNumberForCode"];
    [LoginUtil setnumberPhone:str];
    
    APIConnection *connection = [[USTApi sharedInstance]connectionWithApiName:APIMETHOD_UST_BindStart params:params];
    [connection setOnSuccess:^(id result) {
        
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            int time = 60;
//            while (time) {
//                NSString *text = [NSString stringWithFormat: @"%d",time];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [sender setTitle:text forState:UIControlStateDisabled];
//                });
//                [NSThread sleepForTimeInterval:1.0];
//                time -- ;
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                sender.enabled = true;
//            });
//            
//        });
        
        _token = result[kAPIConnectionStandartDataKey][@"Token"];
//        [self getCodeNumberForCeShi:_token];
//        [SVProgressHUD dismissWithSuccess:@"已发送"];
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
    }];
//    [SVProgressHUD show];
    [connection startAsynchronous];
}

@end
