//
//  TodayAdminDetailTableViewCell.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-3-23.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "TodayAdminDetailTableViewCell.h"

@implementation TodayAdminDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    
    _viewProjectName.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(40));
    _imageviewProjectNameBottomLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewProjectHeGeLv.frame = CGRectMake(0, kscaleDeviceHeight(40), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewHeGeLvBottomLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewJianCeZuShu.frame = CGRectMake(0, kscaleDeviceHeight(80), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewJianCeZuShuBottomLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewJianCeBuHeGeShu.frame = CGRectMake(0, kscaleDeviceHeight(120), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewJianCeBuHeGeShuLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewLaStBottom.frame =CGRectMake(0, kscaleDeviceHeight(160), DeviceWidth, kscaleDeviceHeight(40));
    _ImagevoiewBottomLastLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(NSDictionary *)data{
    _data = data;
    _cellCountLabel .text = [NSString stringWithFormat:@"合格率:%@",data[@"QualifiedRate"]];
    _cellTitleLabel .text = data[@"ItemName"];
    _cellQPercentLabel.text = data[@"DetectedSampleCount"];
    _cellUQPercentLabel.text = data[@"UnqualifiedSampleCount"];
}
+ (CGFloat)cellHeight{
    return kscaleDeviceHeight(200);
}
@end
