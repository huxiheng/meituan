//
//  ModifyInfoViewController.m
//  Youxian100
//
//  Created by zxg on 13-4-1.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import "UIViewController+KeyboardShowAndHide.h"
#import "ModifyCompeteViewController.h"
@interface ModifyPasswordViewController()
{
    
    IBOutlet UITextField *_oldPasswordTextfield;
    IBOutlet UITextField *_newPswdTextField;
    IBOutlet UITextField *_confirmPasswordTextField;
}
@end

@implementation ModifyPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    IOS7_LAYOUT_FIX;
    self.title = @"修改密码";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [_newPswdTextField becomeFirstResponder];
}

- (BOOL)validateInputValues
{
    BOOL validate = NO;
    NSString * alertString = nil;
    do{
//        alertString = @"新密码长度不能少于6位";
//        BREAK_IF( _newPswdTextField.text.length <6);
//        alertString = @"密码长度不能少于6位";
//        BREAK_IF(_confirmPasswordTextField.text .length <6);
        alertString = @"两次输入的密码不一致";
        BREAK_IF(![_newPswdTextField.text isEqualToString:_confirmPasswordTextField.text]);
        //到这里说明检查通过
        validate = YES;
    }while (0);
    if (!validate) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:alertString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    return validate;
}

- (IBAction)confirmButtonDidPress:(id)sender {
    if (![self validateInputValues]) {
        return;
    }
    NSDictionary *params = @{
                             @"UserName" : _userName,
                             @"PassWordOld":_oldPasswordTextfield.text,
                             @"PassWordNew":_confirmPasswordTextField.text
                             };
    APIConnection *connection = [[USTApi sharedInstance]connectionWithApiName:APIMETHOD_UST_ChangePassWord params:params];
    [connection setOnSuccess:^(id result) {
        ModifyCompeteViewController *controller = [[ModifyCompeteViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
        [SVProgressHUD dismiss];
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
    }];
    [SVProgressHUD show];
    [connection startAsynchronous];
}


@end









