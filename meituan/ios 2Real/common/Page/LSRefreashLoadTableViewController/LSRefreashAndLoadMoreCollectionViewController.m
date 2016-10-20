//
//  LSRefreashAndLoadMoreGrideViewController.m
//  Yingcheng
//
//  Created by lessu on 14-1-3.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "LSRefreashAndLoadMoreCollectionViewController.h"
@interface LSRefreashAndLoadMoreCollectionViewController ()

@end

@implementation LSRefreashAndLoadMoreCollectionViewController

- (void)viewDidLoad
{
    self.listView = self.collectionView;
    self.footerViewDataSource = self;
    [super viewDidLoad];
    
}
- (void)refreshAndLoadMoreListViewController:(LSRefreshAndLoadMoreListViewController*) viewController setFooterView:(UIView *)footer{
    _collectionView.footerView = footer;
}

- (UIView *)footerViewForRefreshAndLoadMoreListViewController:(LSRefreshAndLoadMoreListViewController*) viewController{
    return     _collectionView.footerView;    
}

@end
