//
//  UploadListTableViewCell.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-22.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "UploadListTableViewCell.h"

@implementation UploadListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)data{
    _data = data;
    _cellConsignIdLabel.text = data[@"ContractRegNo"];
    _cellDelegateIdLabel.text = data[@"DelegationID"];
    _cellEndDateLabel.text = data[@"PlanEndTime"];
    _cellExamMehodLabel.text = data[@"Method"];
    _cellProjectAddressLabel.text = data[@"ProjectAddress"];
    _cellProjectNameLabel.text = data[@"ProjectName"];
    _cellStartDateLabel.text = data[@"PlanStartTime"];
    _cellTaskNameLabel.text = data[@"TaskName"];
}

+ (CGFloat)cellHeight{
    return 293;
}
- (IBAction)uploadButtonDidPress:(id)sender {
    if([_delegate respondsToSelector:@selector(uploadListTableViewCell:uploadButtonDidPress:)]){
        [_delegate uploadListTableViewCell:self uploadButtonDidPress:sender];
    }
}
- (IBAction)downloadButtonDidPress:(id)sender {
    if([_delegate respondsToSelector:@selector(uploadListTableViewCell:downloadButtonDidPress:)]){
        [_delegate uploadListTableViewCell:self downloadButtonDidPress:sender];
    }
}

@end
