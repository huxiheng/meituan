//
//  UILabel+SampleSearchAttribute.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/25.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "UILabel+SampleSearchAttribute.h"

@implementation UILabel (SampleSearchAttribute)

- (void)setAttributeText:(NSString *)stringAll nsrange:(NSRange )range{
   
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:stringAll];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:kc00_2c2c2c]} range:range];
    [self setAttributedText:attributeStr];
}

- (void)setAttributeText:(NSString *)stringAll nsrange:(NSRange )range andColorRGB:(NSString *)strColor{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:stringAll];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:strColor]} range:range];
    [self setAttributedText:attributeStr];
}

@end
