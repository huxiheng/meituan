//
//  AppMacro.h
//  HZ
//
//  Created by huazi on 14-8-4.
//  Copyright (c) 2014年 HZ. All rights reserved.
#ifndef Mall_ThemeMacro_h
#define Mall_ThemeMacro_h
#define colorTheme    [UIColor orangeColor]
#define colorThemelightGrayColor [UIColor lightGrayColor]
#define colorThemegrayColor  [UIColor grayColor]

#define knavBJColor  @"#2cc490"
#define kviewBJColor @"#f0eff4"
#define KcolorWhite  @"#ffffff"
#define kcolorTheme  @"#4fc9a2"
#define kcolorBJTheme    @"#fdfdfd"
#define kcolorBJ_f0eff4  @"#f0eff4"
#define kcolorViewBJ_f8f8f8 @"#f8f8f8"
#define kcolorViewBJ_f0eff4 @"#f0eff4"
#define kcolorViewDigestPostColor @"#f8b832"
#define kcolorLine     [UIColor colorWithHexString:@"#dddddd"]

//UIControlStateNormal       = 0,
//UIControlStateHighlighted  = 1 << 0,                  // used when UIControl isHighlighted is set
//UIControlStateDisabled     = 1 << 1,
//UIControlStateSelected     = 1 << 2,                  // flag usable by app (see below)
//UIControlStateApplication  = 0x00FF0000,              // additional flags available for application use
//UIControlStateReserved     = 0xFF000000
#define kbtnColorBJNormalState        @"#2cc490"
#define kbtnColorBJHighlightedState   @"#279f76"
#define kbtnWhiteColorBJHighlightedState   @"#f3f3f3"
#define kc00_1bc4ac      @"#1bc4ac"
#define kc00_b89d83      @"#b89d83"
#define kc00_ff7e00      @"#ff7e00"
#define kc00_2c2c2c      @"#2c2c2c"
#define kc00_999999      @"#999999"
#define kc00_666666      @"#666666"
#define kc00_f5f5f5      @"#f5f5f5"
#define kc00_2cc490      @"#2cc490"
#define kc00_2cc390      @"#2cc390"
#define kc00_fe7402      @"#fe7402"
#define kc00_da9317      @"#da9317"
#define kc00_35a6f2      @"#35a6f2"
#define kc00_007aff      @"#007aff"
#define kc00_256ad0      @"#256ad0"
#define kc00_df1a1a      @"#df1a1a"
#define kc00_e5e5e5      @"#e5e5e5"
#define kc00_545454      @"#545454"
#define kc00_4c4c4c      @"#4c4c4c"
#define kc00_d7d7d7      @"#d7d7d7"
#define kc00_e5e5e5      @"#e5e5e5"
#define kc00_26aef0      @"#26aef0"
#define kc00_FA4139      @"#FA4139"
#define kc00_333333      @"#333333"
#define kc00_2d3233      @"#2d3233"
#define kc00_8c8c8c      @"#8c8c8c"
#define kc00_717171      @"#717171"
#define kc00_AAD5EE      @"#AAD5EE"
#define kc00_0062A3      @"#0062A3"
#define kc00_7ED127      @"#7ED127"
#define kc00_38CB1A      @"#38CB1A"
#define kc00_1A90CD      @"#1A90CD"
#define kc00_E00A2D      @"#E00A2D"
#define kc00_A5A4A4      @"#A5A4A4"
#define kc00_f8f9fb      @"#f8f9fb"
#define kc00_F0A568      @"#F0A568"
#define kc00_007EFF      @"#007EFF"
#define kc00_f90000      @"#f90000"
#define kc00_FE4C4D      @"#FE4C4D"
#define kc00_FF6600      @"#FF6600"
#define kc00_3385FF      @"#3385FF"
#define kc00_7F7F7F      @"#7F7F7F"


#define kFirstLaunch     @"FirstLaunch"      //NSUserDefaults

#define kpage_size  @"20"
#define kpage_size_big   @"200000"
//#define kPosition  [NSValue valueWithCGPoint:CGPointMake(DeviceWidth/2, DeviceHeight -100+16)]
#define kPosition  [NSValue valueWithCGPoint:CGPointMake(DeviceWidth / 2, DeviceHeight / 2)]
#define kReportPosition  [NSValue valueWithCGPoint:CGPointMake(DeviceWidth/2, DeviceHeight/2)]
#define kPostPosition [NSValue valueWithCGPoint:CGPointMake(DeviceWidth/2, 64+20)]
#define kCheckPosition [NSValue valueWithCGPoint:CGPointMake(DeviceWidth/2, DeviceHeight*3/4)]
#define ktagReportView  2312
#define ktagImageBrowserFirst 3290 
#define kplaceholderImageHead  [UIImage imageNamed:@"icon_nohead"]
#define kplaceholderImage  [UIImage imageNamed:@"icon_nopicture"]

#define kMaxUploadImage9  9

#define HYWeakObj(o) autoreleasepool{} __weak typeof(o)  Weak##o = o;
#define HYStrongObj(o) autoreleasepool{} __strong typeof(o) o = Weak##o;

#endif



