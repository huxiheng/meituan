//
//  XSMainViewCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/20.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSMainViewCell.h"

@implementation XSMainViewCell
- (void)initSubviews{
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 40)];
    [self addSubview:self.viewBG];
    
    self.imageViewHead = [[UIImageView alloc] initWithFrame:CGRectMake(17, 10, 20, 20)];
    self.imageViewHead.layer.cornerRadius = 10;
    self.imageViewHead.layer.masksToBounds = YES;
    [self.viewBG addSubview:self.imageViewHead];
    
    self.labelContent = [[UILabel alloc] initWithFrame:CGRectMake(47, 10, DeviceWidth-64, 20)];
    self.labelContent.font = themeFont16;
    self.labelContent.textColor = [UIColor colorWithHexString:kc00_999999];
    [self.viewBG addSubview:self.labelContent];
    
    self.viewBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, DeviceWidth, 0.5)];
    self.viewBottomLine.backgroundColor = kcolorLine;
    [self.viewBG addSubview:self.viewBottomLine];
}

@end
