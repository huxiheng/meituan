//
//  UploadListTableViewCell.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-22.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UploadListTableViewCellDelegate;
@interface UploadListTableViewCell : UITableViewCell
@property(nonatomic,strong) NSDictionary *data;
@property(nonatomic,weak) id<UploadListTableViewCellDelegate> delegate;

+ (CGFloat)cellHeight;
@property (weak, nonatomic) IBOutlet UILabel *cellProjectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellTaskNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellStartDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellConsignIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellExamMehodLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellDelegateIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellEndDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellProjectAddressLabel;

@end

@protocol UploadListTableViewCellDelegate <NSObject>

- (void)uploadListTableViewCell:(UploadListTableViewCell *)cell uploadButtonDidPress:(UIButton *)sender;
- (void)uploadListTableViewCell:(UploadListTableViewCell *)cell downloadButtonDidPress:(UIButton *)sender;

@end