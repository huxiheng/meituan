//
//  TodayStatisticsNewXHCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/22.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "TodayStatisticsNewXHCell.h"

@implementation TodayStatisticsNewXHCell
-(void)awakeFromNib{
    self.viewBG.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
    self.viewBGSecond.backgroundColor = [UIColor whiteColor];
    self.labalSuperProject.textColor = [UIColor colorWithHexString:kc00_FF6600];
    self.labalDelegateSample.textColor= [UIColor colorWithHexString:kc00_FF6600];
    self.labelSuperSample.textColor= [UIColor colorWithHexString:kc00_FF6600];
    self.labelUnqualifySample.textColor= [UIColor colorWithHexString:kc00_FF6600];
    self.imageviewBottomLine.frame = CGRectMake(0, kscaleDeviceWidth(26), kscaleIphone5DeviceLength(306), kscaleDeviceWidth(1));
}

-(void)setData:(NSDictionary *)data{
    _data = data;
    _labalSuperProject.text = _data[@"ItemName"];
    _labalDelegateSample.text = _data[@"ItemSampleCount"];
    _labelSuperSample.text = _data[@"ItemSampleFinishCount"];
    _labelUnqualifySample.text = _data[@"ItemBhgCount"];
}

- (void)reloadDataForCell:(id)model{
    
}

@end
