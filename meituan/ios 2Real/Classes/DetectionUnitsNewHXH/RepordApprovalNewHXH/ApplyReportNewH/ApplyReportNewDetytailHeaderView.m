//
//  ApplyReportNewDetytailHeaderView.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/4.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "ApplyReportNewDetytailHeaderView.h"

@implementation ApplyReportNewDetytailHeaderView
- (void)initSubviews{
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 62)];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.viewBG];
    
    self.imageViewHeader = [[UIImageView alloc] initWithFrame:CGRectMake(15, 13, 42, 36)];
    self.imageViewHeader.image = [UIImage imageNamed:@"applyReportImageNewyangpin"];
    [self.viewBG addSubview:self.imageViewHeader];
    
    self.imageviewEntrance = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceWidth-15-10, 23, 10, 17)];
    self.imageviewEntrance.image = [UIImage imageNamed:@"unqualifyreportResultnext1"];
    [self.viewBG addSubview:self.imageviewEntrance];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(72, 0, DeviceWidth-72-15-10-10, 62)];
    self.labelTitle.font = themeFont17;
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_38CB1A];
    self.labelTitle.text = @"查看样品";
    [self.viewBG addSubview:self.labelTitle];
    
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickViewBG:)];
    tap.cancelsTouchesInView = NO;
    [self.viewBG addGestureRecognizer:tap];
    
    [self addLineView:CGRectMake(0, 61.5, DeviceWidth, 0.5)];
    
}

- (void)clickViewBG:(id)sender{
    self.blockClickBG();
}

@end
