//
//  ApplyTableViewCell.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-28.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "ApplyTableViewCell.h"

@implementation ApplyTableViewCell

-(void)setFrames{
    _viewConsign.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(40));
    _imageviewConsignLine.frame = CGRectMake(0, kscaleDeviceHeight(39), kscaleIphone5DeviceLength(270), kscaleDeviceHeight(1));
    
    _viewReportID.frame = CGRectMake(0, kscaleDeviceHeight(40), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewReportIDLine.frame =CGRectMake(0, kscaleDeviceHeight(39), kscaleIphone5DeviceLength(270), kscaleDeviceHeight(1));
    
    _viewDate.frame = CGRectMake(0, kscaleDeviceHeight(80), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewBottomDateLine.frame =CGRectMake(0, kscaleDeviceHeight(39), kscaleIphone5DeviceLength(270), kscaleDeviceHeight(1));
    
    _viewBottomLast.frame =CGRectMake(0, kscaleDeviceHeight(120), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewBottomLastLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
}

- (void)awakeFromNib {
    [self setFrames];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    _cellSelectedImageView.highlighted = selected;

}
- (void)setData:(NSDictionary *)data{
    _data = data;
    _cellConsignLabel.text = data[@"ConSign_ID"];
    _cellReportIdLabel.text= data[@"Report_ID"];
    _cellDateLabel.text    = data[@"Report_CreateDate"];
    CGFloat heightDate = [NSString calculateTextHeight:kscaleIphone5DeviceLength(149) Content:_cellDateLabel.text font:themeFont17];
    heightDate= heightDate+5>30?heightDate:17;
    _cellDateLabel.frame = CGRectMake(121, 12, 149, heightDate);
    _viewDate.frame = CGRectMake(0,kscaleDeviceHeight(80),kscaleIphone5DeviceLength(270), kscaleDeviceHeight(23)+heightDate);
    _imageviewBottomDateLine.frame = CGRectMake(0, kscaleDeviceHeight(23)+heightDate-kscaleDeviceHeight(1),kscaleIphone5DeviceLength(270), kscaleDeviceHeight(1));
    
    _btnBG.frame = CGRectMake(0, 0,kscaleDeviceHeight(270) , kscaleDeviceHeight(23)+heightDate+kscaleDeviceHeight(80));
    self.viewBottomLast.frame = CGRectMake(0, kscaleDeviceHeight(23)+heightDate+kscaleDeviceHeight(80), 270, kscaleDeviceHeight(40));
    _imageviewBottomLastLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
}
+ (CGFloat)cellHeight{
    return 180;
}
- (IBAction)bgButtonDidPress:(id)sender {
    if ([_delegate respondsToSelector:@selector(applyTableViewCellDidPress:)]) {
        [_delegate applyTableViewCellDidPress:self];
    }
}
@end
