//
//  LSFormSwitchCell.m
//  YinfengShop
//
//  Created by lessu on 13-12-24.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFormSwitchCell.h"

@implementation LSFormSwitchCell

- (void)onInitWithLabel:(NSString *)label value:(id)value andRule:(NSDictionary *)rule{
    self.textLabel.text = label;
    _switchView = [[UISwitch alloc] init];
    [self addSubview:_switchView];
    _switchView.left = self.width - 20 - _switchView.width;
    _switchView.top   = 6;
    [_switchView addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
}
- (CGFloat)cellHeight{
    return 44;
}
- (void)setData:(NSString *)data{
    if ([data boolValue]) {
        _switchView.on = [data boolValue];
    }
    _data = @([data boolValue]);
}
- (id)data{
    _data = @(_switchView.on);
    return _data;
}
- (void)valueChanged:(id)switchView{
    _data = @(_switchView.isSelected);
    if ([self.delegate respondsToSelector:@selector(cell:valuedChanged:)]) {
        [self.delegate cell:self valuedChanged:_data];
    }
}

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName andLabel:(NSString *)label{
    return [LSFormCell mapperWithClassName:@"Switch" cellName:cellName keyName:keyName   label:label value:nil andRule:nil];
}

@end
