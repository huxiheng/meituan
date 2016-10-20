//
//  ApplyTableViewCell.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-27.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "VerifyTableViewCell.h"

@implementation VerifyTableViewCell

- (void)setFrames{
    _viewSampleID.frame = CGRectMake(0, 0, kscaleIphone5DeviceLength(270), kscaleDeviceHeight(40));
    _imageviewSampleIDLine.frame = CGRectMake(0, kscaleDeviceHeight(39), kscaleIphone5DeviceLength(270), kscaleDeviceHeight(1));
    
    _viewConsign.frame =CGRectMake(0, kscaleDeviceHeight(40), kscaleIphone5DeviceLength(270), kscaleDeviceHeight(40));
    _imageviewConsignLine.frame = CGRectMake(0, kscaleDeviceHeight(39), kscaleIphone5DeviceLength(270), kscaleDeviceHeight(1));
    
    _viewDate.frame = CGRectMake(0, kscaleDeviceHeight(80), kscaleIphone5DeviceLength(270), kscaleDeviceHeight(40));
    _imageViewBottomLine.frame =CGRectMake(0, kscaleDeviceHeight(39), kscaleIphone5DeviceLength(270), kscaleDeviceHeight(1));
    
    _viewBottomLast.frame = CGRectMake(0, kscaleDeviceHeight(120), kscaleIphone5DeviceLength(270), kscaleDeviceHeight(40));
    _imageviewBottomLastLine.frame =CGRectMake(0, DeviceWidth, kscaleIphone5DeviceLength(270), kscaleDeviceHeight(1));
    
    _btnBG.frame = CGRectMake(0, 0, kscaleIphone5DeviceLength(270), kscaleDeviceHeight(120));
    
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
    _cellSampleIdLabel.text = data[@"Sample_ID"];
    _cellDataLabel.text = data[@"Exam_Time"];
    CGFloat heightDate = [NSString calculateTextHeight:kscaleIphone5DeviceLength(149) Content:_cellDataLabel.text font:themeFont17];
    heightDate= heightDate+5>30?heightDate:kscaleDeviceHeight(17) ;
    _cellDataLabel.frame = CGRectMake(121, kscaleDeviceHeight(12), 149, heightDate);
    _viewDate.frame = CGRectMake(0, kscaleDeviceHeight(80), 270, kscaleDeviceHeight(23)+heightDate);
    _imageViewBottomLine.frame = CGRectMake(0, kscaleDeviceHeight(23)+heightDate-kscaleDeviceHeight(1), 270, kscaleDeviceHeight(1));
    _btnBG.frame = CGRectMake(0, 0, 270, kscaleDeviceHeight(23)+heightDate+kscaleDeviceHeight(80));
    self.viewBottomLast.frame = CGRectMake(0, kscaleDeviceHeight(23)+heightDate+kscaleDeviceHeight(80), 270, kscaleDeviceHeight(40));
}
- (IBAction)bgButtonDidPress:(id)sender {
    if ([_delegate respondsToSelector:@selector(verifyTableViewCellDidPress:)]) {
        [_delegate verifyTableViewCellDidPress:self];
    }
}
+ (CGFloat)cellHeight{
    return 180;
}
@end
