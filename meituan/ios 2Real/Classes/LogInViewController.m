//
//  LogInViewController.m
//  Xieshi
//
//  Created by Tesiro on 16/7/12.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LogInViewController.h"
#import "NSObject+SBJSON.h"
#import "RegexKitLite.h"
#import "LogInBindIphoneViewController.h"
#import "LSDevice.h"
#import "AppDelegate.h"



@interface LogInViewController (){
    UIView *viewCount;
}

@end

@implementation LogInViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHiden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
}

- (void)initSubViews {
    self.viewBG = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [self.view addSubview:self.viewBG];
    
    UIScrollView *scrollviewBG = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollviewBG.contentSize = CGSizeMake(DeviceWidth, DeviceHeight);
    scrollviewBG.bounces = YES;
    scrollviewBG.scrollEnabled =YES;
//    scrollviewBG.delegate = self;
    scrollviewBG.showsVerticalScrollIndicator = NO;
    scrollviewBG.showsHorizontalScrollIndicator = NO;
    scrollviewBG.pagingEnabled =YES;
    scrollviewBG.scrollEnabled = YES;
//    [self.view addSubview:scrollviewBG];
    [scrollviewBG addSubview:self.viewBG];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.tableHeaderView = scrollviewBG;
    [self.view addSubview:table];
    
    self.imageViewBG = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.imageViewBG.image = [UIImage imageNamed:@"logo"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickImag:)];
    tap.cancelsTouchesInView = NO;
    [self.imageViewBG addGestureRecognizer:tap];
    self.imageViewBG.userInteractionEnabled = YES;
    [self.viewBG addSubview:self.imageViewBG];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,kscaleDeviceHeight(235) , DeviceWidth,kscaleDeviceLength(25))];
    self.labelTitle.backgroundColor = [UIColor clearColor];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.text=@"检测管理";
    self.labelTitle.font = themeFont20;
    self.labelTitle.textColor = [UIColor whiteColor];
    [self.imageViewBG addSubview:self.labelTitle];
    
    UILabel *labelVersion = [[UILabel alloc] initWithFrame:CGRectMake(0, kscaleDeviceHeight(263), DeviceWidth, 10)];
    labelVersion.text=[NSString stringWithFormat:@"V%@",kVersion];
    labelVersion.textColor = [UIColor whiteColor];
    labelVersion.font = themeFont10;
    labelVersion.textAlignment = NSTextAlignmentCenter;
    [self.imageViewBG addSubview:labelVersion];
    
//    self.viewLog = [[UIView alloc] initWithFrame:CGRectMake((DeviceWidth-245)/2, kscaleDeviceLength(314), 245, kscaleDeviceLength(100))];
//    self.viewLog.backgroundColor = [UIColor whiteColor];
//    self.viewLog.layer.cornerRadius = 5;
//    self.viewLog.layer.masksToBounds = YES;
//    [self.viewBG addSubview: self.viewLog];
    
   viewCount = [[UIView alloc] initWithFrame:CGRectMake((DeviceWidth-280)/2, kscaleDeviceLength(335), 280, kscaleDeviceLength(45))];
    viewCount.layer.cornerRadius = kscaleDeviceLength(22.5);
    viewCount.layer.masksToBounds = YES;
    viewCount.backgroundColor = [UIColor whiteColor];
    [self.viewBG addSubview:viewCount];
    
    self.textFieldReportNum = [[UITextField alloc] initWithFrame:CGRectMake(15, kscaleDeviceLength(0), 250, kscaleDeviceLength(45))];
    self.textFieldReportNum.placeholder = @"   帐号";
    self.textFieldReportNum.textColor = [UIColor colorWithHexString:kc00_8c8c8c];
    self.textFieldReportNum.font = themeFont12;
//    self.textFieldReportNum.clearsOnBeginEditing = YES;
    self.textFieldReportNum.clearButtonMode = UITextFieldViewModeAlways;
    UIImageView *imageReportNum = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 21, 21)];
    imageReportNum.image = [UIImage imageNamed:@"logHXHMaleUser"];
    self.textFieldReportNum.leftView = imageReportNum;
    self.textFieldReportNum.leftViewMode= UITextFieldViewModeAlways;
    self.textFieldReportNum.delegate = self;
