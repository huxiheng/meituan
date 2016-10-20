//
//  TodayTableViewCell.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-28.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "TodayAdminTableViewCell.h"

@implementation TodayAdminTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    _cellProjectAddressLabel.numberOfLines = 0;
    _cellProjectNameLabel.numberOfLines = 0;
    
    _cellProjectStatusLabel.textColor = [UIColor colorWithHexString:kc00_7ED127];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 44, DeviceWidth, 1)];
    viewLine.backgroundColor = kcolorLine;
    //[self.viewBottom addSubview:viewLine];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    _viewProjectName.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(40));
//    _imageviewProjectNameBottomLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
//    
//    _viewProjectStatus.frame = CGRectMake(0, kscaleDeviceHeight(40), DeviceWidth, kscaleDeviceHeight(40));
//    _imageviewProjectStatusBottomLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
//    
//    _projectNature.frame = CGRectMake(0, kscaleDeviceHeight(80), DeviceWidth, kscaleDeviceHeight(40));
//    _imageviewProjectNatureBottomLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
//    
//    _viewProjectRegion.frame = CGRectMake(0, kscaleDeviceHeight(120), DeviceWidth, kscaleDeviceHeight(40));
//    _imageviewProjectRegionBottomLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
//    
//    _viewProjectAdd.frame = CGRectMake(0, kscaleDeviceHeight(160), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewProjectADDLine.frame =CGRectMake(0, (59), DeviceWidth, (1));
    
//    _viewBottom.frame =CGRectMake(0, kscaleDeviceHeight(200), DeviceWidth, kscaleDeviceHeight(40));
//    _imageviewLastBottomLine.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)cellHeight{
    return kscaleDeviceHeight(192)+kscaleDeviceHeight(10);
}
- (void)setData:(NSDictionary *)data{
    _data = data;

    _cellProjectNatureLabel.text  = data[@"ProjectNature"];
    _cellProjectRegionLabel.text  = data[@"ProjectRegion"];
    _cellProjectStatusLabel.text  = data[@"ProjectStatus"];
    
  
    _cellProjectNameLabel.text =[NSString stringWithFormat:@"%@", data[@"ProjectName"]] ;
//    NSString *stringProjectName = _cellProjectNameLabel.text;
//    NSRange range1 = [stringProjectName rangeOfString:data[@"ProjectName"]];
//    NSMutableAttributedString *attributeProjectName = [[NSMutableAttributedString alloc] initWithString:stringProjectName];
//    [attributeProjectName addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:kc00_333333]} range:NSMakeRange(range1.location, range1.length)];
//    [_cellProjectNameLabel setAttributedText:attributeProjectName];
//    CGFloat heightProjectName = [NSString calculateTextHeight:kscaleIphone5DeviceLength(269) Content:stringProjectName    font:themeFont17];
//    heightProjectName = heightProjectName+5>35? heightProjectName :kscaleDeviceHeight(17);
//    self.viewProjectName.frame = CGRectMake(0, 0, DeviceWidth, heightProjectName+kscaleDeviceHeight(23));
//    self.imageviewProjectNameBottomLine.frame = CGRectMake(0,kscaleDeviceHeight(12) +heightProjectName+kscaleDeviceHeight(10), DeviceWidth, kscaleDeviceHeight(1));
//    _cellProjectNameLabel.frame = CGRectMake(36,kscaleDeviceHeight(12), kscaleIphone5DeviceLength(269), heightProjectName);
//    self.viewProjectStatus.frame = CGRectMake(0, heightProjectName+kscaleDeviceHeight(23), DeviceWidth,kscaleDeviceHeight(40));
//    self.projectNature.frame = CGRectMake(0,  heightProjectName+kscaleDeviceHeight(23)+kscaleDeviceHeight(40), DeviceWidth,kscaleDeviceHeight(40));
//    self.viewProjectRegion.frame = CGRectMake(0, heightProjectName+kscaleDeviceHeight(23)+kscaleDeviceHeight(40)+kscaleDeviceHeight(40) , DeviceWidth,kscaleDeviceHeight(40));
    
    _cellProjectAddressLabel.text = [NSString stringWithFormat:@"%@", data[@"ProjectAddress"]] ;
//    NSString *stringProjectAdd = _cellProjectAddressLabel.text;
//    NSRange range2 = [stringProjectAdd rangeOfString:data[@"ProjectAddress"]];
//    NSMutableAttributedString *attributeProjectadd = [[NSMutableAttributedString alloc] initWithString:stringProjectAdd];
//    [attributeProjectadd addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:kc00_333333]} range:NSMakeRange(range2.location, range2.length)];
//    [_cellProjectAddressLabel setAttributedText:attributeProjectadd];
//    CGFloat heightProjectadd = [NSString calculateTextHeight:kscaleIphone5DeviceLength(269) Content:stringProjectAdd    font:themeFont17];
//    heightProjectadd = heightProjectadd+5>35? heightProjectadd :kscaleDeviceHeight(17);
//    self.viewProjectAdd.frame = CGRectMake(0, heightProjectName+kscaleDeviceHeight(23)+kscaleDeviceHeight(40)+kscaleDeviceHeight(40) +kscaleDeviceHeight(40), DeviceWidth, heightProjectadd+kscaleDeviceHeight(23));
//    self.imageviewProjectADDLine.frame = CGRectMake(0,kscaleDeviceHeight(12)+heightProjectadd+kscaleDeviceHeight(10), DeviceWidth,kscaleDeviceHeight(1));
//    _cellProjectAddressLabel.frame = CGRectMake(36,kscaleDeviceHeight(12) , kscaleIphone5DeviceLength(269), heightProjectadd);
//    self.viewBottom.frame = CGRectMake(0, heightProjectName+kscaleDeviceHeight(23) +kscaleDeviceHeight(40)+kscaleDeviceHeight(40) +kscaleDeviceHeight(40)+heightProjectadd+kscaleDeviceHeight(23) , 0,kscaleDeviceHeight(40));
    
}
- (IBAction)titleButtonDidPress:(id)sender{
    if ([_deleagte respondsToSelector:@selector(todayAdminTableViewCellTitleDidPress:)]) {
        [_deleagte todayAdminTableViewCellTitleDidPress:self];
    }
}

@end
