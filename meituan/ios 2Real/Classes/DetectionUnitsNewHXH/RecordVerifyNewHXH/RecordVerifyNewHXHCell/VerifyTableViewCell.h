//
//  ApplyTableViewCell.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-27.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol VerifyTableViewCellDelegate;
@interface VerifyTableViewCell : UITableViewCell
@property(nonatomic,strong) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UILabel *cellSampleIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellConsignLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellDataLabel;
@property (assign,nonatomic) id<VerifyTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *cellSelectedImageView;
@property (weak, nonatomic) IBOutlet UIView *viewDate;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBottomLine;
@property (weak, nonatomic) IBOutlet UIView *viewBottomLast;
@property (weak, nonatomic) IBOutlet UIButton *btnBG;

@property (weak, nonatomic) IBOutlet UIView *viewSampleID;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewSampleIDLine;

@property (weak, nonatomic) IBOutlet UIView *viewConsign;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewConsignLine;

@property (weak, nonatomic) IBOutlet UIImageView *imageviewBottomLastLine;

+ (CGFloat)cellHeight;
@end

@protocol VerifyTableViewCellDelegate <NSObject>

- (void)verifyTableViewCellDidPress:(VerifyTableViewCell *)cell;


@end