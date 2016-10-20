//
//  TodayAdminDetailTableViewCell.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-3-23.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayAdminDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellQPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellUQPercentLabel;
@property (weak, nonatomic) IBOutlet UIView *viewProjectName;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewProjectNameBottomLine;
@property (weak, nonatomic) IBOutlet UIView *viewProjectHeGeLv;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewHeGeLvBottomLine;
@property (weak, nonatomic) IBOutlet UIView *viewJianCeZuShu;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewJianCeZuShuBottomLine;
@property (weak, nonatomic) IBOutlet UIView *viewLaStBottom;
@property (weak, nonatomic) IBOutlet UIImageView *ImagevoiewBottomLastLine;
@property (weak, nonatomic) IBOutlet UIView *viewJianCeBuHeGeShu;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewJianCeBuHeGeShuLine;


@property(nonatomic,strong) NSDictionary *data;

+ (CGFloat)cellHeight;
@end
