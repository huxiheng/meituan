//
//  XSLeftViewController.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/20.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSLeftViewController.h"

@implementation XSLeftViewController
- (void)viewWillAppear:(BOOL)animated {
     NSLog(@"%@",self.powerString);
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor blueColor];
   
   
    [self SetBottomView];
}

- (void)SetBottomView{
    self.viewBGBottom = [[UIView alloc] initWithFrame:CGRectMake(0, DeviceHeight-64, kscaleDeviceWidth(185), 64)];
    [self.view addSubview:self.viewBGBottom];
    
    NSArray *arrayImage = @[[UIImage imageNamed:@"setfuwuqi"],[UIImage imageNamed:@"setgengxin"]];
    NSArray *arrayTitle = @[@"设置",@"退出"];
    for (int i =0; i<2; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20+(35+kscaleDeviceWidth(185)-110)*i, 5, 35, 54)];
//        btn.backgroundColor = [UIColor redColor];
        
        [btn setTitle:arrayTitle[i] forState:UIControlStateNormal];
        if (i==0) {
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }else {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        btn.titleLabel.font = themeFont12;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [btn setImage:arrayImage[i] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(-24-5/2.0, 0, 0, -25)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, -25-5/2.0, 0)];
//        btn.imageEdgeInsets= UIEdgeInsetsMake(5, 5, 29, 5);
//        btn.titleEdgeInsets = UIEdgeInsetsMake(25, 0, 5, 0);
        [self.viewBGBottom addSubview: btn];
    }
}

@end
