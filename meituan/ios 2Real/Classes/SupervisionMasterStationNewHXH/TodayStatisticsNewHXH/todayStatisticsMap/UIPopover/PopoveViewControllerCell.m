//
//  PopoveViewControllerCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/10/12.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "PopoveViewControllerCell.h"

@implementation PopoveViewControllerCell
-(void)initSubviews{
    self.labelShow = [[UILabel alloc] initWithFrame:CGRectMake(kscaleDeviceWidth(10), 0, kscaleDeviceWidth(75)-kscaleDeviceWidth(20), kscaleIphone6DeviceLength(28))];
    self.labelShow.textColor = [UIColor blackColor];
    self.labelShow.font = themeFont9;
    self.labelShow.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.labelShow];
    [self addLineView:CGRectMake(0, kscaleIphone6DeviceLength(28), kscaleDeviceWidth(75), kscaleIphone6DeviceLength(1))];
}
-(void)reloadDataForCell:(id)model{
    NSString *text = (NSString *)model;
    if ([text isEqualToString:@"0"]) {
        self.labelShow.text=[NSString stringWithFormat:@"%@(公里)",text];
    }else{
       self.labelShow.text = text;
    }
}
@end
