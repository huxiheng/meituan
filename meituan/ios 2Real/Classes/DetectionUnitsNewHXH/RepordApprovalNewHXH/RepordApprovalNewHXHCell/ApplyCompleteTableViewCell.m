//
//  ApplyTableViewCell.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-28.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "ApplyCompleteTableViewCell.h"

@implementation ApplyCompleteTableViewCell

- (void)setFrames{
    _viewVerify.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(40));
    _imageviewVerifyLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewConsign.frame = CGRectMake(0, kscaleDeviceHeight(40), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewConsignLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewReportID.frame = CGRectMake(0, kscaleDeviceHeight(80), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewReportIDLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewDate.frame = CGRectMake(0, kscaleDeviceHeight(120), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewDateLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewAPPdate.frame = CGRectMake(0, kscaleDeviceHeight(160), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewAPPDateLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewLast.frame = CGRectMake(0, kscaleDeviceHeight(200), DeviceWidth, kscaleDeviceHeight(40));
    _imageViewLastLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
}

- (void)awakeFromNib {
    [self setFrames];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (void)setData:(NSDictionary *)data{
    _data = data;
    _cellConsignLabel.text = data[@"ConSign_ID"];
    _cellAppDateLabel.text = data[@"Report_Audit_Time"];
    _cellDateLabel.text    = data[@"Report_CreateDate"];
    _cellReportIdLabel.text= data[@"Report_ID"];
    _cellVerifyLabel.text  = data[@"AuditUser"];
}
+ (CGFloat)cellHeight{
    return kscaleDeviceHeight(240);
}
@end
