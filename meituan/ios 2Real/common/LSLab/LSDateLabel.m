//
//  LSDateLabel.m
//  LSLab
//
//  Created by Lessu on 13-4-18.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSDateLabel.h"

@implementation LSDateLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    isInnerSetting = false;
    _dateFormat = [self.text copy];

}
- (void)setText:(NSString *)text{
    [super setText:text];
    if (!isInnerSetting) {
        _dateFormat = [text copy];
//        _dateFormat = [_dateFormat stringByReplacingOccurrencesOfString:@"date" withString:@"yyyy-MM-dd"];
//        _dateFormat = [_dateFormat stringByReplacingOccurrencesOfString:@"time" withString:@"HH:mm:ss"];
//        _dateFormat = [_dateFormat stringByReplacingOccurrencesOfString:@"full" withString:@"yyyy-MM-dd HH:mm:ss"];
    }
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval{
    NSDate *now = [[NSDate alloc]initWithTimeIntervalSince1970:timeInterval];
    NSString *text = _dateFormat;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    text = [text stringByReplacingOccurrencesOfString:@"date" withString:[formatter stringFromDate:now]];

    [formatter setDateFormat:@"HH:mm:ss"];
    text = [text stringByReplacingOccurrencesOfString:@"time" withString:[formatter stringFromDate:now]];

    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    text = [text stringByReplacingOccurrencesOfString:@"full" withString:[formatter stringFromDate:now]];

    [now release];
    [formatter release];
    
    int days = (int)timeInterval %(60*60*24*30)/(60*60*24);      //不到一个月
    int hours = (int)timeInterval %(60*60*24)/(60*60);           //不到一天
    int minutes = (int)timeInterval %(60*60)/60;
    int seconds = (int)timeInterval % 60;
    NSString * lastString = @"";
    if (days > 30)  lastString = @"一个月前";
    else if(days > 0) lastString = [NSString stringWithFormat:@"%d天前",days];
    else if (hours > 0) lastString = [NSString stringWithFormat:@"%d小时前",hours];
    else if (minutes > 0) lastString = [NSString stringWithFormat:@"%d分钟前",minutes];
    else if (seconds > 0) lastString = [NSString stringWithFormat:@"%d秒前",seconds];

    text = [text stringByReplacingOccurrencesOfString:@"relative" withString:lastString];
    
    isInnerSetting = true;
    self .text = text;
    isInnerSetting = false;
}
@end
