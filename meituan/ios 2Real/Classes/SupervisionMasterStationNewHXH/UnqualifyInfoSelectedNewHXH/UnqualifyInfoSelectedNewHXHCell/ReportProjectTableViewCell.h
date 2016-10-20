//
//  ReportTableViewCell.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportProjectTableViewCell : UITableViewCell
@property(nonatomic,strong) NSDictionary *data;

@property (weak, nonatomic) IBOutlet UILabel *cellReportIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellProjectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellConstructionUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellSuperviserKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellBuildUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellSupervisorUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellModifyTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellContacterLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellMemberIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellIsSuperviserLabel;
@property (weak, nonatomic) IBOutlet UIView *viewProjectName;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewProjectNameBottomLine;
@property (weak, nonatomic) IBOutlet UIView *viewConstructionUnit;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewConstructionUnitLine;
@property (weak, nonatomic) IBOutlet UIView *viewBuildUnite;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBuildUnitLine;
@property (weak, nonatomic) IBOutlet UIView *viewSuperverUnite;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewSuperviserUniteLine;
@property (weak, nonatomic) IBOutlet UIView *viewDateTime;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UIView *viewSuperVisiorKey;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewSuperVisiorKeyLine;
@property (weak, nonatomic) IBOutlet UIView *viewreportID;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewReportIdLine;
@property (weak, nonatomic) IBOutlet UIView *viewMemberName;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewMemberLine;
@property (weak, nonatomic) IBOutlet UIView *viewContracter;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewContracterLine;
@property (weak, nonatomic) IBOutlet UIView *viewPhone;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewPhoneLine;
@property (weak, nonatomic) IBOutlet UIView *viewSuperViser;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewSuperViserLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewDateLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewBottomLastLine;

+ (CGFloat)cellHeight;
@end
