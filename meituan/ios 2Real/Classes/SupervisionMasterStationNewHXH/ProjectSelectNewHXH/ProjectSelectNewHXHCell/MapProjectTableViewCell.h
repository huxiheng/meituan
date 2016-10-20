//
//  MapProjectTableViewCell.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-15.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapProjectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelLeftTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelnumber;
@property (weak, nonatomic) IBOutlet UILabel *labelZuoBiao;
@property(nonatomic,retain) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UIView *viewProjectName;
@property (weak, nonatomic) IBOutlet UIView *viewProjectNumber;
@property (weak, nonatomic) IBOutlet UIView *viewDizhi;
@property (weak, nonatomic) IBOutlet UIView *VviewBottom;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewProjectNameLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewProjectNumberLine;
@property (weak, nonatomic) IBOutlet UIImageView *viewBottomLastLine;
+ (CGFloat)cellHeight;
@end
