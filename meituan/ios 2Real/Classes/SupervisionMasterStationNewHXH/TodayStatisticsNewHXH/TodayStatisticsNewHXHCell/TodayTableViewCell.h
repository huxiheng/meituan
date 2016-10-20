//
//  TodayTableViewCell.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-28.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayTableViewCell : UITableViewCell
+ (CGFloat)cellHeight;
@property(nonatomic,strong) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UILabel *cellSampleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellSampleCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellSampleRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellSampleCompleteCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellSampleUqCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellSampleUcCountLabel;

@property (weak, nonatomic) IBOutlet UIView *viewSampleName;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewSampleNameLine;

@property (weak, nonatomic) IBOutlet UIView *viewSampleCount;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewSampleCountLine;

@property (weak, nonatomic) IBOutlet UIView *viewSampleRate;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewSampleRateLine;

@property (weak, nonatomic) IBOutlet UIView *viewSampleCompleteCount;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewSampleCompleteCountLine;

@property (weak, nonatomic) IBOutlet UIView *viewSampleUQCount;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewSampleUqCountLine;

@property (weak, nonatomic) IBOutlet UIView *viewSampleUcCount;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewSampleUcCount;

@property (weak, nonatomic) IBOutlet UIView *viewLastBottom;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewLastBottomLine;

@end
