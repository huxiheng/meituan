//
//  WorkSiteTableViewCell.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkSiteTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellWorkSiteNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellAreaLabel;
//@property (weak, nonatomic) IBOutlet UILabel *cellDataTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellWorkSiteTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellAddressLabel;

@property (weak, nonatomic) IBOutlet UIView *viewFooter;
@property (weak, nonatomic) IBOutlet UIView *viewWorkSiteName;
@property (weak, nonatomic) IBOutlet UIView *viewWorkStatus;
@property (weak, nonatomic) IBOutlet UIView *viewWorkSiteType;
@property (weak, nonatomic) IBOutlet UIView *viewArea;
@property (weak, nonatomic) IBOutlet UIView *viewAdress;

@property(nonatomic,strong) NSDictionary *data;

+ (CGFloat)cellHeight;
@end
