//
//  AgreementTableViewCell.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgreementTableViewCell : UITableViewCell{
    CGFloat heightRealDectection;
    CGFloat heightRealBuilder;
    
}

@property(nonatomic,strong) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UILabel *cellStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellBuildingReportNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellContractSignNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *cellDetectionNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellBuilderNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imagedetectionUnitLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewConstructUnitLine;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIView *viewHeaderInside;

@property (weak, nonatomic) IBOutlet UIView *viewStatus;
@property (weak, nonatomic) IBOutlet UIView *viewStatusInside;


@property (weak, nonatomic) IBOutlet UIView *viewBuildingReportNumberHealder;
@property (weak, nonatomic) IBOutlet UIView *viewBuildingReportNumberInside;

@property (weak, nonatomic) IBOutlet UIView *viewContractSignNumber;
@property (weak, nonatomic) IBOutlet UIView *viewContractSignNumberInsider;

@property (weak, nonatomic) IBOutlet UIView *viewDetectionName;
@property (weak, nonatomic) IBOutlet UIView *viewDetectionNameInside;

@property (weak, nonatomic) IBOutlet UIView *viewBuilderName;
@property (weak, nonatomic) IBOutlet UIView *viewBuilderNameInside;


+ (CGFloat)cellHeight;
@end
