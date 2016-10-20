//
//  VerifyDetailNewHVCCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/5.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "VerifyDetailNewHVCCell.h"

@implementation VerifyDetailNewHVCCell
- (void)initSubviews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(40))];
    [self addSubview:self.viewBG];
    
    self.imageviewHead = [[UIImageView alloc] initWithFrame:CGRectMake(15, kscaleDeviceHeight(14), kscaleDeviceHeight(11), kscaleDeviceHeight(11))];
    self.imageviewHead.image = [UIImage imageNamed:@"unqualifiedyuan"];
    [self.viewBG addSubview:self.imageviewHead];
    
    self.labelShow = [[UILabel alloc] initWithFrame:CGRectMake(36, kscaleDeviceHeight(12), DeviceWidth-36-15, kscaleDeviceHeight(17))];
    self.labelShow.textColor = [UIColor colorWithHexString:kc00_999999];
    self.labelShow.numberOfLines = 0;
    self.labelShow.font = themeFont17;
    [self.viewBG addSubview:self.labelShow];
    
    self.viewBotttomLine = [[UIView alloc] initWithFrame:CGRectMake(0, kscaleDeviceHeight(39.5), DeviceWidth, kscaleDeviceHeight(0.5))];
    self.viewBotttomLine.backgroundColor = kcolorLine;
    [self.viewBG addSubview:self.viewBotttomLine];
}

- (void)reloadDataForCell:(id)model{
    self.model = model;
    if (((XSCellModel *)self.model).tagColor == YES) {
        self.viewBG.backgroundColor = [UIColor colorWithHexString:kcolorBJ_f0eff4];
    }else{
        self.viewBG.backgroundColor = [UIColor whiteColor];
    }
    self.labelShow.text = [NSString stringWithFormat:@"%@：%@",((XSCellModel *)self.model).title,((XSCellModel *)self.model).content];
    NSRange range1 = [self.labelShow.text rangeOfString:((XSCellModel *)self.model).content];
    [self.labelShow setAttributeText:self.labelShow.text nsrange:range1 andColorRGB:kc00_333333];
    
    CGFloat heightContent = [NSString calculateTextHeight:DeviceWidth-36-15 Content:self.labelShow.text font:themeFont17];
    heightContent = heightContent+5>28?heightContent:kscaleDeviceHeight(17);
    self.viewBG.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(23)+heightContent);
    self.labelShow.frame = CGRectMake(36, kscaleDeviceHeight(12), DeviceWidth-36-15, heightContent);
    self.viewBotttomLine.frame = CGRectMake(0, kscaleDeviceHeight(23)+heightContent-kscaleDeviceHeight(0.5), DeviceWidth, kscaleDeviceHeight(0.5));
}

@end