//    self.textFieldReportNum.keyboardType = UIKeyboardTypeNamePhonePad;
    [viewCount addSubview:self.textFieldReportNum];
    
    UIView *viewPassword = [[UIView alloc] initWithFrame:CGRectMake((DeviceWidth-280)/2, kscaleDeviceLength(400), 280, kscaleDeviceLength(45))];
    viewPassword.layer.cornerRadius = kscaleDeviceLength(22.5);
    viewPassword.layer.masksToBounds = YES;
    viewPassword.backgroundColor = [UIColor whiteColor];
    [self.viewBG addSubview:viewPassword];
    
    self.textFieldCheckCode = [[UITextField alloc] initWithFrame:CGRectMake(15, kscaleDeviceLength(0), 250, kscaleDeviceLength(45))];
    self.textFieldCheckCode.placeholder = @"   密码";
    self.textFieldCheckCode.secureTextEntry = YES;
    self.textFieldCheckCode.keyboardType = UIKeyboardTypeASCIICapable;
    self.textFieldCheckCode.textColor = [UIColor colorWithHexString:kc00_8c8c8c];
    self.textFieldCheckCode.font = themeFont12;
    self.textFieldCheckCode.clearsOnBeginEditing = YES;
    self.textFieldCheckCode.clearButtonMode = UITextFieldViewModeAlways;
    UIImageView *imageCheckCode = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 21, 21)];
    imageCheckCode.image = [UIImage imageNamed:@"logHXHmima"];
    self.textFieldCheckCode.leftView = imageCheckCode;
    self.textFieldCheckCode.leftViewMode = UITextFieldViewModeAlways;
    self.textFieldCheckCode.delegate = self;
    [viewPassword addSubview:self.textFieldCheckCode];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLogInto"] boolValue]==0 ) {
        self.textFieldReportNum.text = [LoginUtil loginUserName];
        self.textFieldCheckCode.text = [LoginUtil loginPassword];
    }
    
    self.buttonSure = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonSure.frame = CGRectMake((DeviceWidth-280)/2, kscaleDeviceLength(480), 280, kscaleDeviceLength(45));
    self.buttonSure.layer.cornerRadius = kscaleDeviceLength(22.5);
    self.buttonSure.layer.masksToBounds = YES;
    [self.buttonSure setTitle:@"登录" forState:UIControlStateNormal];
    self.buttonSure.titleLabel.font = themeFont16;
    self.buttonSure.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.buttonSure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buttonSure setBackgroundImage:[UIImage imageNamed:@"d-dl"] forState:UIControlStateNormal];
    [self.buttonSure setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:kc00_0062A3]] forState:UIControlStateHighlighted];
    [self.buttonSure setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.buttonSure addTarget:self action:@selector(clickBtnSure:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewBG addSubview:self.buttonSure];
    
    
    self.buttonZBar = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonZBar.frame = CGRectMake((DeviceWidth-245)/2, kscaleDeviceLength(524), 245, kscaleDeviceLength(39));
    self.buttonZBar.layer.cornerRadius = 5;
    self.buttonZBar.layer.masksToBounds = YES;
    [self.buttonZBar setTitle:@"二维码" forState:UIControlStateNormal];
    self.buttonZBar.titleLabel.font = themeFont16;
    self.buttonZBar.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.buttonZBar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buttonZBar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:kc00_7ED127]] forState:UIControlStateNormal];
    [self.buttonZBar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:kc00_0062A3]] forState:UIControlStateHighlighted];
    [self.buttonZBar addTarget:self action:@selector(clickbtnZBar:) forControlEvents:UIControlEventTouchUpInside];
//    [self.viewBG addSubview:self.buttonZBar];
    
    
    
    if ([UIDevice currentDevice].isIphone4) {
//        scrollviewBG.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
        self.buttonZBar.frame = CGRectMake((DeviceWidth-245)/2, DeviceHeight-10-kscaleDeviceLength(39), 245, kscaleDeviceLength(39));
    }
}

#pragma mark ---UITEXTFieldDelegate-----
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textFieldCheckCode resignFirstResponder];
    [self.textFieldReportNum resignFirstResponder];
    
    return YES;
}

