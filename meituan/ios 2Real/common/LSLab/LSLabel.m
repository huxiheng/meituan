//
//  LSLabel.m
//  LSLab
//
//  Created by Lessu on 13-4-18.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSLabel.h"

@implementation LSLabel
{
//    BOOL _innerSetFrame;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _maxSize = frame .size;
        [self _init];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    _maxSize = self.frame.size;
    [self _init];
    [self sizeToFit];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    CGRect frame = self.frame;
    frame.size = _maxSize;
    self.frame = frame;
    [self sizeToFit];
    
}
- (void)sizeToFit{
    if (_resizeInBounds) {
        CGSize size = [super sizeThatFits:_maxSize];
        if (size.height>_maxSize.height) {
            CGRect frame = self.frame;
            frame.size.height = _maxSize.height;
            self.frame = frame;
        }else{
            CGRect frame    = self.frame;
            frame.size      = size;
            self.frame      = frame;
        }
    }else{
        [super sizeToFit];
    }
    
}
#pragma mark -
#pragma mark private method
- (void)_init{
    self.lineBreakMode = NSLineBreakByCharWrapping;
    self.numberOfLines = 0;
}
@end
