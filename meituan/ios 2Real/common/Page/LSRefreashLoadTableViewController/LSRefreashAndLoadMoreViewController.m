//
//  LSRefreashAndLoadMoreViewController.m
//  Yingcheng
//
//  Created by lessu on 14-3-10.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "LSRefreashAndLoadMoreViewController.h"

@interface LSRefreashAndLoadMoreViewController ()

@end

@implementation LSRefreashAndLoadMoreViewController

- (void)viewDidLoad
{
    self.footerViewDataSource = self;
    self.listView = self.tableView;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshAndLoadMoreListViewController:(LSRefreshAndLoadMoreListViewController*) viewController setFooterView:(UIView *)footer{
    _tableView.tableFooterView = footer;
}

- (UIView *)footerViewForRefreshAndLoadMoreListViewController:(LSRefreshAndLoadMoreListViewController*) viewController{
    return _tableView.tableFooterView;
}

@end
