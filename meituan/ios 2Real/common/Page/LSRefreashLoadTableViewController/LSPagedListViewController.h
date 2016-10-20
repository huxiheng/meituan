//
//  LSVerySimplePagedTableViewController.h
//  YinfengShop
//
//  Created by lessu on 13-12-19.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//  using ARC

// v1.1加入debugmode
#import "LSRefreshAndLoadMoreListViewController.h"
#import "LSPageController.h"
@protocol LSVerySimpledListViewControllerDelegate;
@protocol LSVerySimpledListViewDataSource;

@interface LSPagedListViewController : LSRefreshAndLoadMoreListViewController

@property(nonatomic,readonly)   NSString * apiName;
@property(nonatomic,retain)     NSDictionary *apiParams;
@property(nonatomic,strong)     LSPageController  *pageController;
@property(nonatomic,assign)     BOOL isFirstLoad;
@property(nonatomic,assign)     BOOL loadOnlyOnce;
@property(nonatomic,assign)     id<LSVerySimpledListViewControllerDelegate> delegate;
@property(nonatomic,assign)     id<LSVerySimpledListViewDataSource>         dataSource;

@property(nonatomic,assign)     BOOL isDebugMode;
@property(nonatomic,assign)     NSInteger debugItemCount;
@property(nonatomic,assign)     NSDictionary *debugItemData;

- (NSDictionary *)itemForIndexPath:(NSIndexPath *)indexPath;

@end

@protocol LSVerySimpledListViewControllerDelegate <NSObject>

@required
- (void)listViewController:(LSPagedListViewController*)listViewController  toSetFooterView:(LSTableViewPullLoadFooterView *)footerView;
- (void)listViewController:(LSPagedListViewController *)listViewController toListViewReload:(id)listView;

@optional
- (void)listViewController:(LSPagedListViewController*)listViewController afterInitPageController:(LSPageController *)pageController;
- (void)listViewControllerOnRefreshRequest:(LSPagedListViewController*)listViewController;
- (void)listViewControllerOnNextRequest:(LSPagedListViewController*)listViewController;

@end

@protocol LSVerySimpledListViewDataSource <NSObject>

@optional
- (NSString *)  listViewCellNibName:(UITableView *)tableView;
- (void)        listView:(id)listView fillCell:(id)cell withData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)     listView:(id)listView cellHeightForData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath;
- (void)        listView:(id)listView didSelectedWithData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath;

@end
