//
//  ServerSelectViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15/5/10.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "ServerSelectViewController.h"
#import "SMAPI.h"

@interface ServerSelectViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cnnetButton;
@property (weak, nonatomic) IBOutlet UIButton *unionButton;

@end

@implementation ServerSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    IOS7_LAYOUT_FIX;
    self.title=@"选择服务器";
    NSString *server = [LoginUtil valueForKey:@"server_select"];
    if ([server isEqualToString:@"cnnet"]) {
        _cnnetButton.selected = true;
    }
    if ([server isEqualToString:@"union"]) {
        _unionButton.selected = true;
    }
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
- (IBAction)cnnetButtonDidPress:(id)sender {
    _cnnetButton.selected = true;
    _unionButton.selected = false;
    [LoginUtil setValue:@"cnnet" forKey:@"server_select"];
    [[USTApi sharedInstance] setServerUrl:CNNET_SERVER_URL];
    [[RPAPI sharedInstance] setServerUrl:CNNET_SERVER_URL];
    [[SMAPI sharedInstance] setServerUrl:CNNET_SERVER_URL];
    [[TSAPI sharedInstance] setServerUrl:CNNET_SERVER_URL];
    [[CommonAPI sharedInstance] setServerUrl:CNNET_SERVER_URL];
}
- (IBAction)unionButtonDidPress:(id)sender {
    _cnnetButton.selected = false;
    _unionButton.selected = true;
    [LoginUtil setValue:@"union" forKey:@"server_select"];
    [[USTApi sharedInstance] setServerUrl:UNION_SERVER_URL];
    [[RPAPI sharedInstance] setServerUrl:UNION_SERVER_URL];
    [[SMAPI sharedInstance] setServerUrl:UNION_SERVER_URL];
    [[TSAPI sharedInstance] setServerUrl:UNION_SERVER_URL];
    [[CommonAPI sharedInstance] setServerUrl:UNION_SERVER_URL];
}

@end
