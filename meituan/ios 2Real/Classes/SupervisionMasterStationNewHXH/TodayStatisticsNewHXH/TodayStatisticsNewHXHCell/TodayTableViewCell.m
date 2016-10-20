//
//  TodayTableViewCell.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-28.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "TodayTableViewCell.h"

@implementation TodayTableViewCell

-(void)setframes{
    _viewSampleName.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(40));
    _imageviewSampleNameLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewSampleCount.frame = CGRectMake(0, kscaleDeviceHeight(40), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewSampleCountLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewSampleRate.frame = CGRectMake(0, kscaleDeviceHeight(80), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewSampleRateLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewSampleCompleteCount.frame = CGRectMake(0, kscaleDeviceHeight(120), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewSampleCompleteCountLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewSampleUQCount.frame = CGRectMake(0, kscaleDeviceHeight(160), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewSampleUqCountLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewSampleUcCount.frame = CGRectMake(0, kscaleDeviceHeight(200), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewSampleUcCount.frame =CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewLastBottom.frame = CGRectMake(0, kscaleDeviceHeight(240), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewLastBottomLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
}

- (void)awakeFromNib {
    [self setframes];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)cellHeight{
    return kscaleDeviceHeight(280);
}
- (void)setData:(NSDictionary *)data{
    _data = data;
    _cellSampleCompleteCountLabel.text  = data[@"DetectedSampleCount"];
    _cellSampleCountLabel.text          = data[@"SampleCollectionCount"];
    _cellSampleNameLabel.text           = data[@"ItemName"];
    _cellSampleRateLabel.text           = data[@"CompletionRate"];
    _cellSampleUqCountLabel.text        = data[@"UnqualifiedSampleCount"];
    if (!([_cellSampleCountLabel.text isEqualToString:@"-"] || [_cellSampleCompleteCountLabel.text isEqualToString:@"-"])) {
        _cellSampleUcCountLabel.text        = [NSString stringWithFormat:@"%d", [_cellSampleCountLabel.text integerValue] -  [_cellSampleCompleteCountLabel.text integerValue]];
    }
}
@end
