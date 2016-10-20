//
//  SVProgressHUD+SVProgressHUD_LSTemplate.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-29.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "SVProgressHUD+LSTemplate.h"

@implementation SVProgressHUD (LSTemplate)

+ (void)dismissWithSuccess{
    [self showSuccessWithStatus:nil];
}
+ (void)dismissWithSuccess:(NSString *)status{
    [self showSuccessWithStatus:status];
}
+ (void)dismissWithError:(NSString *)error{
    [self showErrorWithStatus:error];
}
+ (void)dismissWithError:(NSString *)error afterDelay:(NSTimeInterval)duration{
    [self dismissWithError:error];
}
+ (void)showErrorWithStatus:(NSString *)status duration:(NSTimeInterval)duration{
    [self showErrorWithStatus:status];
}
@end
