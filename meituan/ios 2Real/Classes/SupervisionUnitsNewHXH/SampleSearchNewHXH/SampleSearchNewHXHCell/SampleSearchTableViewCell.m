//
//  SampleSearchTableViewCell.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "SampleSearchTableViewCell.h"


@implementation SampleSearchTableViewCell

- (void)awakeFromNib {
    self.viewCellBGBig.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:242.0/255.0 blue:238.0/255.0 alpha:1.0];
    self.viewCellBGSecond.layer.cornerRadius = 5;
    self.viewCellBGSecond.layer.masksToBounds = YES;
    
    _cellExamResultLabel.textColor = [UIColor colorWithHexString:kc00_FE4C4D];
    _cellExamResultLabel.frame = CGRectMake(200, kscaleDeviceHeight(61), 75, kscaleDeviceHeight(11));
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIndexPathSampleSearch:(NSIndexPath *)indexPathSampleSearch{
    
    if (indexPathSampleSearch.row%2==0) {

    }else {

    }
}

- (void)setData:(NSDictionary *)data{
    _data = data;
    _cellDateLabel.text = data[@"CreateDateTime"];
    _cellSampleStatusLabel.text = data[@"Sample_Status"];
    _cellSampleNameLabel.text = data[@"SampleName"];
    _cellExamResultLabel.text = data[@"Exam_Result"];
    cellDelegateQuan.text = data[@"Delegate_Quan"];
    cellSpecName.text = data[@"SpecName"];
    cellGradeName.text = data[@"GradeName"];
    cellProjectPart.text = data[@"ProJect_Part"];
    
    
}

+ (CGFloat)cellHeight{
    return 114;
}
@end
