//
//  ModifyCompeteViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15/5/10.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "ModifyCompeteViewController.h"

@interface ModifyCompeteViewController ()

@end

@implementation ModifyCompeteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.title = @"修改完成";
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDidPress:)];
    self.navigationItem.rightBarButtonItem = barButton;
    {
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.leftBarButtonItem = barButton;
    }
}

- (void)rightBarButtonDidPress:(UIBarButtonItem *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
