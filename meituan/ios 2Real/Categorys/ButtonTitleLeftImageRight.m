//
//  ButtonTitleLeftImageRight.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/10/12.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "ButtonTitleLeftImageRight.h"

@implementation ButtonTitleLeftImageRight
+(instancetype)buttonWithType:(UIButtonType)buttonType{
    return [self buttonWithType:UIButtonTypeCustom];
}
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont*)font textColor:(NSString *)textcolor
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"GLYTodayStatisticxiala"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"GLYStaticsticsdianjibeijing"] forState:UIControlStateSelected];
        [self setBackgroundImage:[UIImage imageNamed:@"GLYTodayStatisticbutton"] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.font = font;
        [self setTitleColor:[UIColor colorWithHexString:textcolor] forState:UIControlStateNormal];
//        [self sizeToFit];
        
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame=CGRectMake(kscaleDeviceWidth(3), 0, self.titleLabel.frame.size.width, self.frame.size.height);
    self.imageView.frame = CGRectMake(self.titleLabel.frame.size.width+kscaleDeviceWidth(3), (self.frame.size.height-self.imageView.frame.size.height)/2, self.imageView.frame.size.width, self.imageView.frame.size.height);
    [self setBackgroundImage:[UIImage imageNamed:@"GLYStaticsticsdianjibeijing"] forState:UIControlStateSelected];
    [self setBackgroundImage:[UIImage imageNamed:@"GLYTodayStatisticbutton"] forState:UIControlStateNormal];
    
    NSLog(@"%f,%F,%F",self.frame.size.width,self.frame.origin.x,self.frame.origin.y);
}




@end
