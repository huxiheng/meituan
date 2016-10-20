//
//  labelWhiteAutoFrame.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/22.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "labelWhiteAutoFrame.h"

@implementation labelWhiteAutoFrame
- (void)awakeFromNib{
    
    self.frame= CGRectMake(self.frame.origin.x, kscaleDeviceHeight(self.frame.origin.y), self.frame.size.width, kscaleDeviceHeight(self.frame.size.height));
    
}


@end
