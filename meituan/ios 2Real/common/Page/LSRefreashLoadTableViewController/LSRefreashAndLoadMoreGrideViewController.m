//
//  LSRefreashAndLoadMoreGrideViewController.m
//  Yingcheng
//
//  Created by lessu on 14-1-3.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "LSRefreashAndLoadMoreGrideViewController.h"
@interface LSRefreashAndLoadMoreGrideViewController ()

@end

@implementation LSRefreashAndLoadMoreGrideViewController

- (void)viewDidLoad
{
    self.listView = _gridView;
    self.footerViewDataSource = self;
    [super viewDidLoad];
}

- (void)refreshAndLoadMoreListViewController:(LSRefreshAndLoadMoreListViewController*) viewController setFooterView:(UIView *)footer{
    _gridView.gridFooterView = footer;
}

- (UIView *)footerViewForRefreshAndLoadMoreListViewController:(LSRefreshAndLoadMoreListViewController*) viewController{
    return _gridView.gridFooterView;
}

@end
