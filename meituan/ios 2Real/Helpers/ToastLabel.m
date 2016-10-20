//
//  ToastLabel.m
//  J1health
//
//  Created by zhizi on 15/8/14.
//  Copyright (c) 2015年 J1. All rights reserved.
//

#import "ToastLabel.h"

@implementation ToastLabel
+(UIView *)toastWithString:(NSString *)string {
    float width =[NSString calculateTextWidth:200 Content:string font:themeFont12];
    UIView *returnView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, MIN(200, width +20), 32.0)];
    UILabel *labelTitle =[[UILabel alloc] initWithFrame:returnView.frame];
    labelTitle.font =themeFont12;
    labelTitle.textAlignment =NSTextAlignmentCenter;
    labelTitle.text =string;
    labelTitle.numberOfLines=0;
    labelTitle.textColor =[UIColor whiteColor];
    [returnView addSubview:labelTitle];
    returnView.backgroundColor =[UIColor blackColor];
    returnView.alpha =0.8;
    returnView.layer.cornerRadius =2.0f;
    returnView.layer.masksToBounds =YES;
    return returnView;
}
+(UIView *)toastWithGreenWhiteString:(NSString *)string{
    float width =[NSString calculateTextWidth:200 Content:string font:themeFont12];
    UIView *returnView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, MIN(200, width +20), 32.0)];
    UILabel *labelTitle =[[UILabel alloc] initWithFrame:returnView.frame];
    labelTitle.font =themeFont12;
    labelTitle.textAlignment =NSTextAlignmentCenter;
    labelTitle.text =string;
    labelTitle.textColor =[UIColor whiteColor];
    [returnView addSubview:labelTitle];
    returnView.backgroundColor =[UIColor colorWithHexString:knavBJColor];
    returnView.alpha =0.8;
    returnView.layer.cornerRadius =16.0f;
    returnView.layer.masksToBounds =YES;
    return returnView;
}
@end
