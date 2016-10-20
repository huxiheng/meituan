//
//  ReportTableViewCell.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportTableViewCell : UITableViewCell
@property(nonatomic,strong) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UILabel *reportIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UIView *viewhandlingStatus;
@property (weak, nonatomic) IBOutlet UIView *viewCheckStatus;
@property (weak, nonatomic) IBOutlet UIView *viewProjectName;
@property (weak, nonatomic) IBOutlet UIView *viewReportNumber;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewProjectNameBottomLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewResultNumberLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewCheckStatusLine;
@property (weak, nonatomic) IBOutlet UIImageView *imgeviewHandStatusLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewBottomLine;

+ (CGFloat)cellHeight;
@end
