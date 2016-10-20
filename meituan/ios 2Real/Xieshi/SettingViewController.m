//
//  SettingViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15/5/10.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "SettingViewController.h"
#import "ModifyPasswordViewController.h"
#import "ServerSelectViewController.h"
#import "NSString+SBJSON.h"
@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *serverNameLabel;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    IOS7_LAYOUT_FIX;
    [super viewDidLoad];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonDidPress:)];
    self.navigationItem.leftBarButtonItem = barButton;
    self.title=@"设定";
    

    

    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *server = [LoginUtil valueForKey:@"server_select"];
    if ([server isEqualToString:@"cnnet"]) {
        _serverNameLabel.text = @"中国电信";
    }
    if ([server isEqualToString:@"union"]) {
        _serverNameLabel.text = @"中国联通";
    }
}
- (void)leftBarButtonDidPress:(UIBarButtonItem *)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)changePasswordButtonDidPress:(id)sender {
    ModifyPasswordViewController *controller = [[ModifyPasswordViewController alloc]init];
    controller.userName = [LoginUtil loginUserName];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)selectServerButtonDidPress:(id)sender {
    ServerSelectViewController *controller = [[ServerSelectViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)checkUpdateButtonDidPress:(id)sender {
    @try {

        NSDictionary *params = @{
                                 @"PlatformType" : @"2",
                                 @"SystemType"   : @"2"
                                 };
        APIConnection *connection = [[USTApi sharedInstance]connectionWithApiName:APIMETHOD_UST_GetUpdateVersion params:params];
        [connection setOnSuccess:^(id result) {
            result = result[@"Data"][0];
            if (versionNameBiggerThan(result[@"Version"], [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"])){
                if ([result[@"Update_Flag"] integerValue] == 1){
                    [LSDialog showDialogWithTitle:@"发现新版本" message:result[@"Description"]confirmText:@"升级" confirmCallback:^{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:result[@"Update_Url"]]];
                    } cancelText:@"取消" cancelCallback:^{
                        
                    }];                    
                }else{
                    [LSDialog showAlertWithTitle:@"发现新版本" message:result[@"Description"] callBack:^{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:result[@"Update_Url"]]];
                    }];
                }
            }else{
                [LSDialog showAlertWithTitle:@"提示" message:@"已经是最新版了" callBack:0];
                
            }
        }];
        [connection setOnFailed:^(NSError *error) {
            NSString *errorDescription = [error localizedDescription];
            [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
        }];
        [connection startAsynchronous];        
    }
    @catch (NSException *exception) {
        [LSDialog showAlertWithTitle:@"提示" message:@"升级出现错误" callBack:0];

    }
    @finally {
        
    }
    
}

@end
