//
//  ApplyTableViewCell.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-27.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "VerifyCompleteTableViewCell.h"

@implementation VerifyCompleteTableViewCell

-(void)setframes{
    _viewVerify.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(40));
    _imageviewVerifyLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewSampleID.frame = CGRectMake(0, kscaleDeviceHeight(40), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewSampleIDLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewConsign.frame = CGRectMake(0, kscaleDeviceHeight(80), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewConsignLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewData.frame = CGRectMake(0, kscaleDeviceHeight(120), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewDataLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewAPPData.frame = CGRectMake(0, kscaleDeviceHeight(160), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewAPPDataLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewBottom.frame = CGRectMake(0, kscaleDeviceHeight(200), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewBottomLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
}

- (void)awakeFromNib {
    [self setframes];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setData:(NSDictionary *)data{
    _data = data;
    _cellConsignLabel.text = data[@"ConSign_ID"];
    _cellSampleIdLabel.text = data[@"Sample_ID"];
    _cellDataLabel.text = data[@"Exam_Time"];
    _cellVerifyLabel.text = data[@"Exam_User"];
    _cellAppDateLabel.text = data[@"Report_Approval_Time"];
}

+ (CGFloat)cellHeight{
    return kscaleDeviceHeight(240);
}
@end
