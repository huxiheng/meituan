//
//  TodayTableViewCell.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-28.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TodayAdminTableViewCellDelegate;
@interface TodayAdminTableViewCell : UITableViewCell
+ (CGFloat)cellHeight;
@property(nonatomic,strong) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UILabel *cellProjectNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *cellProjectIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellProjectStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellProjectNatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellProjectRegionLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellProjectAddressLabel;
//@property (weak, nonatomic) IBOutlet UIView *viewProjectName;
//@property (weak, nonatomic) IBOutlet UIImageView *imageviewProjectNameBottomLine;
//@property (weak, nonatomic) IBOutlet UIView *viewProjectStatus;
//@property (weak, nonatomic) IBOutlet UIView *projectNature;
//@property (weak, nonatomic) IBOutlet UIView *viewProjectRegion;
//@property (weak, nonatomic) IBOutlet UIView *viewProjectAdd;
//@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewProjectADDLine;
//@property (weak, nonatomic) IBOutlet UIImageView *imageviewProjectStatusBottomLine;
//@property (weak, nonatomic) IBOutlet UIImageView *imageviewProjectNatureBottomLine;
//@property (weak, nonatomic) IBOutlet UIImageView *imageviewProjectRegionBottomLine;
//@property (weak, nonatomic) IBOutlet UIImageView *imageviewLastBottomLine;



@property(nonatomic,assign) id<TodayAdminTableViewCellDelegate> deleagte;
@end
@protocol TodayAdminTableViewCellDelegate <NSObject>

- (void)todayAdminTableViewCellTitleDidPress:(TodayAdminTableViewCell *) cell;

@end
