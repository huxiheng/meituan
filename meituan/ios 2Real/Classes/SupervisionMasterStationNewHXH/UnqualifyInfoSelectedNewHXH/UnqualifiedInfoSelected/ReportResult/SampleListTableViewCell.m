//
//  SampleListTableViewCell.m
//  Xieshi
//
//  Created by 明溢 李 on 14-11-18.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "SampleListTableViewCell.h"

@implementation SampleListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceWidth-15-8, (61-15)/2, 8, 15)];
    imageView.image = [UIImage imageNamed:@"next"];
    [self addSubview:imageView];
    
    self.sampleResultLabel.frame = CGRectMake(60, 36, DeviceWidth-60-15-8-5, 16);
    self.sampleResultLabel.numberOfLines = 0;
    
    [self addLineView:CGRectMake(0, 60.5, DeviceWidth, 0.5)];
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
    return 61;
}

@end
