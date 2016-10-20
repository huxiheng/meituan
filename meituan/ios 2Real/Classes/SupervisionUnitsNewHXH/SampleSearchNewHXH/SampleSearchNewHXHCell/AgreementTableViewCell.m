//
//  AgreementTableViewCell.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "AgreementTableViewCell.h"

@implementation AgreementTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    self.cellStatusLabel.textColor = [UIColor colorWithHexString:kc00_7ED127];
    for (int i=0; i<5; i++) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(15, kscaleDeviceHeight(63.5)+kscaleDeviceHeight(40)*i ,kscaleIphone5DeviceLength(10), kscaleIphone5DeviceLength(10))];
        imageview.image = [UIImage imageNamed:@"yuanagreement"];
        [self addSubview:imageview];
    }
    
    _viewHeader.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(40));
    
    _viewStatus.frame = CGRectMake(0, kscaleDeviceHeight(40), DeviceWidth, kscaleDeviceHeight(40));
    _viewStatusInside.frame = CGRectMake(0, kscaleDeviceHeight(19), DeviceWidth, kscaleDeviceHeight(21));
    
    _viewBuildingReportNumberHealder.frame = CGRectMake(0, kscaleDeviceHeight(80), DeviceWidth, kscaleDeviceHeight(40));
    _viewBuildingReportNumberInside.frame = CGRectMake(0, kscaleDeviceHeight(19), DeviceWidth, kscaleDeviceHeight(21));
    
    _viewContractSignNumber.frame = CGRectMake(0, kscaleDeviceHeight(120), DeviceWidth, kscaleDeviceHeight(40));
    _viewContractSignNumberInsider.frame = CGRectMake(0, kscaleDeviceHeight(19), DeviceWidth, kscaleDeviceHeight(21));
    
    _viewDetectionName.frame = CGRectMake(0, kscaleDeviceHeight(160), DeviceWidth, kscaleDeviceHeight(40));
    _viewDetectionNameInside.frame = CGRectMake(0, kscaleDeviceHeight(19), DeviceWidth, kscaleDeviceHeight(21));
    
    _viewBuilderName.frame = CGRectMake(0, kscaleDeviceHeight(200), DeviceWidth, kscaleDeviceHeight(40));
    _viewBuilderNameInside.frame = CGRectMake(0, kscaleDeviceHeight(19), DeviceWidth, kscaleDeviceHeight(21));
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setData:(NSDictionary *)data{
    _data = data;
    _cellStatusLabel.text               = data[@"ContractState"];
    _cellContractSignNumberLabel.text   = [NSString stringWithFormat:@"%@", data[@"ContractSignNumber"]];
    _cellBuildingReportNumberLabel.text = data[@"BuildingReportNumber"];
    
    _cellDetectionNameLabel.text        = [NSString stringWithFormat:@"检测单位：%@",data[@"DetectionUnitName"]];
    NSString *stringDection = _cellDetectionNameLabel.text;
    NSRange range = [stringDection rangeOfString:data[@"DetectionUnitName"]];
    NSMutableAttributedString *attributeStrDection = [[NSMutableAttributedString alloc] initWithString:stringDection];
    [attributeStrDection addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:kc00_333333]} range:NSMakeRange(range.location, range.length)];
    [_cellDetectionNameLabel setAttributedText:attributeStrDection];
    
    CGFloat heightDetection = [NSString calculateTextHeight:kscaleIphone5DeviceLength(274) Content:stringDection font:themeFont15];
    
    heightRealDectection = heightDetection+5>26?heightDetection: 16;
    
    
    
    _cellBuilderNameLabel.text  = [NSString stringWithFormat:@"施工单位：%@",data[@"BuildUnitName"]];
    NSString *stringBuilder = _cellBuilderNameLabel.text;
    NSRange rangeBuilder = [stringBuilder rangeOfString:data[@"BuildUnitName"]];
    NSMutableAttributedString *attributeStrBuilder = [[NSMutableAttributedString alloc] initWithString:stringBuilder];
    [attributeStrBuilder addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:kc00_333333]} range:rangeBuilder];
    [_cellBuilderNameLabel setAttributedText:attributeStrBuilder];
    
    CGFloat height = [NSString calculateTextHeight:kscaleIphone5DeviceLength(274) Content:stringBuilder font:themeFont15];
    heightRealBuilder = height+5>30?height:16;
    
    
    _cellDetectionNameLabel.frame = CGRectMake(31, 0 , 274, kscaleDeviceHeight(heightRealDectection));
    self.imagedetectionUnitLine.frame = CGRectMake(0,kscaleDeviceHeight(heightRealDectection+4)+kscaleDeviceHeight(19) , 320, kscaleDeviceHeight(1));
    _viewDetectionNameInside.frame = CGRectMake(0, kscaleDeviceHeight(19), DeviceWidth, kscaleDeviceHeight(heightRealDectection)+kscaleDeviceHeight(5));
    _viewDetectionName.frame = CGRectMake(0, kscaleDeviceHeight(160), DeviceWidth, kscaleDeviceHeight(heightRealDectection)+kscaleDeviceHeight(5)+kscaleDeviceHeight(19));
    
    _cellBuilderNameLabel.frame=CGRectMake(31, 0 , 274, kscaleDeviceHeight(heightRealBuilder) );
    self.imageviewConstructUnitLine.frame = CGRectMake(0, kscaleDeviceHeight(heightRealBuilder+4)+kscaleDeviceHeight(19) , 320, 1);
    _viewBuilderNameInside.frame = CGRectMake(0, kscaleDeviceHeight(19), DeviceWidth, kscaleDeviceHeight(heightRealBuilder)+kscaleDeviceHeight(5));
    _viewBuilderName.frame = CGRectMake(0, kscaleDeviceHeight(160)+kscaleDeviceHeight(heightRealDectection)+kscaleDeviceHeight(5)+kscaleDeviceHeight(19), DeviceWidth, kscaleDeviceHeight(19)+kscaleDeviceHeight(heightRealBuilder)+kscaleDeviceHeight(5));
    
}

+ (CGFloat)cellHeight{
    return 207 ;
}
@end
