//
//  TodaySearchDayButton.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/21.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "TodaySearchDayButton.h"

@implementation TodaySearchDayButton
- (instancetype)initWithStr:(NSString *)str leftImageName:(NSString *)leftImageName rightImageName:(NSString *)rightImageName{
    if (self = [super init]) {
        self.strTitle = str;
        self.strLeftImageName = leftImageName;
        self.strRightImageName = rightImageName;
        
        [self initWithBtnSubViews];
        
    }
    return self;
}

- (void)initWithBtnSubViews{
    self.imageViewLeft = [[UIImageView alloc] initWithFrame:CGRectMake(kscaleDeviceHeight(5), 0, kscaleDeviceHeight(15), kscaleDeviceHeight(15))];
    self.imageViewLeft.image = [UIImage imageNamed:self.strLeftImageName];
    [self addSubview:self.imageViewLeft];
    
    self.labelTitleNew = [[UILabel alloc] initWithFrame:CGRectMake(kscaleDeviceHeight(25), 0, kscaleDeviceHeight(80), kscaleDeviceHeight(15))];
    self.labelTitleNew.textColor = [UIColor whiteColor];
    self.labelTitleNew.textAlignment = NSTextAlignmentCenter;
    self.labelTitleNew.font = themeFont15;
    self.labelTitleNew.text = self.strTitle;
    [self addSubview:self.labelTitleNew];
    
   self.imageViewRight = [[UIImageView alloc] initWithFrame:CGRectMake(kscaleDeviceHeight(110), kscaleDeviceHeight(5), kscaleDeviceHeight(12), kscaleDeviceHeight(6))];
    self.imageViewRight.image = [UIImage imageNamed:self.strRightImageName];
    [self addSubview:self.imageViewRight];
    
}
@end
