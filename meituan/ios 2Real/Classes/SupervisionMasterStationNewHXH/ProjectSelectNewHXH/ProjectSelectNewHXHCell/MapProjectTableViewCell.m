//
//  MapProjectTableViewCell.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-15.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "MapProjectTableViewCell.h"

@implementation MapProjectTableViewCell
- (void)setData:(NSDictionary *)data{
    _data = data;
//    _cellTitleLabel.text = data[@"stakeName"];
    NSArray *arrayTitle = [data[@"stakeName"] componentsSeparatedByString:@","];
    [arrayTitle objectAtIndex:1];
    _cellTitleLabel.text = [NSString stringWithFormat:@"工程名称：%@",[arrayTitle objectAtIndex:1]];
    
    NSString *stringProjectName = _cellTitleLabel.text;
    NSRange range1 = [stringProjectName rangeOfString:[arrayTitle objectAtIndex:1]];
    NSMutableAttributedString *attributeProjectName = [[NSMutableAttributedString alloc] initWithString:stringProjectName];
    [attributeProjectName addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:kc00_333333]} range:NSMakeRange(range1.location, range1.length)];
    [_cellTitleLabel setAttributedText:attributeProjectName];
    
    CGFloat heightTitle = [NSString calculateTextHeight:kscaleIphone5DeviceLength(290) Content:stringProjectName font:themeFont14];
    heightTitle= heightTitle+5>25?heightTitle:14;
    self.viewProjectName.frame = CGRectMake(0, 0, DeviceWidth,kscaleDeviceHeight(21)+heightTitle);
    _cellTitleLabel.frame = CGRectMake(15, 10, kscaleIphone5DeviceLength(290), heightTitle);
    self.imageViewProjectNameLine.frame = CGRectMake(0,kscaleDeviceHeight(21)+heightTitle-kscaleDeviceHeight(1), DeviceWidth,kscaleDeviceHeight(1) );
    self.viewProjectNumber.frame = CGRectMake(0,kscaleDeviceHeight(21)+heightTitle, DeviceWidth,kscaleDeviceHeight(35));
    self.VviewBottom.frame = CGRectMake(0, kscaleDeviceHeight(21)+heightTitle+kscaleDeviceHeight(35), DeviceWidth, kscaleDeviceHeight(35));
//    self.VviewBottom.frame = CGRectMake(0, 21+heightTitle+35+35, DeviceWidth, 35);
    
    
    _labelnumber.text = [arrayTitle objectAtIndex:0];
    
    _labelZuoBiao.text = [NSString stringWithFormat:@"x=%.2f    y=%.2f",[[data objectForKey:@"x"] floatValue],[[data objectForKey:@"y"] floatValue]];
}
- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    
//    [_labelLeftTitle sizeToFit];
    
    _labelnumber.textColor = [UIColor colorWithHexString:kc00_333333];
    _labelZuoBiao.textColor = [UIColor colorWithHexString:kc00_333333];
    
    _viewProjectName.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(35));
    _imageViewProjectNameLine.frame = CGRectMake(0, kscaleDeviceHeight(34), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewProjectNumber.frame = CGRectMake(0, kscaleDeviceHeight(35), DeviceWidth, kscaleDeviceHeight(35));
    _imageviewProjectNumberLine.frame = CGRectMake(0, kscaleDeviceHeight(34), DeviceWidth, kscaleDeviceHeight(1));
    
    _VviewBottom.frame = CGRectMake(0, kscaleDeviceHeight(70), DeviceWidth, kscaleDeviceHeight(35));
    _viewBottomLastLine.frame =CGRectMake(0, kscaleDeviceHeight(34), DeviceWidth, kscaleDeviceHeight(1));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)cellHeight{
    return kscaleDeviceHeight(105);
}
@end
