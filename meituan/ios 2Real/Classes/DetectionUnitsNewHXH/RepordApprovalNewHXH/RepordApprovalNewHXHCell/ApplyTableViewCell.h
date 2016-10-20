//
//  ApplyTableViewCell.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-28.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ApplyTableViewCellDelegate ;
@interface ApplyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellReportIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellConsignLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellSelectedImageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewBottomDateLine;
@property (weak, nonatomic) IBOutlet UIView *viewDate;
@property (weak, nonatomic) IBOutlet UIView *viewBottomLast;
@property (weak, nonatomic) IBOutlet UIButton *btnBG;
@property (assign, nonatomic) id<ApplyTableViewCellDelegate> delegate;
@property(nonatomic,strong) NSDictionary *data;

@property (weak, nonatomic) IBOutlet UIView *viewConsign;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewConsignLine;

@property (weak, nonatomic) IBOutlet UIView *viewReportID;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewReportIDLine;

@property (weak, nonatomic) IBOutlet UIImageView *imageviewBottomLastLine;

+ (CGFloat)cellHeight;
@end

@protocol ApplyTableViewCellDelegate <NSObject>

- (void)applyTableViewCellDidPress:(ApplyTableViewCell *)cell;

@end