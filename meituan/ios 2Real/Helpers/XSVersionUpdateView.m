//
//  XSVersionUpdateView.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/27.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSVersionUpdateView.h"
#import "XSActionSheet.h"

@implementation XSVersionUpdateView
- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title{
    self = [super initWithFrame:CGRectMake(0, 0,kscaleDeviceWidth(260), 190)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.strTitle = title;
        self.strImageName = imageName;
        [self setSubViews];
    }
    return self;
}

- (void)setSubViews{
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kscaleDeviceWidth(260), 190)];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    [self addSubview:self.viewBG];
    
    self.imageViewRight = [[UIImageView alloc] initWithFrame:CGRectMake((kscaleDeviceWidth(260)-52)/2, 31, 52, 42)];
    self.imageViewRight.image = [UIImage imageNamed:self.strImageName];
    [self addSubview:self.imageViewRight];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 98, kscaleDeviceWidth(260), 16)];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_666666];
    self.labelTitle.font = themeFont16;
    self.labelTitle.text = self.strTitle;
    [self addSubview:self.labelTitle];
    
    self.btnSure = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnSure.frame = CGRectMake((kscaleDeviceWidth(260)-205)/2, 139, 205, 33);
    self.btnSure.layer.cornerRadius = 5;
    self.btnSure.layer.masksToBounds = YES;
    self.btnSure.layer.borderWidth=1.0;
    self.btnSure.layer.borderColor = kcolorLine.CGColor;
    [self.btnSure setTitle:@"确定" forState:UIControlStateNormal];
    [self.btnSure setTitleColor:[UIColor colorWithHexString:kc00_666666] forState:UIControlStateNormal];
    [self.btnSure addTarget:self action:@selector(btnSureClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnSure];
    
}

- (void)btnSureClick:(id)btn{
    XSActionSheet *actionSheet = (XSActionSheet *)[self superview];
//    actionSheet.shadowView = nil;

    [actionSheet hiddenSelf];
}
@end
