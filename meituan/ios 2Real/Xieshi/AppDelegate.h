//
//  AppDelegate.h
//  LSTemplate
//
//  Created by Lessu on 13-7-15.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XieshiMainViewController.h"
//#import "BMapKit.h"
#import "XSMainViewController.h"
#import "XSLeftViewController.h"
#import "XSRightViewController.h"


#define APP_DELEGATE    ((AppDelegate *) [UIApplication sharedApplication].delegate)
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>
{
    BMKMapManager* _mapManager;    
}
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain) UINavigationController *rootNavigationController;
@property(nonatomic,retain) UITabBarController     *rootTabbarController;

@property(nonatomic,retain) XieshiMainViewController *rootMainViewController;

/// 抽屉效果
@property (nonatomic, strong)XSLeftViewController *leftController;
@property (nonatomic, strong)XSMainViewController  *xsMainController;
@property (nonatomic, strong)IIViewDeckController *deckController;

- (IIViewDeckController*)generateControllerStack;

@end
