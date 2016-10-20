//
//  XieshiMainViewController.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-22.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "LSUnderSideViewController.h"

@class LSTabBarViewController;
@interface XieshiMainViewController : LSUnderSideViewController
@property(nonatomic,retain) NSString *userPowerString;
@property(nonatomic,retain) LSTabBarViewController* tabbarViewController;

@end
