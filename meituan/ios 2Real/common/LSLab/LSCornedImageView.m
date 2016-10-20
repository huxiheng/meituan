//
//  LSCornedImageView.m
//  LSLab
//
//  Created by Lessu on 13-4-18.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSCornedImageView.h"
#import <QuartzCore/QuartzCore.h>
@implementation LSCornedImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.layer.cornerRadius = [_cornerRadius floatValue];
    self.layer.masksToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
