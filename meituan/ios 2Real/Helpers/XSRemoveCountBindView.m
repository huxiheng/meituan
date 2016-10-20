//
//  XSRemoveCountBindView.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/8.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSRemoveCountBindView.h"
#import "XSActionSheet.h"

@implementation XSRemoveCountBindView

- (instancetype)initWithIphoneNum:(NSString *)number countName:(NSString *)name{
    if (self == [super initWithFrame:CGRectMake(0, 0,kscaleDeviceWidth(288), 190)]) {
        self.strIphpneNum = number;
        self.strCountName = name;
        [self initWithSubviews];
    }
    return self;
}

-(void)initWithSubviews{
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kscaleDeviceWidth(288), 190)];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    self.viewBG.layer.cornerRadius = 5;
    self.viewBG.layer.masksToBounds = YES;
    [self addSubview:self.viewBG];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kscaleDeviceWidth(288)-30, 42)];
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_333333];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.font = themeFont14;
    self.labelTitle.text = @"解除帐号绑定";
    [self.viewBG addSubview:self.labelTitle];
    
    self.lineViewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 42, kscaleDeviceWidth(288), 0.5)];
    self.lineViewTitle.backgroundColor = kcolorLine;
    [self.viewBG addSubview:self.lineViewTitle];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 73, kscaleDeviceWidth(288), 15)];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_666666];
    self.labelTitle.font = themeFont12;
    self.labelTitle.text = [NSString stringWithFormat:@"手机号：%@",self.strIphpneNum];
    [self.viewBG addSubview:self.labelTitle];
    
    self.labelUserName = [[UILabel alloc] initWithFrame:CGRectMake(0, 103, kscaleDeviceWidth(288), 15)];
    self.labelUserName.textAlignment = NSTextAlignmentCenter;
    self.labelUserName.textColor = [UIColor colorWithHexString:kc00_666666];
    self.labelUserName.font = themeFont12;
    self.labelUserName.text = [NSString stringWithFormat:@"用户名：%@",self.strCountName];
    [self.viewBG addSubview:self.labelUserName];
    
    self.lineViewBottomUp = [[UIView alloc] initWithFrame:CGRectMake(0, 147, kscaleDeviceWidth(288), 0.5)];
    self.lineViewBottomUp.backgroundColor = kcolorLine;
    [self.viewBG addSubview:self.lineViewBottomUp];
    
    UIView *viewbottom = [[UIView alloc] initWithFrame:CGRectMake(15, 148, kscaleDeviceWidth(288)-30, 42)];
    [self.viewBG addSubview:viewbottom];
    
    for (int i =0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kscaleDeviceWidth(91.5)+kscaleDeviceWidth(60)*i -15, 13, kscaleDeviceWidth(45), 16);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.tag = i+10;
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(btnclickIndex:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = themeFont10;
        [btn setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:147.0/255.0 blue:210.0/255.0 alpha:1.0]];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        if (i==1) {
            [btn setBackgroundColor:[UIColor colorWithRed:83.0/255.0 green:106.0/255.0 blue:120.0/255.0 alpha:1.0]];
            [btn setTitle:@"取消" forState:UIControlStateNormal];
        }
        [viewbottom addSubview:btn];
    }
    
}

- (void)btnclickIndex:(UIButton*)btn{
    XSActionSheet *actionSheet = (XSActionSheet *)[self superview];
    [actionSheet hiddenSelf];
    self.blockClickBtn(btn.tag);
}

@end
