//
//  LeftVCButton.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/19.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LeftVCButton.h"

@implementation LeftVCButton

- (instancetype)initWithFrame:(CGRect)frame WitnImage:(UIImage*)imageBtn title:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        self.imageBtn = imageBtn;
        self.strTitle = title;
        [self setSubViews];
        
    }
    return self;
}

- (void)setSubViews{
    UIImageView *imageViewHead = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 70)];
    imageViewHead.image = self.imageBtn;
    [self addSubview:imageViewHead];
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 60, self.frame.size.width, 60)];
    labelTitle.font = themeFont17;
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.text = self.strTitle;
    labelTitle.textColor = [UIColor colorWithHexString:kc00_666666];
    [self addSubview:labelTitle];
    
}

@end
