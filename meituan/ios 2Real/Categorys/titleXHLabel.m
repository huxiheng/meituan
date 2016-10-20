//
//  titleXHLabel.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/20.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "titleXHLabel.h"

@implementation titleXHLabel
- (instancetype)init{
    if (self = [super init]) {
        self.textColor = [UIColor colorWithHexString:kc00_999999];
    }
    return self;
}

- (void)awakeFromNib{
    self.textColor = [UIColor colorWithHexString:kc00_999999];
    self.frame= CGRectMake(self.frame.origin.x, kscaleDeviceHeight(self.frame.origin.y), self.frame.size.width, kscaleDeviceHeight(self.frame.size.height));
    [self sizeToFit];
}
@end
