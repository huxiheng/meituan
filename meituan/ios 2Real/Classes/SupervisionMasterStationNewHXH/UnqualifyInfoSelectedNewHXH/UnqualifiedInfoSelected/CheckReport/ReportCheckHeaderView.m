//
//  ReportCheckHeaderView.m
//  Xieshi
//
//  Created by Tesiro on 16/7/13.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "ReportCheckHeaderView.h"

@implementation ReportCheckHeaderView

- (void)initSubviews {
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 65)];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.viewBG];
    
    self.imageViewHeade = [[UIImageView alloc] initWithFrame:CGRectMake(kscaleDeviceLength(18), 11, 42, 42)];
    self.imageViewHeade.image = [UIImage imageNamed:@"unqualifybaogaojielun"];
    [self.viewBG addSubview:self.imageViewHeade];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(kscaleDeviceLength(39)+42, 22, DeviceWidth-42-kscaleDeviceLength(80), 21)];
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_38CB1A];
    self.labelTitle.text = @"报告结论";
    self.labelTitle.font = themeFont18;
    [self.viewBG addSubview:self.labelTitle];
    
    self.imageViewEntrance = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceWidth-kscaleDeviceLength(40), 23, 10, 18)];
    self.imageViewEntrance.image = [UIImage imageNamed:@"unqualifyreportResultnext1"];
    [self.contentView addSubview:self.imageViewEntrance];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewBG:)];
    tap.cancelsTouchesInView = NO;
    [self.viewBG addGestureRecognizer:tap];
    
    [self addLineView:CGRectMake(0, 64.5, DeviceWidth, 0.5)];
    
}

- (void)tapViewBG:(UITapGestureRecognizer *)clickTap {
    self.blockClickBG();
}

@end
