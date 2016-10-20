//
//  UIImage+HY.h
//  Mall
//
//  Created by zhizi on 15/8/3.
//  Copyright (c) 2015年 _Zhizi_. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HY)
+ (UIImage*) createImageWithColor: (UIColor*) color;

/**
 * 返回一张圆形图片
 */
- (instancetype)circleImage;

/**
 * 返回一张圆形图片
 */
+ (instancetype)circleImageNamed:(NSString *)name;

+ (UIImage * )imageWithScreenContents:(UIView *)view;
@end
