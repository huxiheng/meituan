//
//  SampleListTableViewCell.h
//  Xieshi
//
//  Created by 明溢 李 on 14-11-18.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol VASampleListTableViewCellDelegate;
@interface VASampleListTableViewCell : UITableViewCell
@property(nonatomic,retain) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UILabel *sampleIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *sampleNameLabel;
@property (weak, nonatomic) IBOutlet UIView *viewSampleName;
@property (weak, nonatomic) IBOutlet UIView *viewButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewBottomLineProName;
@property (weak, nonatomic) IBOutlet UIButton *buttonDetailInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnProperty;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property(nonatomic,assign) id<VASampleListTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *viewSampleID;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewSampleIDLine;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewButtonLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewBottomLine;

+ (CGFloat)cellHeight;
@end

@protocol VASampleListTableViewCellDelegate <NSObject>

- (void)sampleListTableViewCell:(VASampleListTableViewCell *)cell detailButtonDidPress:(UIButton *)button;
- (void)sampleListTableViewCell:(VASampleListTableViewCell *)cell propertyButtonDidPress:(UIButton *)button;

@end
