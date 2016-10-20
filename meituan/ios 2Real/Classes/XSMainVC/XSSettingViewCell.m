//
//  XSSettingViewCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/26.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSSettingViewCell.h"

@implementation XSSettingViewCell
- (void)initSubviews {
    self.backgroundColor = [UIColor colorWithRed:251.0/255.0 green:251.0/255.0 blue:251.0/255.0 alpha:1.0];
    
    self.imageViewHead = [[UIImageView alloc] initWithFrame:CGRectMake(17, 15, 20, 20)];
    [self addSubview:self.imageViewHead];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 100, 49.5)];
    self.labelTitle.font = themeFont16;
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_666666];
    [self addSubview:self.labelTitle];
    
    self.imageEntrance = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceWidth-17-10, 16, 10, 18)];
    self.imageEntrance.image = [UIImage imageNamed:@"next"];
    [self addSubview:self.imageEntrance];
    
    self.labelContent = [[UILabel alloc] initWithFrame:CGRectMake(DeviceWidth-17-10-10-80, 0, 80, 49.5)];
    self.labelContent.font = themeFont15;
    self.labelContent.textColor = [UIColor colorWithRed:243.0/255.0 green:163.0/255.0 blue:115.0/233.0 alpha:1.0];
    self.labelContent.hidden = NO;
    [self addSubview:self.labelContent];
    
    UIView *vieWBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, DeviceWidth, 0.5)];
    vieWBottomLine.backgroundColor = kcolorLine;
    [self addSubview:vieWBottomLine];
    
}

- (void)reloadDataForCell:(id)model {
    self.model = model;
    self.imageViewHead.image = ((XSCellModel *)(self.model)).images;
    self.labelTitle.text = ((XSCellModel *)(self.model)).title;
    self.labelContent.text = ((XSCellModel *)(self.model)).content;
    if ([((XSCellModel *)(self.model)).content isEqualToString:@""]) {
        self.labelContent.hidden = YES;
    }else{
        self.labelContent.hidden = NO;
    }
}

@end
