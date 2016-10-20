//
//  LeftVCCollectionViewCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/19.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LeftVCCollectionViewCell.h"

@implementation LeftVCCollectionViewCell
- (void)initSubviews{
    
    
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kscaleDeviceWidth(85), kscaleIphone6DeviceHeight(105))];
//    self.viewBG.backgroundColor = [UIColor redColor];
    [self addSubview:self.viewBG];
    
    self.imageViewHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0   , kscaleIphone6DeviceHeight(85), kscaleIphone6DeviceHeight(85))];
    self.imageViewHeader.center = CGPointMake(self.viewBG.center.x, kscaleIphone6DeviceHeight(47.5));
    [self.viewBG addSubview:self.imageViewHeader];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, kscaleIphone6DeviceHeight(95), kscaleDeviceWidth(85), kscaleIphone6DeviceHeight(10))];
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_666666];
    self.labelTitle.font = themescaleFont(10);
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    [self.viewBG addSubview:self.labelTitle];
}

- (void)reloadDataForCell:(id)model{
    self.model = model;
    self.imageViewHeader.image = ((XSCollectionCellModel *)self.model).imageForCell;
    self.labelTitle.text = ((XSCollectionCellModel *)self.model).strName;
}
@end
