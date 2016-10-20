//
//  ReportTableViewCell.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "ReportProjectTableViewCell.h"

@implementation ReportProjectTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    UIView *viewBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 44, DeviceWidth, 1)];
    viewBottomLine.backgroundColor = kcolorLine;
   // [self.viewBottom addSubview:viewBottomLine];
    
    _cellReportIDLabel.textColor = [UIColor colorWithHexString:kc00_007EFF];
    
    _viewreportID.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(40));
    _imageviewReportIdLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewMemberName.frame = CGRectMake(0, kscaleDeviceHeight(40), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewMemberLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewContracter.frame =CGRectMake(0, kscaleDeviceHeight(80), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewContracterLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewPhone.frame =CGRectMake(0, kscaleDeviceHeight(120), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewPhoneLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewSuperViser.frame =CGRectMake(0, kscaleDeviceHeight(160), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewSuperViserLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewProjectName.frame = CGRectMake(0, kscaleDeviceHeight(200), DeviceWidth, kscaleDeviceHeight(40));
    _imageViewProjectNameBottomLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewConstructionUnit.frame =CGRectMake(0, kscaleDeviceHeight(240), DeviceWidth, kscaleDeviceHeight(40));
    _imageViewConstructionUnitLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewBuildUnite.frame =CGRectMake(0, kscaleDeviceHeight(280), DeviceWidth, kscaleDeviceHeight(40));
    _imageViewBuildUnitLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewSuperverUnite.frame =CGRectMake(0, kscaleDeviceHeight(320), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewSuperviserUniteLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewSuperVisiorKey.frame =CGRectMake(0, kscaleDeviceHeight(360), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewSuperVisiorKeyLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewDateTime.frame =CGRectMake(0, kscaleDeviceHeight(400), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewDateLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewBottom.frame =CGRectMake(0, kscaleDeviceHeight(440), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewBottomLastLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)cellHeight{
    return kscaleDeviceHeight(480) ;
}

- (void)setData:(NSDictionary *)data{
    _data = data;
    _cellReportIDLabel.text = data[@"ReportId"];
    _cellModifyTimeLabel.text   = data[@"ModifyTime"];
    _cellContacterLabel.text    = data[@"Linkman"];
    _cellPhoneLabel.text        = data[@"Tel"];
    _cellMemberIdLabel.text     = data[@"MemberId"];
    _cellIsSuperviserLabel.text = data[@"IsSuperviser"];
    
    _cellProjectNameLabel.text =[NSString stringWithFormat:@"工程名称：%@",data[@"ProjectName"]] ;
    NSString *stringProjectName = _cellProjectNameLabel.text;
    NSRange range1 = [stringProjectName rangeOfString:data[@"ProjectName"]];
    NSMutableAttributedString *attributeProjectName = [[NSMutableAttributedString alloc] initWithString:stringProjectName];
    [attributeProjectName addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:kc00_333333]} range:NSMakeRange(range1.location, range1.length)];
    [_cellProjectNameLabel setAttributedText:attributeProjectName];
    CGFloat heightProjectName = [NSString calculateTextHeight:kscaleIphone5DeviceLength(269) Content:stringProjectName    font:themeFont17];
    heightProjectName = heightProjectName+5>35?heightProjectName:kscaleDeviceHeight(17);

    self.viewProjectName.frame = CGRectMake(0,kscaleDeviceHeight(200), DeviceWidth, heightProjectName+kscaleDeviceHeight(23));
    _cellProjectNameLabel.frame = CGRectMake(36, kscaleDeviceHeight(12), kscaleIphone5DeviceLength(269), heightProjectName);
    self.imageViewProjectNameBottomLine.frame = CGRectMake(0,kscaleDeviceHeight(12)+heightProjectName+kscaleDeviceHeight(10)    , DeviceWidth, kscaleDeviceHeight(1));
    
    _cellConstructionUnitLabel.text = [NSString stringWithFormat:@"建设单位：%@",data[@"ConstructionUnit"]] ;
    NSString *stringContructionUnit = _cellConstructionUnitLabel.text;
    NSRange range2 = [stringContructionUnit rangeOfString:data[@"ConstructionUnit"]];
    NSMutableAttributedString *attributeContructionUnit = [[NSMutableAttributedString alloc] initWithString:stringContructionUnit];
    [attributeContructionUnit addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:kc00_333333]} range:NSMakeRange(range2.location, range2.length)];
    [_cellConstructionUnitLabel setAttributedText:attributeContructionUnit];
    CGFloat heightcontructionUnit = [NSString calculateTextHeight:kscaleIphone5DeviceLength(269) Content:stringContructionUnit    font:themeFont17];
    heightcontructionUnit = heightcontructionUnit+5>35?heightcontructionUnit:kscaleDeviceHeight(17);
    self.viewConstructionUnit.frame = CGRectMake(0,kscaleDeviceHeight(200) +heightProjectName+kscaleDeviceHeight(23), DeviceWidth, heightcontructionUnit+kscaleDeviceHeight(23));
    _cellConstructionUnitLabel.frame = CGRectMake(36, kscaleDeviceHeight(12), kscaleIphone5DeviceLength(269), heightcontructionUnit);
    self.imageViewConstructionUnitLine.frame = CGRectMake(0,kscaleDeviceHeight(12)+heightcontructionUnit+kscaleDeviceHeight(10), DeviceWidth,kscaleDeviceHeight(1));
    
     _cellBuildUnitLabel.text = [NSString stringWithFormat:@"施工单位：%@",data[@"BuildUnit"]] ;
    NSString *stringBuildUnit = _cellBuildUnitLabel.text;
    NSRange range3 = [stringBuildUnit rangeOfString:data[@"BuildUnit"]];
    NSMutableAttributedString *attributeBuildUnit = [[NSMutableAttributedString alloc] initWithString:stringBuildUnit];
    [attributeBuildUnit addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:kc00_333333]} range:NSMakeRange(range3.location, range3.length)];
    [_cellBuildUnitLabel setAttributedText:attributeBuildUnit];
    CGFloat heightBuildUnit = [NSString calculateTextHeight:kscaleIphone5DeviceLength(269) Content:stringBuildUnit    font:themeFont17];
    heightBuildUnit = heightBuildUnit+5>35?heightBuildUnit:kscaleDeviceHeight(17);
    self.viewBuildUnite.frame = CGRectMake(0,kscaleDeviceHeight(200)+heightProjectName+kscaleDeviceHeight(23)+heightcontructionUnit+kscaleDeviceHeight(23), DeviceWidth, heightBuildUnit+kscaleDeviceHeight(23));
    _cellBuildUnitLabel.frame = CGRectMake(36, kscaleDeviceHeight(12), kscaleIphone5DeviceLength(269), heightBuildUnit);
    self.imageViewBuildUnitLine.frame = CGRectMake(0,kscaleDeviceHeight(12) +heightBuildUnit+kscaleDeviceHeight(10), DeviceWidth,kscaleDeviceHeight(1));
    
    _cellSupervisorUnitLabel.text = [NSString stringWithFormat:@"监督单位：%@",data[@"SupervisorUnit"]] ;
    NSString *stringSupervisorUnit = _cellSupervisorUnitLabel.text;
    NSRange range4 = [stringSupervisorUnit rangeOfString:data[@"SupervisorUnit"]];
    NSMutableAttributedString *attributeSupervisorUnit = [[NSMutableAttributedString alloc] initWithString:stringSupervisorUnit];
    [attributeSupervisorUnit addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:kc00_333333]} range:NSMakeRange(range4.location, range4.length)];
    [_cellSupervisorUnitLabel setAttributedText:attributeSupervisorUnit];
    CGFloat heightSuperVisorUnit = [NSString calculateTextHeight:kscaleIphone5DeviceLength(269) Content:stringSupervisorUnit    font:themeFont17];
    heightSuperVisorUnit = heightSuperVisorUnit+5>35?heightSuperVisorUnit:kscaleDeviceHeight(17);
    self.viewSuperverUnite.frame = CGRectMake(0,kscaleDeviceHeight(200)+heightProjectName+kscaleDeviceHeight(23) +heightcontructionUnit+kscaleDeviceHeight(23)+heightBuildUnit+kscaleDeviceHeight(23), DeviceWidth, heightSuperVisorUnit+kscaleDeviceHeight(23));
    _cellSupervisorUnitLabel.frame = CGRectMake(36, kscaleDeviceHeight(12), kscaleIphone5DeviceLength(269), heightSuperVisorUnit);
    self.imageviewSuperviserUniteLine.frame = CGRectMake(0,kscaleDeviceHeight(12)+heightSuperVisorUnit+kscaleDeviceHeight(10) , DeviceWidth,kscaleDeviceHeight(1));
    
    _cellSuperviserKeyLabel.text =  [NSString stringWithFormat:@"质监站：%@",data[@"SuperviserKey"]] ;
    NSString *stringSupervisorkey = _cellSuperviserKeyLabel.text;
    NSRange range5 = [stringSupervisorkey rangeOfString:data[@"SuperviserKey"]];
    NSMutableAttributedString *attributeSupervisorKey = [[NSMutableAttributedString alloc] initWithString:stringSupervisorkey];
    [attributeSupervisorKey addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:kc00_333333]} range:NSMakeRange(range5.location, range5.length)];
    [_cellSuperviserKeyLabel setAttributedText:attributeSupervisorKey];
    CGFloat heightSuperVisorKey = [NSString calculateTextHeight:kscaleIphone5DeviceLength(269) Content:stringSupervisorkey    font:themeFont17];
    heightSuperVisorKey = heightSuperVisorKey+5>35?heightSuperVisorUnit:kscaleDeviceHeight(17);
    self.viewSuperVisiorKey.frame = CGRectMake(0, kscaleDeviceHeight(200) +heightProjectName+kscaleDeviceHeight(23)+heightcontructionUnit+kscaleDeviceHeight(23)+heightBuildUnit+kscaleDeviceHeight(23)+heightSuperVisorUnit+kscaleDeviceHeight(23), DeviceWidth, heightSuperVisorKey+kscaleDeviceHeight(23));
    _cellSuperviserKeyLabel.frame = CGRectMake(36, kscaleDeviceHeight(12), kscaleIphone5DeviceLength(269), heightSuperVisorKey);
    self.imageviewSuperVisiorKeyLine.frame = CGRectMake(0,kscaleDeviceHeight(12)+heightSuperVisorKey+kscaleDeviceHeight(10) , DeviceWidth,kscaleDeviceHeight(1) );
    
    self.viewDateTime.frame = CGRectMake(0,kscaleDeviceHeight(200) +heightProjectName+kscaleDeviceHeight(23) +heightcontructionUnit+kscaleDeviceHeight(23) +heightBuildUnit+kscaleDeviceHeight(23)+heightSuperVisorUnit+kscaleDeviceHeight(23) +heightSuperVisorKey+kscaleDeviceHeight(23) , DeviceWidth,kscaleDeviceHeight(40));
    self.viewBottom.frame = CGRectMake(0,kscaleDeviceHeight(200) +heightProjectName+kscaleDeviceHeight(23) +heightcontructionUnit+kscaleDeviceHeight(23) +heightBuildUnit+kscaleDeviceHeight(23)+heightSuperVisorUnit+kscaleDeviceHeight(23) +heightSuperVisorKey+kscaleDeviceHeight(23)+kscaleDeviceHeight(40), DeviceWidth,kscaleDeviceHeight(40));
}
@end
