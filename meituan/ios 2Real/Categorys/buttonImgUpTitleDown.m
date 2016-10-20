//
//  buttonImgUpTitleDown.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/10/11.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "buttonImgUpTitleDown.h"

@implementation buttonImgUpTitleDown
////适用于代码编写
//-(instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//    }
//    return self;
//}
//
//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self=[super initWithCoder:aDecoder]) {
//        
//    }
//    return self;
//}
//
//-(void)setSettingForself{
//    [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//    [self sizeToFit];
//}

//-(void)layoutSubviews{
//    [super layoutSubviews];
//    self.imageView.frame = CGRectMake(0, -5, self.imageView.frame.size.width, (self.imageView.frame.size.height));
//    self.titleLabel.frame=CGRectMake(0, self.imageView.frame.size.height-5,  self.titleLabel.frame.size.width,(self.titleLabel.frame.size.height));
//
//   
//}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.frame= CGRectMake(kscaleDeviceWidth(self.frame.origin.x) , kscaleIphone6DeviceHeight(self.frame.origin.y),kscaleDeviceWidth( self.frame.size.width), kscaleIphone6DeviceHeight(self.frame.size.height));
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.frame.size.height+10 ,-self.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [self setImageEdgeInsets:UIEdgeInsetsMake(-5.0, 0.0,0.0, -self.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
   
    
}

@end
