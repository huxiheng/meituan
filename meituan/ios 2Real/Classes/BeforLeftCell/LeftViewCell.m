//
//  LeftViewCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/21.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LeftViewCell.h"

@implementation LeftViewCell

- (void)initSubviews {
    self.imageHead = [[UIImageView alloc] initWithFrame:CGRectMake(19, 12, 15, 15)];
    self.imageHead.layer.cornerRadius = 7.5;
    self.imageHead.layer.masksToBounds = YES;
    [self addSubview:self.imageHead];
    
    self.labelTitle= [[UILabel alloc] initWithFrame:CGRectMake(39, 0, 212, 40)];
    self.labelTitle.font = themeFont16;
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_333333];
    [self addSubview: self.labelTitle];
    
    UIView *viewBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, DeviceWidth, 0.5)];
    viewBottom.backgroundColor=kcolorLine;
    [self addSubview:viewBottom];
}

@end
