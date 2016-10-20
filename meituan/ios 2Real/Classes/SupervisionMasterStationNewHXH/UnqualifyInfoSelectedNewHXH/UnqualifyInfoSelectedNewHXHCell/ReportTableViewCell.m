//
//  ReportTableViewCell.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "ReportTableViewCell.h"

@implementation ReportTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
//    UIView *viewBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 44, DeviceWidth, 1)];
//    viewBottomLine.backgroundColor = kcolorLine;
//    [self.viewBottom addSubview:viewBottomLine];
    
    _statusLabel.textColor = [UIColor colorWithHexString:kc00_7ED127];
    _reportIdLabel.textColor = [UIColor colorWithHexString:kc00_333333];
    _checkCodeLabel.textColor = [UIColor colorWithHexString:kc00_333333];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _viewReportNumber.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(40));
    _imageviewResultNumberLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth,kscaleDeviceHeight(1));
    
    _viewProjectName.frame = CGRectMake(0, kscaleDeviceHeight(40), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewProjectNameBottomLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewCheckStatus.frame = CGRectMake(0, kscaleDeviceHeight(80), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewCheckStatusLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewhandlingStatus.frame =CGRectMake(0, kscaleDeviceHeight(120), DeviceWidth, kscaleDeviceHeight(40));
    _imgeviewHandStatusLine.frame = _imageviewBottomLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewBottom.frame = CGRectMake(0, kscaleDeviceHeight(160), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewBottomLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)cellHeight{
    return kscaleDeviceHeight(200);
}

- (void)setData:(NSDictionary *)data{
    _data = data;
    
    _reportIdLabel.text = data[@"Report_ID"];
    _projectNameLabel.text=[NSString stringWithFormat:@"工程名称：%@",data[@"ProJectName"]];
    NSString *stringProjectName = _projectNameLabel.text;
    NSRange range = [stringProjectName rangeOfString:data[@"ProJectName"]];
    NSMutableAttributedString *attributeProjectName = [[NSMutableAttributedString alloc] initWithString:stringProjectName];
    [attributeProjectName addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:kc00_333333]} range:NSMakeRange(range.location, range.length)];
    [_projectNameLabel setAttributedText:attributeProjectName];
    
    CGFloat heightProjectName = [NSString calculateTextHeight:kscaleIphone5DeviceLength(269) Content:stringProjectName    font:themeFont17];
    
    heightProjectName = heightProjectName+5>35?heightProjectName:kscaleDeviceHeight(17);
    self.viewReportNumber.frame = CGRectMake(0, 0, DeviceWidth,kscaleDeviceHeight(40));
    self.viewProjectName.frame = CGRectMake(0,kscaleDeviceHeight(40) , DeviceWidth,kscaleDeviceHeight(23)+heightProjectName);
    _projectNameLabel.frame = CGRectMake(36,kscaleDeviceHeight(12), kscaleIphone5DeviceLength(269), heightProjectName);
    self.imageviewProjectNameBottomLine.frame = CGRectMake(0,kscaleDeviceHeight(23)+heightProjectName-kscaleDeviceHeight(1) , DeviceWidth, kscaleDeviceHeight(1));
    self.viewCheckStatus.frame = CGRectMake(0,kscaleDeviceHeight(40)+kscaleDeviceHeight(23)+heightProjectName, DeviceWidth,kscaleDeviceHeight(40) );
    self.viewhandlingStatus.frame = CGRectMake(0, kscaleDeviceHeight(40)+kscaleDeviceHeight(23)+heightProjectName+kscaleDeviceHeight(40), DeviceWidth, kscaleDeviceHeight(40));
    self.viewBottom.frame = CGRectMake(0, kscaleDeviceHeight(40)+kscaleDeviceHeight(23)+heightProjectName+kscaleDeviceHeight(40)+kscaleDeviceHeight(40), DeviceWidth,kscaleDeviceHeight(40));
    
    _checkCodeLabel.text = data[@"IdentifyingCode"];
    NSArray *uqExecStatusMapper = @[@"未处理",@"已处理",@"处理中"];
    @try {
        _statusLabel.text = uqExecStatusMapper[[data[@"UqExecStatus"] integerValue]];
    }
    @catch (NSException *exception) {
        _statusLabel.text = @"异常";
    }
   


}

@end
