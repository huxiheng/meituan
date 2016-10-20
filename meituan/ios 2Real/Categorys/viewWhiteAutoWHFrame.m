//
//  viewWhiteAutoWHFrame.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/10/11.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "viewWhiteAutoWHFrame.h"

@implementation viewWhiteAutoWHFrame

- (void)awakeFromNib{
    [super awakeFromNib];
    self.frame= CGRectMake(kscaleDeviceWidth(self.frame.origin.x) , kscaleIphone6DeviceHeight(self.frame.origin.y),kscaleDeviceWidth( self.frame.size.width), kscaleIphone6DeviceHeight(self.frame.size.height));
    
}


@end
