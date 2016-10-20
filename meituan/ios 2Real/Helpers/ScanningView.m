//
//  ScanningView.m
//  J1health
//
//  Created by zhizi on 16/3/15.
//  Copyright © 2016年 J1. All rights reserved.
//

#import "ScanningView.h"
@interface ScanningView()
@property (nonatomic, strong)UIView *upView;
@property (nonatomic, strong)UIView *downView;
@property (nonatomic, strong)UIView *leftView;
@property (nonatomic, strong)UIView *rightView;
@property (nonatomic, strong)UIImageView *imageSaoBJ;
@property (nonatomic, strong)UILabel *labelTips;
@property (nonatomic, strong)UIButton *bottonMyErWeiMa;

@end

@implementation ScanningView

- (id)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        [self setsubviews];
    }
    return self;
}
- (void)setsubviews {
    self.backgroundColor =[UIColor clearColor];
    
//    self.imageSaoBJ =[[UIImageView alloc] initWithFrame:CGRectMake(40, 64, DeviceWidth-80, DeviceWidth-80)];
//    self.imageSaoBJ.image =[UIImage imageNamed:@"smkuang"];
//    [self addSubview:self.imageSaoBJ];
//    
//    self.labelTips =[[UILabel alloc] initWithFrame:CGRectMake(0, DeviceWidth+10, DeviceWidth, 30)];
//    self.labelTips.text =@"将二维码加入框内，即可自动扫描";
//    self.labelTips.font =themeFont(14.0f);
//    self.labelTips.textAlignment =NSTextAlignmentCenter;
//    self.labelTips.textColor =[UIColor colorWithHexString:@"#969696"];
//    [self addSubview:self.labelTips];
//    
//    self.upView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 64)];
//    self.upView.backgroundColor =[UIColor blackColor];
//    self.upView.alpha =0.4;
//    [self addSubview:self.upView];
//    
//    self.leftView =[[UIView alloc] initWithFrame:CGRectMake(0, 64, 40, DeviceWidth-80)];
//    self.leftView.backgroundColor =[UIColor blackColor];
//    self.leftView.alpha =0.4;
//    [self addSubview:self.leftView];
//    
//    self.rightView =[[UIView alloc] initWithFrame:CGRectMake(DeviceWidth-40, 64, 40, DeviceWidth-80)];
//    self.rightView.backgroundColor =[UIColor blackColor];
//    self.rightView.alpha =0.4;
//    [self addSubview:self.rightView];
//    
//    self.downView =[[UIView alloc] initWithFrame:CGRectMake(0, DeviceWidth-80+64, DeviceWidth,  DeviceHeight-DeviceWidth+80-64)];
//    self.downView.backgroundColor =[UIColor blackColor];
//    self.downView.alpha =0.4;
//    [self addSubview:self.downView];
    
    self.lineImage =[[UIImageView alloc] initWithFrame:CGRectMake(kscaleIphone5DeviceLength(50), kscaleIphone5DeviceLength(90), DeviceWidth-kscaleIphone5DeviceLength(100), 2)];
    self.lineImage.image =[UIImage imageNamed:@"smline"];
    self.lineImage.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.lineImage];
    
//    self.bottonMyErWeiMa = [[UIButton alloc] initWithFrame:CGRectMake(0, DeviceWidth+10+30, DeviceWidth, 30)];
//    [self.bottonMyErWeiMa setTitle:@"我的二维码" forState:(UIControlStateNormal)];
//    self.bottonMyErWeiMa.titleLabel.font = themeFont(14.0f);
//    [self.bottonMyErWeiMa setTitleColor:[UIColor colorWithRed:26/255.0 green:178/255.0 blue:10/255.0 alpha:1] forState:(UIControlStateNormal)];
//    [self.bottonMyErWeiMa addTarget:self action:@selector(bottonMyErWeiMaClicked:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self addSubview:self.bottonMyErWeiMa];
}
- (void)hiddenSubviews:(BOOL)hidden {
    self.upView.hidden =hidden;
    self.downView.hidden =hidden;
    self.leftView.hidden =hidden;
    self.rightView.hidden =hidden;
    self.imageSaoBJ.hidden =hidden;
    self.labelTips.hidden =hidden;
    self.lineImage.hidden =hidden;
    self.bottonMyErWeiMa.hidden =hidden;
}
- (void)bottonMyErWeiMaClicked:(UIButton *)btn{
//    if(self.blockMyErWeiMa){
//        self.blockMyErWeiMa();
//    }
}
@end
