//
//  UILabel+SampleSearchAttribute.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/25.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SampleSearchAttribute)
- (void)setAttributeText:(NSString *)stringAll nsrange:(NSRange )range;
- (void)setAttributeText:(NSString *)stringAll nsrange:(NSRange )range andColorRGB:(NSString *)strColor;
@end
