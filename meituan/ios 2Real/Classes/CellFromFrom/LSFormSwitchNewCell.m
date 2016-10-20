//
//  LSFormSwitchNewCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/25.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSFormSwitchNewCell.h"

@implementation LSFormSwitchNewCell
- (void)onInitWithLabel:(NSString *)label value:(id)value andRule:(NSDictionary *)rule{
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 85)];
    self.viewBG.backgroundColor = [UIColor colorWithHexString:kcolorBJ_f0eff4];
    [self addSubview:self.viewBG];
    
    self.viewSecond = [[UIView alloc] initWithFrame:CGRectMake(28, 0, DeviceWidth-56, 80)];
    self.viewSecond.backgroundColor = [UIColor whiteColor];
    self.viewSecond.layer.cornerRadius = 5;
    self.viewSecond.layer.masksToBounds = YES;
    [self.viewBG addSubview:self.viewSecond];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, DeviceWidth-56-12-40-12-5, 40)];
    self.labelTitle.text = @"是否仅显示未完工的工地";
    self.labelTitle.font = themeFont16;
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_333333];
    [self.viewSecond addSubview:self.labelTitle];
    
    self.btnNo = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnNo.frame = CGRectMake(DeviceWidth-56-12-40, 0, 40, 40);
    [self.btnNo setImage:[UIImage imageNamed:@"sampleInfoyuan"] forState:UIControlStateNormal];
    [self.btnNo setImageEdgeInsets:UIEdgeInsetsMake(16, 0, 16, 32)];
    [self.btnNo setTitle:@"否" forState:UIControlStateNormal];
    self.btnNo.titleLabel.font = themeFont15;
    [self.btnNo setTitleEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 0)];
    [self.btnNo setTitleColor:[UIColor colorWithRed:71.0/255.0 green:189.0/255.0 blue:234.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.btnNo addTarget:self action:@selector(btnNoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.viewSecond addSubview:self.btnNo];
    
    self.btnYes = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnYes.frame = CGRectMake(DeviceWidth-56-12-40, 40, 40, 40);
    [self.btnYes setImage:[UIImage imageNamed:@"sampleInfoyuan1"] forState:UIControlStateNormal];
    [self.btnYes setImageEdgeInsets:UIEdgeInsetsMake(16, 0, 16, 32)];
    [self.btnYes setTitle:@"是" forState:UIControlStateNormal];
    [self.btnYes setTitleEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 0)];
    self.btnYes.titleLabel.font = themeFont15;
    [self.btnYes setTitleColor:[UIColor colorWithHexString:kc00_2c2c2c] forState:UIControlStateNormal];
    [self.btnYes addTarget:self action:@selector(btnYesClick) forControlEvents:UIControlEventTouchUpInside];
    [self.viewSecond addSubview:self.btnYes];
    
    self.isStatus = NO;
}



- (void)btnYesClick{
    self.isStatus = YES;
    _data = @(self.isStatus);
    [self.btnNo setTitleColor:[UIColor colorWithHexString:kc00_2c2c2c] forState:UIControlStateNormal];
    [self.btnNo setImage:[UIImage imageNamed:@"sampleInfoyuan1"] forState:UIControlStateNormal];
    [self.btnYes setImage:[UIImage imageNamed:@"sampleInfoyuan"] forState:UIControlStateNormal];
    [self.btnYes setTitleColor:[UIColor colorWithRed:71.0/255.0 green:189.0/255.0 blue:234.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(cell:valuedChanged:)]) {
        [self.delegate cell:self valuedChanged:_data];
    }
}
- (void)btnNoClick{
    self.isStatus = NO;
    _data = @(self.isStatus);
    [self.btnYes setTitleColor:[UIColor colorWithHexString:kc00_2c2c2c] forState:UIControlStateNormal];
    [self.btnYes setImage:[UIImage imageNamed:@"sampleInfoyuan1"] forState:UIControlStateNormal];
    [self.btnNo setImage:[UIImage imageNamed:@"sampleInfoyuan"] forState:UIControlStateNormal];
    [self.btnNo setTitleColor:[UIColor colorWithRed:71.0/255.0 green:189.0/255.0 blue:234.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(cell:valuedChanged:)]) {
        [self.delegate cell:self valuedChanged:_data];
    }
}
- (CGFloat)cellHeight {
    return 85;
}

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName{
    return [LSFormCell mapperWithClassName:@"SwitchNew" cellName:cellName keyName:keyName   label:nil value:nil andRule:nil];
}
@end
