//
//  BuildPhoneNumView.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/18.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "BuildPhoneNumView.h"

@implementation BuildPhoneNumView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews{
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth  , ViewHeight)];
    self.viewBG.backgroundColor = [UIColor colorWithRed:64.0/255.0 green:170.0/255.0 blue:216.0/255.0 alpha:1.0];
    [self addSubview:self.viewBG];
    
    self.viewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
    self.viewScrollView.backgroundColor = [UIColor colorWithRed:64.0/255.0 green:170.0/255.0 blue:216.0/255.0 alpha:1.0];
    self.viewScrollView.contentSize = CGSizeMake(ViewWidth, ViewHeight);
    self.viewScrollView.pagingEnabled = YES;
    self.viewScrollView.scrollEnabled = YES;
    self.viewScrollView.bounces = YES;
    self.viewScrollView.showsVerticalScrollIndicator =NO;
    self.viewScrollView.showsHorizontalScrollIndicator =NO;
    self.viewScrollView.delegate = self;
//    [self.viewBG addSubview:self.viewScrollView];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight) style:UITableViewStylePlain];
    [self.viewBG addSubview:self.table];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.tableHeaderView = self.viewScrollView;
    
    self.viewScrollBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
    [self.viewScrollView  addSubview:self.viewScrollBG];
    
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickScrollViewBG)];
    tap.cancelsTouchesInView = NO;
    [self.viewScrollBG addGestureRecognizer:tap];
    
    UIView *viewPhoneNum = [[UIView alloc] initWithFrame:CGRectMake((ViewWidth-280)/2, kscaleDeviceLength(75), 280, kscaleDeviceLength(45))];
    viewPhoneNum.backgroundColor = [UIColor whiteColor];
    viewPhoneNum.layer.cornerRadius = kscaleDeviceLength(17.5);
    viewPhoneNum.layer.masksToBounds = YES;
    [self.viewScrollBG addSubview:viewPhoneNum];
    
    self.textFieldPhoneNum = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 250, kscaleDeviceLength(45))];
    self.textFieldPhoneNum.font = themeFont12;
    self.textFieldPhoneNum.textColor = [UIColor colorWithHexString:kc00_A5A4A4];
    self.textFieldPhoneNum.placeholder = @"请输入手机号";
    self.textFieldPhoneNum.keyboardType = UIKeyboardTypeNumberPad;
    [viewPhoneNum addSubview:self.textFieldPhoneNum];
    
    UIView *viewCode = [[UIView alloc] initWithFrame:CGRectMake((ViewWidth-280)/2, kscaleDeviceLength(140), 160, kscaleDeviceLength(45))];
    viewCode.backgroundColor = [UIColor whiteColor];
    viewCode.layer.cornerRadius = kscaleDeviceLength(17.5);
    viewCode.layer.masksToBounds = YES;
    [self.viewScrollBG addSubview:viewCode];
    
    self.textFieldCode = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 130, kscaleDeviceLength(45))];
    self.textFieldCode.font = themeFont12;
    self.textFieldCode.textColor = [UIColor colorWithHexString:kc00_A5A4A4];
    self.textFieldCode.placeholder = @"请输入验证码";
    [viewCode addSubview:self.textFieldCode];
    
    self.btnCode = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnCode setBackgroundColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
    self.btnCode.layer.frame = CGRectMake((ViewWidth-280)/2+175, kscaleDeviceLength(140), 105, kscaleDeviceLength(45));
    self.btnCode.layer.cornerRadius = kscaleDeviceLength(17.5);
    self.btnCode.layer.masksToBounds = YES;
    [self.btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.btnCode.titleLabel.font = themeFont12;
    [self.btnCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnCode addTarget:self action:@selector(btnCodeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewScrollBG addSubview:self.btnCode];
    
    self.btnLogIn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnLogIn.frame = CGRectMake((ViewWidth-280)/2, kscaleDeviceLength(220), 280, kscaleDeviceLength(50));
    [self.btnLogIn setTitle:@"登陆" forState:UIControlStateNormal];
    [self.btnLogIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnLogIn setBackgroundImage:[UIImage imageNamed:@"b-dl"] forState:UIControlStateNormal];
    self.btnLogIn.layer.cornerRadius = kscaleDeviceLength(25);
    self.btnLogIn.layer.masksToBounds = YES;
    [self.btnLogIn addTarget:self action:@selector(btnLogInClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewScrollBG addSubview:self.btnLogIn];
    
}

#pragma --UIScrollViewDelegate--
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.textFieldPhoneNum resignFirstResponder];
    [self.textFieldCode resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)ClickScrollViewBG {
    [self.textFieldPhoneNum resignFirstResponder];
    [self.textFieldCode resignFirstResponder];
}


- (void)btnLogInClick:(UIButton *)btn{
    [self.textFieldPhoneNum resignFirstResponder];
    [self.textFieldCode resignFirstResponder];
    
    self.blockClickLogIn (self.textFieldPhoneNum.text,self.textFieldCode.text);
    
}

- (void)btnCodeClick:(UIButton *)btn {
    if ([XSShareObject isValidateMobile:self.textFieldPhoneNum.text]==NO) {
        [UIAlertView alertViewWithTitle:@"" message:@"请输入正确的手机号码" cancelButtonTitle:nil otherButtonTitles:@[@"OK"] onDismiss:^(int buttonIndex) {
            [self.textFieldPhoneNum becomeFirstResponder];
        } onCancel:^{
            
        }];
        return;
    }
    
     self.btnCode.userInteractionEnabled = NO;
    [UIAlertView alertViewWithTitle:@"" message:@"验证码已发送" cancelButtonTitle:nil otherButtonTitles:@[@"OK"] onDismiss:^(int buttonIndex) {
        [self.textFieldCode becomeFirstResponder];
    } onCancel:^{
        
    }];
    
    //获取验证码倒计时
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i= 59; i > -1; i--) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.btnCode setTitle:[NSString stringWithFormat:@"等待%d秒",i] forState:UIControlStateNormal];
                self.btnCode.userInteractionEnabled = NO;
            });
            
            if (i == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.btnCode setTitle:@"重新获取" forState:UIControlStateNormal];
                    self.btnCode.userInteractionEnabled = YES;
                });
            }
            sleep(1);
            
        }
    });
    
    if (self.blockClickGetCode) {
        self.blockClickGetCode (self.textFieldPhoneNum.text);
    }
}



@end
