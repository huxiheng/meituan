//
//  XSView.m
//  Xieshi
//
//  Created by Tesiro on 16/7/13.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSView.h"

@implementation XSView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}
- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}
+ (NSString *)viewIdentifier {
    return [self HYClassName];
}
- (void)addLineView:(CGRect)frame {
    self.viewLine =[[UIView alloc] initWithFrame:frame];
    self.viewLine.backgroundColor =kcolorLine;
    [self.contentView addSubview:self.viewLine];
}
//override
- (void)initSubviews {
    
}
- (void)reloadDataForView:(id)model {
    
}

@end
