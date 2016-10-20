//
//  XieshiMainViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-22.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "XieshiMainViewController.h"
#import "LSTabBarViewController.h"
#import "LeftSideViewController.h"
#import "WorkSiteListViewController.h"
@interface XieshiMainViewController ()<LeftSideViewControllerDelegate>
//@property(nonatomic,retain) LSTabBarViewController* tabbarViewController;
@property(nonatomic,retain) UINavigationController* navigationController;
@property(nonatomic,retain) LeftSideViewController* leftSideViewController;


@end

@implementation XieshiMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _navigationController = [[UINavigationController alloc]initWithRootViewController:[[WorkSiteListViewController alloc]init]];
    

    _leftSideViewController = [[LeftSideViewController alloc]init];
    self.leftViewController = _leftSideViewController;
    [self addChildViewController:_leftSideViewController];
    
    _leftSideViewController.delegate = self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.leftViewController.view.height = self.view.height;
    _tabbarViewController.view.height = self.view.height;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUserPowerString:(NSString *)userPowerString{
    
    [_tabbarViewController removeFromParentViewController];
    [_tabbarViewController.view removeFromSuperview];
    
    _tabbarViewController = [[LSTabBarViewController alloc]init];
    [self.centerContainerView addSubview:_tabbarViewController.view];
    [self addChildViewController:_tabbarViewController];
    
    _userPowerString = userPowerString;
    _leftSideViewController.powerString = userPowerString;
    [_leftSideViewController selectFirst];
    [self showLeft];
}

- (void)leftSideViewController:(LeftSideViewController *)controller didSelectedWithName:(XieshiModuleName)name{
    _tabbarViewController.selectedIndex = name;
    [self hideLeft];
//    self.enableGesture = true;
    switch (name) {
        case XieshiModuleNameVerify:
            break;
        case XieshiModuleNameApply:
            break;
        case XieshiModuleNameSample:
            break;
        case XieshiModuleNameToday:
            break;
        case XieshiModuleNameUnqualified:
            break;
        case XieshiModuleNameProject:
//            self.enableGesture = false;
            break;
        case XieshiModuleNameRoute:
            break;
        case XieshiModuleNameUpload:
            break;
        default:
            break;
    }
}
@end
