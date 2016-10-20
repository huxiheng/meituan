//
//  ContentXHLabel.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/21.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "ContentXHLabel.h"

@implementation ContentXHLabel
- (void)awakeFromNib{
    self.textColor = [UIColor colorWithHexString:kc00_333333];
    self.frame= CGRectMake(self.frame.origin.x, kscaleDeviceHeight(self.frame.origin.y), self.frame.size.width, kscaleDeviceHeight(self.frame.size.height));
    
}
@end
