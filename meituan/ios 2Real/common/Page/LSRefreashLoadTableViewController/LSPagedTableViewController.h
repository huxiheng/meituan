//
//  LSVerySimplePagedTableViewController.h
//  YinfengShop
//
//  Created by lessu on 13-12-19.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//  using ARC

#import "LSRefreashAndLoadMoreViewController.h"
#import "LSPageController.h"
@interface LSPagedTableViewController : LSRefreashAndLoadMoreViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) LSPageController  *pageController;
@property(nonatomic,assign) BOOL isFirstLoad;
@property(nonatomic,assign) BOOL loadOnlyOnce;

@property(nonatomic,assign)     BOOL enableDebugMode;
@property(nonatomic,assign)     NSInteger debugItemCount;
@property(nonatomic,assign)     NSDictionary *debugItemData;
- (NSDictionary *)itemForIndexPath:(NSIndexPath *)indexPath;

//to Implement
- (void)toInitPageControllerWith:(NSString **) apiName params:(NSDictionary **)params;
- (void)afterInitPageController:(LSPageController *)pageController;
- (void)setUpPageController;

- (void)        simpleTableView:(UITableView *)tableView fillCell:(id)cell withData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath;
- (NSString *)  simpleTableViewCellNibName:(UITableView *)tableView;
- (CGFloat)     simpleTableView:(UITableView *)tableView cellHeightForData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath;
- (void)        simpleTableView:(UITableView *)tableView didSelectedWithData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath;

- (BOOL)        onRefreshRequest;
- (BOOL)        onNextRequest;

- (void)        refreshNoMerge;
- (void)        refresh;

///设置导航条
@property (nonatomic, copy)NSString *titleForNav;
@property (nonatomic, strong)UILabel *labelNavTitle;
- (void)setdataForNav;
@end
