//
//  ModifyPasswordViewSecondController.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/26.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "ModifyPasswordViewSecondController.h"
#import "UIViewController+KeyboardShowAndHide.h"
#import "ModifyCompeteViewController.h"

@interface ModifyPasswordViewSecondController ()
@property (nonatomic, strong) UITextField       *textFieldOldPassword;
@property (nonatomic, strong) UITextField       *textfieldNewPassword;
@property (nonatomic, strong) UITextField       *textfieldConfirmPassword;
@property (nonatomic, strong) UIButton          *btnSure;

@property (nonatomic, strong) UIView            *viewBG;


@end

@implementation ModifyPasswordViewSecondController

- (void)setData{
    self.titleForNav = @"密码修改";
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHiden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor colorWithRed:61.0/255.0 green:162.0/255.0 blue:213.0/255.0 alpha:1.0];
    [super viewDidLoad];
    [self initSubviews];
}

- (void)initSubviews{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    scrollView.contentSize = CGSizeMake(DeviceWidth, DeviceHeight);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled= YES;
    scrollView.delegate = self;
//    [self.view addSubview:scrollView];
    
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    self.viewBG.backgroundColor = [UIColor colorWithRed:61.0/255.0 green:162.0/255.0 blue:213.0/255.0 alpha:1.0];
    [scrollView addSubview:self.viewBG];
    
    UIView *viewOldePassWord = [[UIView alloc] initWithFrame:CGRectMake((DeviceWidth-280)/2, kscaleDeviceLength(77), 280, kscaleDeviceLength(40))];
    viewOldePassWord.backgroundColor = [UIColor whiteColor];
    viewOldePassWord.layer.cornerRadius = kscaleDeviceLength(17.5);
    viewOldePassWord.layer.masksToBounds = YES;
    [self.viewBG addSubview:viewOldePassWord];
    
    self.textFieldOldPassword = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 250, kscaleDeviceLength(40))];
    self.textFieldOldPassword.secureTextEntry = YES;
    self.textFieldOldPassword.font = themeFont12;
    self.textFieldOldPassword.delegate = self;
    self.textFieldOldPassword.placeholder = @"请输入原密码";
    self.textFieldOldPassword.clearsOnBeginEditing = YES;
    self.textFieldOldPassword.clearButtonMode = UITextFieldViewModeAlways;
    [viewOldePassWord addSubview:self.textFieldOldPassword];
    
    UIView *viewNewPassWord = [[UIView alloc] initWithFrame:CGRectMake((DeviceWidth-280)/2, kscaleDeviceLength(132), 280, kscaleDeviceLength(40))];
    viewNewPassWord.backgroundColor = [UIColor whiteColor];
    viewNewPassWord.layer.cornerRadius = kscaleDeviceLength(17.5);
    viewNewPassWord.layer.masksToBounds = YES;
    [self.viewBG addSubview:viewNewPassWord];
    
    self.textfieldNewPassword = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 250, kscaleDeviceLength(40))];
    self.textfieldNewPassword.secureTextEntry = YES;
    self.textfieldNewPassword.font = themeFont12;
    self.textfieldNewPassword.delegate = self;
    self.textfieldNewPassword.placeholder = @"请输入新密码";
    self.textfieldNewPassword.clearsOnBeginEditing = YES;
    self.textfieldNewPassword.clearButtonMode = UITextFieldViewModeAlways;
    [viewNewPassWord addSubview:self.textfieldNewPassword];
    
    UIView *viewSurePassWord = [[UIView alloc] initWithFrame:CGRectMake((DeviceWidth-280)/2, kscaleDeviceLength(187), 280, kscaleDeviceLength(40))];
    viewSurePassWord.backgroundColor = [UIColor whiteColor];
    viewSurePassWord.layer.cornerRadius = kscaleDeviceLength(17.5);
    viewSurePassWord.layer.masksToBounds = YES;
    [self.viewBG addSubview:viewSurePassWord];
    
    self.textfieldConfirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 250, kscaleDeviceLength(40))];
    self.textfieldConfirmPassword.secureTextEntry = YES;
    self.textfieldConfirmPassword.font = themeFont12;
    self.textfieldConfirmPassword.delegate = self;
    self.textfieldConfirmPassword.placeholder = @"请在输入一次";
    self.textfieldConfirmPassword.clearsOnBeginEditing = YES;
    self.textfieldConfirmPassword.clearButtonMode = UITextFieldViewModeAlways;
    [viewSurePassWord addSubview:self.textfieldConfirmPassword];
    
    self.btnSure = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnSure.frame = CGRectMake((DeviceWidth-280)/2, kscaleDeviceLength(251), 280, kscaleDeviceLength(41));
    [self.btnSure setBackgroundImage:[UIImage imageNamed:@"b-dl"] forState:UIControlStateNormal];
    [self.btnSure setTitle:@"确定" forState:UIControlStateNormal];
    [self.btnSure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnSure.layer.cornerRadius = kscaleDeviceLength(20.5);
    self.btnSure.layer.masksToBounds = YES;
    [self.btnSure addTarget: self action:@selector(btnsureClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewBG addSubview:self.btnSure];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.tableHeaderView = scrollView;
    [self.view addSubview:table];
}

- (void)btnsureClick:(id)sender{
    [self.textfieldConfirmPassword resignFirstResponder];
    [self.textfieldNewPassword resignFirstResponder];
    [self.textFieldOldPassword resignFirstResponder];
    
    if (![self validateInputValues]) {
        return;
    }
    NSDictionary *params = @{
                             @"UserName" : _userName,
                             @"PassWordOld":_textFieldOldPassword.text,
                             @"PassWordNew":_textfieldConfirmPassword.text
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

#pragma mark ---UITEXTFieldDelegate-----
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textfieldConfirmPassword resignFirstResponder];
    [self.textfieldNewPassword resignFirstResponder];
    [self.textFieldOldPassword resignFirstResponder];
    
    return YES;
}

#pragma mark ----UISCROLLViewDelegate-----
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.textfieldConfirmPassword resignFirstResponder];
    [self.textfieldNewPassword resignFirstResponder];
    [self.textFieldOldPassword resignFirstResponder];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)keyboardWillShow:(NSNotification*)notification{
//    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat height = keyboardFrame.size.height;
//    CGFloat keyOriginY = keyboardFrame.origin.y;
//    CGFloat space = keyOriginY-self.btnSure.frame.origin.y;
//    if (space<100 && ![UIDevice currentDevice].isIphone4) {
//        self.viewBG.frame = CGRectMake(0, -kscaleDeviceLength(77), DeviceWidth, DeviceHeight-90);
//    }else {
//        self.viewBG.frame = CGRectMake(0, -height+100   , DeviceWidth, DeviceHeight-height+100);
//    }
    
    
}

- (void)keyBoardWillHiden:(NSNotification *)notification{
    self.viewBG.frame =[UIScreen mainScreen].bounds;
    [self updateLogBtnStatus];
}

- (void)updateLogBtnStatus {
    if (self.textFieldOldPassword.text.length>0&&self.textfieldNewPassword.text.length>0&&self.textfieldConfirmPassword.text.length>0) {
        [self.btnSure setBackgroundImage:[UIImage imageNamed:@"dl1"] forState:UIControlStateNormal];
    }else {
        [self.btnSure setBackgroundImage:[UIImage imageNamed:@"d-dl"] forState:UIControlStateNormal];
    }
    
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
        BREAK_IF(![_textfieldNewPassword.text isEqualToString:_textfieldConfirmPassword.text]);
        //到这里说明检查通过
        validate = YES;
    }while (0);
    if (!validate) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:alertString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    return validate;
}

@end
