//
//  VASampleDeatailNewVCCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/4.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "VASampleDeatailNewVCCell.h"

@implementation VASampleDeatailNewVCCell
- (void)initSubviews{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(15, 0, DeviceWidth,kscaleDeviceHeight(40))];
    [self addSubview:self.viewBG];
    
    self.imageviewHead = [[UIImageView alloc] initWithFrame:CGRectMake(15,kscaleDeviceHeight(14), 11,11)];
    self.imageviewHead.image = [UIImage imageNamed:@"unqualifiedyuan"];
    [self.viewBG addSubview:self.imageviewHead];
    
    self.labelShow = [[UILabel alloc] initWithFrame:CGRectMake(36,kscaleDeviceHeight(12), DeviceWidth-36-15,kscaleDeviceHeight(17))];
    self.labelShow.font = themeFont17;
    self.labelShow.textColor = [UIColor colorWithHexString:kc00_999999];
    self.labelShow.numberOfLines = 0;
    [self.viewBG addSubview:self.labelShow];
    
    self.viewBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0,kscaleDeviceHeight(39.5) , DeviceWidth,kscaleDeviceHeight(0.5))];
    self.viewBottomLine.backgroundColor = kcolorLine;
    [self.viewBG addSubview:self.viewBottomLine];
    
}

- (void)reloadDataForCell:(id)model{
    self.model = model;
    if (((XSCellModel*)self.model).tagColor == YES) {
        self.viewBG.backgroundColor = [UIColor colorWithHexString:kcolorBJ_f0eff4];
    }else{
        self.viewBG.backgroundColor = [UIColor whiteColor];
    }
    self.labelShow.text = [NSString stringWithFormat:@"%@：%@",((XSCellModel*)self.model).title,((XSCellModel*)self.model).content];
    NSRange rangeRange = [_labelShow.text rangeOfString:((XSCellModel*)self.model).content];
    [_labelShow setAttributeText:_labelShow.text nsrange:rangeRange andColorRGB:kc00_333333];
    
    CGFloat heightShow = [NSString calculateTextHeight:DeviceWidth-36-15 Content:_labelShow.text font:themeFont17];
    heightShow = heightShow +5 >30?heightShow:kscaleDeviceHeight(17);
    
    self.labelShow.frame = CGRectMake(36,kscaleDeviceHeight(12), DeviceWidth-36-15, heightShow );
    self.viewBG.frame = CGRectMake(0, 0, DeviceWidth,kscaleDeviceHeight(23) +heightShow);
    self.viewBottomLine.frame = CGRectMake(0,kscaleDeviceHeight(23)+heightShow-kscaleDeviceHeight(0.5), DeviceWidth,kscaleDeviceHeight(0.5));
    
}


@end
