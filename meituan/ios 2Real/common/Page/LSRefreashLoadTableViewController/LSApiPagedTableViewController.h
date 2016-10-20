//
//  LSPagedTableViewController.h
//  Yingcheng
//
//  Created by lessu on 14-2-19.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "LSRefreashAndLoadMoreViewController.h"
#import "LSTableViewCell.h"
#import "LSPageController.h"
@interface LSApiPagedTableViewController : LSRefreashAndLoadMoreViewController<UITableViewDataSource>
{
    LSPageController  *_pageController;
}

@property(nonatomic,strong) LSPageController  *pageController;
@property(nonatomic,strong) NSString     *apiName;
@property(nonatomic,strong) Class        cellClass;

- (id)initWithApiName:(NSString *)apiName andCellClass:(Class)cellClass;

- (void)afterInitPageController:(LSPageController *)pageController;

@end
