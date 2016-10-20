//
//  AppMacro.h
//  HZ
//
//  Created by huazi on 14-8-4.
//  Copyright (c) 2014年 HZ. All rights reserved.

#ifndef Mall_UtilsMacro_h
#define Mall_UtilsMacro_h
#define UIColorFromRGB(r,g,b) [UIColor \
colorWithRed:r/255.0 \
green:g/255.0 \
blue:b/255.0 alpha:1]
#define IOS8  [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define IOS7  [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define NSStringFromInt(intValue) [NSString stringWithFormat:@"%d",intValue]
#define DeviceRect   [UIScreen mainScreen].bounds
#define DeviceHeight [UIScreen mainScreen].bounds.size.height
#define DeviceWidth  [UIScreen mainScreen].bounds.size.width
#define ViewWidth    self.frame.size.width
#define ViewHeight   self.frame.size.height
#define kBuild       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define kVersion     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kAPPDisplayName     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define kBundleIdentifier   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]


#define themeFont(x) [UIFont systemFontOfSize:x]
#define themeFont24  [UIFont systemFontOfSize:24.0f]
#define themeFont23  [UIFont systemFontOfSize:23.0f]
#define themeFont22  [UIFont systemFontOfSize:22.0f]
#define themeFont21  [UIFont systemFontOfSize:21.0f]
#define themeFont20  [UIFont systemFontOfSize:20.0f]
#define themeFont19  [UIFont systemFontOfSize:19.0f]
#define themeFont18  [UIFont systemFontOfSize:18.0f]
#define themeFont17  [UIFont systemFontOfSize:17.0f]
#define themeFont16  [UIFont systemFontOfSize:16.0f]
#define themeFont15  [UIFont systemFontOfSize:15.0f]
#define themeFont14  [UIFont systemFontOfSize:14.0f]
#define themeFont13  [UIFont systemFontOfSize:13.0f]
#define themeFont12  [UIFont systemFontOfSize:12.0f]
#define themeFont11  [UIFont systemFontOfSize:11.0f]
#define themeFont10  [UIFont systemFontOfSize:10.0f]
#define themeFont9   [UIFont systemFontOfSize:9.0f]

#define themescaleFont(size) [UIFont systemFontOfSize:size*DeviceWidth/375.0]

#define themeBoldFont(x)  [UIFont boldSystemFontOfSize:x]
#define themeBoldFont17   [UIFont boldSystemFontOfSize:17.0f]
#define themeBoldFont16   [UIFont boldSystemFontOfSize:16.0f]
#define themeBoldFont15   [UIFont boldSystemFontOfSize:15.0f]
#define themeBoldFont14   [UIFont boldSystemFontOfSize:14.0f]
#define themeBoldFont13   [UIFont boldSystemFontOfSize:13.0f]
#define themeFontSize(size) [UIFont systemFontOfSize:size]
#define kscaleDeviceWidth(width)  (width*DeviceWidth)/375.0
#define kscaleDeviceHeight(height)  (height*DeviceWidth)/375.0
#define kscaleDeviceLength(length)  ((length)*DeviceWidth)/375.0
#define kSpace            12.0f
#define kscaleIphone5DeviceLength(length)  ((length)*DeviceWidth)/320.0
#define kscaleIphone6DeviceLength(length)  ((length)*DeviceHeight)/667.0
#define kscaleIphone6DeviceHeight(length)  ((length)*DeviceHeight)/667.0
#endif