//
//  WorkSiteTableViewCell.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "WorkSiteTableViewCell.h"

@implementation WorkSiteTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor whiteColor];
    self.cellStatusLabel.textColor= [UIColor colorWithHexString:kc00_7ED127];
    
    _viewWorkSiteName.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(40));
    _viewWorkStatus.frame = CGRectMake(0, kscaleDeviceHeight(40), DeviceWidth, kscaleDeviceHeight(40));
    _viewWorkSiteType.frame = CGRectMake(0, kscaleDeviceHeight(80), DeviceWidth, kscaleDeviceHeight(40));
    _viewArea.frame = CGRectMake(0, kscaleDeviceHeight(120), DeviceWidth, kscaleDeviceHeight(40));
    _viewAdress.frame = CGRectMake(0, kscaleDeviceHeight(160), DeviceWidth, kscaleDeviceHeight(40));
    _viewFooter.frame = CGRectMake(0, kscaleDeviceHeight(200), DeviceWidth, kscaleDeviceHeight(40));
    
    
    
    
    for (int i=0; i<5; i++) {
        UIView *viewLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, kscaleDeviceHeight(39.5)+kscaleDeviceHeight(40)*i, DeviceWidth, kscaleDeviceHeight(0.5))];
        viewLineBottom.backgroundColor = kcolorLine;
        [self addSubview:viewLineBottom];
    }
    self.viewFooter.backgroundColor = [UIColor colorWithHexString:kcolorBJ_f0eff4];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setData:(NSDictionary *)data{
    _data = data;
    _cellAddressLabel.text      = data[@"ProjectAddress"];
    _cellAreaLabel   .text      = data[@"ProjectRegion"];
//    _cellDataTypeLabel.text     = data[@"ProjectNature"];
    _cellStatusLabel.text       = data[@"ProjectStatus"];
    _cellWorkSiteNameLabel.text = data[@"ProjectName"];
    _cellWorkSiteTypeLabel.text = data[@"ProjectNature"];

}
+ (CGFloat)cellHeight{
    return kscaleDeviceHeight(240);
}

@end
