//
//  WorkSiteSampleNewVCCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/2.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "WorkSiteSampleNewVCCell.h"

@implementation WorkSiteSampleNewVCCell

- (void)initSubviews{
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth,kscaleDeviceHeight(33))];
    [self addSubview:self.viewBG];
    
    self.labelShow = [[UILabel alloc] initWithFrame:CGRectMake(15,kscaleDeviceHeight(10), DeviceWidth-30,kscaleDeviceHeight(13))];
    self.labelShow.font = themeFont13;
    self.labelShow.textColor = [UIColor colorWithHexString:kc00_999999];
    self.labelShow.numberOfLines = 0;
    [self.viewBG addSubview: self.labelShow];
    
    self.viewBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, kscaleDeviceHeight(32.5), DeviceWidth, kscaleDeviceHeight(0.5))];
    self.viewBottomLine.backgroundColor = kcolorLine;
    [self.viewBG addSubview:self.viewBottomLine];
}

- (void)reloadDataForCell:(id)model{
    self.model = model;
    self.labelShow.text = [NSString stringWithFormat:@"%@：%@",((XSCellModel*)self.model).title,((XSCellModel*)self.model).content];
    NSRange range = [self.labelShow.text rangeOfString:((XSCellModel*)self.model).content];
    [self.labelShow setAttributeText:self.labelShow.text nsrange:range];
    
    CGFloat heightShow = [NSString calculateTextHeight:DeviceWidth-30 Content:self.labelShow.text font:themeFont13];
    CGFloat  heightShowReal= (heightShow+5>22)?heightShow+5 :kscaleDeviceHeight(13);
    self.labelShow.frame =CGRectMake(15, kscaleDeviceHeight(10), DeviceWidth-30, heightShowReal);
    self.viewBG.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(20)+heightShowReal);
    self.viewBottomLine.frame = CGRectMake(0, kscaleDeviceHeight(20)+heightShowReal- kscaleDeviceHeight(0.5), DeviceWidth, kscaleDeviceHeight(0.5));
    if (((XSCellModel*)self.model).tagColor==YES) {
        self.viewBG.backgroundColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1.0];
    }else{
        self.viewBG.backgroundColor = [UIColor whiteColor];
    }
    
}

@end
