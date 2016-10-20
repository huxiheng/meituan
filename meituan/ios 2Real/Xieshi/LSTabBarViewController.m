//
//  LSTabBarViewController.m
//  Aichi
//
//  Created by Lessu on 13-10-16.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSTabBarViewController.h"
#import "VerifyViewController.h"
#import "ApplyViewController.h"

#import "WorkSiteListViewController.h"
#import "TodayViewController.h"
#import "UnqualifiedSearchViewController.h"

#import "ProjectViewController.h"
#import "RouteViewController.h"
#import "UploadViewController.h"
@interface LSTabBarViewController ()
@property(nonatomic,retain) NSArray *viewControllers;
@end

@implementation LSTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpTabs];
    
    _selectedIndex = -1;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_selectedIndex<0) {
        self.selectedIndex = 0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpTabs{
//    [self.tabBar setHidden:YES];
    [self hidesBottomBarWhenPushed];

	self.viewControllers = @[
                             wrapNavigationController([[VerifyViewController alloc]init]),
                             wrapNavigationController([[ApplyViewController alloc]init]),
                             
                             wrapNavigationController([[WorkSiteListViewController alloc]init]),
                             wrapNavigationController([[TodayViewController alloc]init]),
                             wrapNavigationController([[UnqualifiedSearchViewController alloc]init]),
                             
                             wrapNavigationController([[ProjectViewController alloc]init]),
                             wrapNavigationController([[UploadViewController alloc]init]),
                             wrapNavigationController([[UploadViewController alloc]init])
                             ];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.view addSubview:LS_CAST(UIViewController *, self.viewControllers[_selectedIndex]).view];
    LS_CAST(UIViewController *, self.viewControllers[_selectedIndex]).view.frame = self.view.bounds;
}
@end
