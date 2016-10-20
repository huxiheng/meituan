//
//  LSRefreashAndLoadMoreGrideViewController.h
//  Yingcheng
//
//  Created by lessu on 14-1-3.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRGridView.h"
#import "LSRefreshAndLoadMoreListViewController.h"
@interface LSRefreashAndLoadMoreGrideViewController:LSRefreshAndLoadMoreListViewController<LSRefreshAndLoadMoreListViewControllerFooterViewDataSource>
{
@protected
    NRGridView                         *_gridView;
}
@property(nonatomic,retain) IBOutlet NRGridView *gridView;

@end
