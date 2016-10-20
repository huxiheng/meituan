//
//  TodayStatisticsNewXHHeaderview.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/22.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "TodayStatisticsNewXHHeaderview.h"

@implementation TodayStatisticsNewXHHeaderview

- (void)subviewFrame{
    //    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(81))];
    //    self.viewBG.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0];
    //    [self addSubview:self.viewBG];
    //
    //    self.viewBGSecond = [[UIView alloc] initWithFrame:CGRectMake(kscaleDeviceWidth(7), kscaleDeviceHeight(8), DeviceWidth-kscaleDeviceWidth(14), kscaleDeviceHeight(65))];
    //    self.viewBGSecond.backgroundColor = [UIColor whiteColor];
    //    self.viewBGSecond.layer.cornerRadius = 3;
    //    self.viewBGSecond.layer.masksToBounds = YES;
    //    [self.viewBG addSubview:self.viewBGSecond];
    //
    //    self.imageViewHead = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth-kscaleDeviceWidth(14), kscaleDeviceHeight(22))];
    //    self.imageViewHead.backgroundColor = [UIColor colorWithRed:109.0/255.0 green:196.0/255.0 blue:232.0/255.0 alpha:1.0];
    //    [self.viewBGSecond addSubview:self.imageViewHead];
    //
    //    UILabel *labelHead = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth-kscaleDeviceWidth(14), kscaleDeviceHeight(22))];
    //    labelHead.textColor = [UIColor whiteColor];
    //    labelHead.textAlignment = NSTextAlignmentCenter;
    //    labelHead.font = themeFont12;
    //    labelHead.text = @"已委托的样品数";
    //    labelHead.backgroundColor = [UIColor clearColor];
    //    [self.imageViewHead addSubview:labelHead];
    //
    //    UIView *viewThird = [[UIView alloc] initWithFrame:CGRectMake(0, kscaleDeviceHeight(22), DeviceWidth-kscaleDeviceWidth(14), kscaleDeviceHeight(43))];
    //    [self.viewBGSecond addSubview:viewThird];
    //
    //    UILabel *labelProjectSamTitle = [[UILabel alloc] initWithFrame:CGRectMake(kscaleDeviceWidth(19), kscaleDeviceHeight(5), kscaleDeviceWidth(85), kscaleDeviceHeight(12))];
    //    labelProjectSamTitle.font = themeFont12;
    //    labelProjectSamTitle.text = @"工程验收样品";
}

- (void)awakeFromNib{
    self.viewBG.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
    self.viewBGSecond.layer.cornerRadius = 3;
    self.viewBGSecond.layer.masksToBounds = YES;
    self.viewBGSecondHead.backgroundColor = [UIColor colorWithRed:109.0/255.0 green:196.0/255.0 blue:232.0/255.0 alpha:1.0];
    
    self.labelTime.textColor = [UIColor colorWithHexString:kc00_ff7e00];
}

- (void)reloadDataForView:(id)model{
    self.model = model;
    _labelProjectSample.text = ((NSDictionary*)self.model)[@"Day_ImportSampleCount"];
    _labelNotProjectSample.text =((NSDictionary*)self.model)[@"Day_FgSample"];
    _labelSuperSample.text =((NSDictionary*)self.model)[@"Day_JdSample"];
    _labelTime.text =((NSDictionary*)self.model)[@"RecordTime"];
}
@end
