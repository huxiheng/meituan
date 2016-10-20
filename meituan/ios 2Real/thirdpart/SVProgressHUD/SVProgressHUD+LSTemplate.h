//
//  SVProgressHUD+SVProgressHUD_LSTemplate.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-29.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "SVProgressHUD.h"

//extern static UIImage *SVProgressHUDInfoImage;
//extern static UIImage *SVProgressHUDSuccessImage;
//extern static UIImage *SVProgressHUDErrorImage;

@interface SVProgressHUD (LSTemplate)
+ (void)dismissWithSuccess;
+ (void)dismissWithSuccess:(NSString *)status;


+ (void)dismissWithError:(NSString *)error;
//deprecated 
+ (void)dismissWithError:(NSString *)error afterDelay:(NSTimeInterval)duration;

//deprecated 
+ (void)showErrorWithStatus:(NSString *)status duration:(NSTimeInterval)duration;
@end
