//
//  LSLabel.h
//  LSLab
//
//  Created by Lessu on 13-4-18.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSLabel : UILabel
{
    CGSize _maxSize;
}

@property(nonatomic,assign) CGSize maxSize;
@property(nonatomic,assign) BOOL   resizeInBounds;

@end
