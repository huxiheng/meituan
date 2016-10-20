//
//  LSRefreshAndLoadMoreListViewController.h
//  Yingcheng
//
//  Created by lessu on 14-3-10.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "EGORefreshTableHeaderView.h"
#import "LSTableViewPullLoadFooterView.h"
@protocol LSRefreshAndLoadMoreListViewControllerFooterViewDataSource;
@interface LSRefreshAndLoadMoreListViewController : UIViewController<UITableViewDelegate,UIScrollViewDelegate,EGORefreshTableHeaderDelegate,LSRefreshTableFooterDelegate>
{
@protected
    BOOL                                _isRefreashing;
    BOOL                                _isLoading;
    BOOL                                _hasMore;
    NSDate                              *_lastUpdate;
    
    EGORefreshTableHeaderView           *_refreshHeaderView;
    LSTableViewPullLoadFooterView       *_loadMoreFooterView;
    
    
    NSTimeInterval                      _minRequestTime;
    UIScrollView                         *_listView;
}

@property(nonatomic,assign) BOOL hasMore;
/**
 * 设置最少的网络访问时间
 */
@property(nonatomic,assign) NSTimeInterval loadingDelay;
//@property(nonatomic,assign) CGFloat loadMoreTriggerDistance;
//must be setted;
@property(nonatomic,assign) id<LSRefreshAndLoadMoreListViewControllerFooterViewDataSource> footerViewDataSource;
@property(nonatomic,retain) IBOutlet UIScrollView    *listView;

- (void)finishRefreash;
- (void)finishLoading;

- (void) lsViewControllerShouldRefreash:(LSRefreshAndLoadMoreListViewController*)viewController;
- (void) lsViewControllerShouldLoadMore:(LSRefreshAndLoadMoreListViewController*)viewController;

@end

@protocol LSRefreshAndLoadMoreListViewControllerFooterViewDataSource<NSObject>
@required
//- (void)refreshAndLoadMoreListViewController:(LSRefreshAndLoadMoreListViewController*) viewController setHeader:(UIView *)header;

//- (UIView *)headerForRefreshAndLoadMoreListViewController:(LSRefreshAndLoadMoreListViewController*) viewController;

- (void)refreshAndLoadMoreListViewController:(LSRefreshAndLoadMoreListViewController*) viewController setFooterView:(UIView *)footer;

- (UIView *)footerViewForRefreshAndLoadMoreListViewController:(LSRefreshAndLoadMoreListViewController*) viewController;
@end
