//
//  LSDateLabel.h
//  LSLab
//
//  Created by Lessu on 13-4-18.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSDateLabel : UILabel
{
    NSString    *_dateFormat;
    BOOL        isInnerSetting;
}
@property(nonatomic,assign) NSTimeInterval timeInterval;

@end
