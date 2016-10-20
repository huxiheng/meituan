//
//  UILabel+JJKAlertActionFont.m
//  J1health
//
//  Created by huxiheng on 16/1/15.
//  Copyright © 2016年 J1. All rights reserved.
//

#import "UILabel+JJKAlertActionFont.h"

@implementation UILabel (JJKAlertActionFont)
-(void)setAppearanceFont:(UIFont *)appearanceFont{
    if (appearanceFont) {
        [self setFont:appearanceFont];
    }
}

-(UIFont *)appearanceFont{
    return self.font;
}
@end
