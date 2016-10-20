//
//  SampleListTableViewCell.m
//  Xieshi
//
//  Created by 明溢 李 on 14-11-18.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "VASampleListTableViewCell.h"

@implementation VASampleListTableViewCell

-(void)setFrames{
    _viewSampleID.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(40));
    _imageviewSampleIDLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewSampleName.frame = CGRectMake(0, kscaleDeviceHeight(40), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewBottomLineProName.frame =  CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewButton.frame = CGRectMake(0, kscaleDeviceHeight(80), DeviceWidth, kscaleDeviceHeight(40));
    _imageViewButtonLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
    _viewBottom.frame = CGRectMake(0, kscaleDeviceHeight(120), DeviceWidth, kscaleDeviceHeight(40));
    _imageviewBottomLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    
}

- (void)awakeFromNib {
    // Initialization code
    [self setFrames];
    self.backgroundColor=[UIColor clearColor];
    UIView *viewVerLine =[[UIView alloc] initWithFrame:CGRectMake(159, 5, 1, 30)];
    viewVerLine.backgroundColor = [UIColor colorWithHexString:kcolorBJ_f0eff4];
    [self.viewButton addSubview:viewVerLine];
    
    [_btnProperty setTitleColor:[UIColor colorWithHexString:kc00_007EFF] forState:UIControlStateNormal];
    [_buttonDetailInfo setTitleColor:[UIColor colorWithHexString:kc00_007EFF] forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)data{
    _data = data;
    _sampleIdLabel .text = data[@"Sample_Id"];
//    _sampleNameLabel .text = data[@"SampleName"];
    _sampleNameLabel .text = [NSString stringWithFormat:@"工程名称：%@",data[@"SampleName"]];
    NSRange rangeRange = [_sampleNameLabel.text rangeOfString:data[@"SampleName"]];
    [_sampleNameLabel setAttributeText:_sampleNameLabel.text nsrange:rangeRange];
    CGFloat heightName = [NSString calculateTextHeight:kscaleIphone5DeviceLength(269) Content:_sampleNameLabel.text font:themeFont17];
    heightName = heightName+5>30?heightName:kscaleDeviceHeight(17);
    self.viewSampleName.frame = CGRectMake(0, kscaleDeviceHeight(40), DeviceWidth, kscaleDeviceHeight(23)+heightName);
    self.imageviewBottomLineProName.frame = CGRectMake(0, kscaleDeviceHeight(23)+heightName-kscaleDeviceHeight(1), DeviceWidth, kscaleDeviceHeight(1));
    self.viewButton.frame = CGRectMake(0, kscaleDeviceHeight(40)+kscaleDeviceHeight(23)+heightName, DeviceWidth, kscaleDeviceHeight(40));
    self.viewBottom.frame = CGRectMake(0, kscaleDeviceHeight(40)+kscaleDeviceHeight(23)+heightName+kscaleDeviceHeight(40), DeviceWidth, kscaleDeviceHeight(40));
    
}

+ (CGFloat)cellHeight{
    return 138;
}
- (IBAction)detailButtonDidPress:(id)sender {
    if([_delegate respondsToSelector:@selector(sampleListTableViewCell:detailButtonDidPress:)]){
        [_delegate sampleListTableViewCell:self detailButtonDidPress:sender];
    }
}
- (IBAction)propertyButtonDidPress:(id)sender {
    if ([_delegate respondsToSelector:@selector(sampleListTableViewCell:propertyButtonDidPress:)]) {
        [_delegate sampleListTableViewCell:self propertyButtonDidPress:sender];
    }
}

@end
