//
//  ApplyTableViewCell.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-28.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyCompleteTableViewCell : UITableViewCell
@property(nonatomic,strong) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UILabel *cellConsignLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellReportIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellAppDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellVerifyLabel;
@property (weak, nonatomic) IBOutlet UIView *viewVerify;
@property (weak, nonatomic) IBOutlet UIView *viewConsign;
@property (weak, nonatomic) IBOutlet UIView *viewReportID;
@property (weak, nonatomic) IBOutlet UIView *viewDate;
@property (weak, nonatomic) IBOutlet UIView *viewAPPdate;
@property (weak, nonatomic) IBOutlet UIView *viewLast;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLastLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewAPPDateLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewDateLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewReportIDLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewConsignLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewVerifyLine;


+ (CGFloat)cellHeight;
@end
