//
//  LSRefreashAndLoadMoreViewController.h
//  Yingcheng
//
//  Created by lessu on 14-3-10.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "LSRefreshAndLoadMoreListViewController.h"

@interface LSRefreashAndLoadMoreViewController : LSRefreshAndLoadMoreListViewController<LSRefreshAndLoadMoreListViewControllerFooterViewDataSource>
{
    __weak UITableView *_tableView;   
}
@property(nonatomic,weak) IBOutlet UITableView *tableView;
@end
