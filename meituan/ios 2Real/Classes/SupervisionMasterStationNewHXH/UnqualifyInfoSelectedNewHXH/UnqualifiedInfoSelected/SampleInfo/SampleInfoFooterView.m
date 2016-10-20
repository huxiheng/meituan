//
//  SampleInfoFooterView.m
//  Xieshi
//
//  Created by Tesiro on 16/7/14.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "SampleInfoFooterView.h"

@implementation SampleInfoFooterView
- (void)initSubviews {
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 67.5)];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.viewBG];
    
    self.labelMakeDate = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, (DeviceWidth-34)/2+50, 67.5)];
    self.labelMakeDate.font = themeFont12;
    self.labelMakeDate.textColor = [UIColor colorWithHexString:kc00_999999];
    [self.viewBG addSubview:self.labelMakeDate];
    
    self.labelAge = [[UILabel alloc] initWithFrame:CGRectMake((DeviceWidth-34)/2+60, 0, (DeviceWidth-34)/2-60, 67.5)];
    self.labelAge.font = themeFont12;
    self.labelAge.textColor = [UIColor colorWithHexString:kc00_999999];
    [self.viewBG addSubview:self.labelAge];
    
    [self addLineView:CGRectMake(0, 67.5, DeviceWidth, 0.5)];
}

- (void)reloadDataForView:(id)model {
    
    self.model = model;
    self.labelMakeDate.text = [NSString stringWithFormat:@"制作日期：%@",((NSDictionary *)self.model)[@"Molding_Date"]];
    self.labelAge.text = [NSString stringWithFormat:@"龄期：%@",((NSDictionary *)self.model)[@"AgeTime"]];
    
    if (((NSDictionary *)self.model)[@"Molding_Date"]!=nil) {
        NSString *stringMakeDate = self.labelMakeDate.text;
        NSRange rangeMakeDate = [stringMakeDate rangeOfString:((NSDictionary *)self.model)[@"Molding_Date"]];
        NSMutableAttributedString *stringAttributeMakeDate = [[NSMutableAttributedString alloc] initWithString:stringMakeDate];
        [stringAttributeMakeDate setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:kc00_666666]} range:NSMakeRange(rangeMakeDate.location, rangeMakeDate.length)];
        [self.labelMakeDate setAttributedText:stringAttributeMakeDate];
    }
    
    if (((NSDictionary *)self.model)[@"AgeTime"]!=nil) {
        NSString *stringAge = self.labelAge.text;
        NSRange rangeAge = [stringAge  rangeOfString:((NSDictionary *)self.model)[@"AgeTime"]];
        NSMutableAttributedString *stringAttributeAge = [[NSMutableAttributedString alloc] initWithString:stringAge];
        [stringAttributeAge setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:kc00_666666]} range:NSMakeRange(rangeAge.location, rangeAge.length)];
        [self.labelAge setAttributedText:stringAttributeAge];
    }
    
    
}

@end
