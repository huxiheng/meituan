//
//  LSClickAlertLabel.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 16/5/31.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSClickAlertLabel.h"

@implementation LSClickAlertLabel
- (void)awakeFromNib{
    [self __init];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __init];
        
    }
    return self;
}
- (void)__init{
    _button = [[UIButton alloc]initWithFrame:self.frame];
    [_button addTarget:self action:@selector(buttonDidPress:) forControlEvents:UIControlEventTouchUpInside];
//    _button.backgroundColor=[UIColor redColor];
    [self addSubview:_button];
    self.userInteractionEnabled=true;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _button.frame = self.bounds;
    
}
- (void)buttonDidPress:(UIButton *)sender{
    [LSDialog showAlertWithTitle:@"提示" message:self.text callBack:0];

}
@end