#pragma mark ----UISCROLLViewDelegate-----
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.textFieldCheckCode resignFirstResponder];
    [self.textFieldReportNum resignFirstResponder];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)clickBtnSure:(UIButton *)btn{
    //    BOOL success;
    //    NSString *message;
    [self.textFieldCheckCode resignFirstResponder];
    [self.textFieldReportNum resignFirstResponder];
    
    if (self.textFieldCheckCode.text.length == 0 || self.textFieldReportNum.text == 0) {
        [LSDialog showMessage:@"请输入账号或者密码"];
        return ;
    }
    
    NSString *userName = self.textFieldReportNum.text;
    NSString *password = self.textFieldCheckCode.text;
    [LoginUtil setLoginUserName:userName];
    [LoginUtil setLoginPassword:password];
    

    NSString *deviceId = [[XSConnectPool shareInstance] getUuid];
    
    NSDictionary *params = @{
                             @"UserName":userName,
                             @"PassWord":password,
                             @"DeviceId":deviceId
                             };
    APIConnection *connection = [[USTApi sharedInstance]connectionWithApiName:APIMETHOD_UST_UserLogin params: params ];
    [connection setOnSuccess:^(id result) {
        
        NSDictionary *data = result[kAPIConnectionStandartDataKey];
        [[NSUserDefaults standardUserDefaults] setValue:data[@"IsFirstLogin"] forKey:@"isFirstLogInto"];
        if([data[@"IsFirstLogin"] boolValue]
#ifdef LS_DEBUG
           && (0)
#endif
           ){
            
            [SVProgressHUD dismiss];
            LogInBindIphoneViewController *controller = [[LogInBindIphoneViewController alloc]init];
            controller.userName = userName;
            controller.password = password;
            controller.deviceId = deviceId;
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            [SVProgressHUD dismiss];
            [LoginUtil setLoginUserName:userName];
            [LoginUtil setLoginPassword:password];
            [LoginUtil setToken:data[@"Token"]];
#ifdef LS_DEBUG
            //            GLY
            //            [LoginUtil setToken:@"9d5b0870-d824-47a4-ba96-d129ca77789c"];
            
            //t9990001
            [LoginUtil setToken:@"D2416D3F-51BA-447C-9BBE-347BA401472D"];
            
            //J20623
            //            [LoginUtil setToken:@"e9383cfe-091a-47cc-83da-e54fec9aed7f"];
            
            //            T2916
            //            [LoginUtil setToken:@"6384ad1a-4d9d-4f88-b413-0f51b2fbec5f"];
            
            //            Q13503
            //            [LoginUtil setToken:@"a0d33a36-f733-4de8-a338-1e68dbda019d"];
#endif
            if (APP_DELEGATE.rootMainViewController == nil) {
                
                APP_DELEGATE.rootMainViewController=[[XieshiMainViewController alloc]init];
            }
            APP_DELEGATE.window.rootViewController = APP_DELEGATE.rootMainViewController;
            APP_DELEGATE.rootMainViewController.userPowerString = data[@"UserPower"];
            [[NSUserDefaults standardUserDefaults] setValue: data[@"UserPower"] forKey:@"userPowerStr"];
//            APP_DELEGATE.rootMainViewController.userPowerString = @"00010110";
            
        }
    }];
    [connection setOnFailed:^(NSError *error) {
        if (error.code == 2000) {
            [SVProgressHUD dismiss];
            LogInBindIphoneViewController *controller = [[LogInBindIphoneViewController alloc]init];
            controller.userName = userName;
            controller.password = password;
            controller.deviceId = deviceId;
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            NSString *errorDescription = [error localizedDescription];
            [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
        }
    }];
    [SVProgressHUD show];
    [connection startAsynchronous];
}

- (void)tapClickImag:(UITapGestureRecognizer*)tap{
    [self.textFieldReportNum resignFirstResponder];
    [self.textFieldCheckCode resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification*)notification{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = keyboardFrame.size.height;
    CGFloat keyOriginY = keyboardFrame.origin.y;
    CGFloat space = keyOriginY-viewCount.frame.origin.y;
    if (space<100 && ![UIDevice currentDevice].isIphone4) {
        self.viewBG.frame = CGRectMake(0, -90, DeviceWidth, DeviceHeight-90);
    }else {
        self.viewBG.frame = CGRectMake(0, -height+100   , DeviceWidth, DeviceHeight-height+100);
    }
    
    if (DeviceHeight<500) {
        self.viewBG.frame = CGRectMake(0, -height+70   , DeviceWidth, DeviceHeight);
    }else if(DeviceHeight<600&&DeviceHeight>500){
        self.viewBG.frame = CGRectMake(0, -height+160   , DeviceWidth, DeviceHeight);
        
    }
    NSLog(@"%F",DeviceHeight);
}

- (void)keyBoardWillHiden:(NSNotification *)notification{
    self.viewBG.frame =[UIScreen mainScreen].bounds;
    [self updateLogBtnStatus];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLogBtnStatus {
    if (self.textFieldReportNum.text.length>0&&self.textFieldCheckCode.text.length>0) {
        [self.buttonSure setBackgroundImage:[UIImage imageNamed:@"dl1"] forState:UIControlStateNormal];
    }else {
        [self.buttonSure setBackgroundImage:[UIImage imageNamed:@"d-dl"] forState:UIControlStateNormal];
    }
    
}

@end
