//
//  SampleListTableViewCell.m
//  Xieshi
//
//  Created by 明溢 李 on 14-11-18.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "UQSampleListTableViewCell.h"

@implementation UQSampleListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setData:(NSDictionary *)data{
    _sampleIdLabel .text = data[@"Sample_Id"];
    _sampleResultLabel .text = data[@"Exam_Result"];
}
+ (CGFloat)cellHeight{
    return 50;
}

@end
