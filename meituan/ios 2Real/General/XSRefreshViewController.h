//
//  XSRefreshViewController.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/20.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "LSPageController.h"
#import "MJRefresh.h"

@interface XSRefreshViewController : UIViewController
///刷新页面的网络请求
@property(nonatomic,strong) LSPageController  *pageController;
@property(nonatomic,assign) BOOL isFirstLoad;
@property(nonatomic,assign) BOOL loadOnlyOnce;

@property(nonatomic,assign)     BOOL enableDebugMode;
//to Implement
- (void)toInitPageControllerWith:(NSString **) apiName params:(NSDictionary **)params;
- (void)afterInitPageController:(LSPageController *)pageController;


/**
 *  刷新table
 *
 *  @param scroll scroll description
 */
- (void)addRefreshHeader:(UIScrollView *)scroll;

/**
 *  上拉加载更多数据
 *
 *  @param scroll scroll description
 */
- (void)addRefreshFooter:(UIScrollView *)scroll;

/**
 *  上拉加在，下拉刷新更多数据
 *
 *  @param scroll scroll description
 */
- (void)addRefreshHeaderAndFooter:(UIScrollView *)scroll;

/**
 *  记录刷新的状态
 *
 *  @param status <#status description#>
 */
- (void)setRefreshFooterStatus:(MJRefreshState)status;
- (void)setsetRefreshFooterStatusFromRefreshId:(NSString *)refreshId AndCurrentCount:(NSInteger)count;
- (void)endRefresh;


//设置导航条的iterm

@property (nonatomic, strong)UILabel  *labelNavTitle;
@property (nonatomic, copy)NSString   *titleForNav;

/**
 *  设置导航条的leftiterm
 *
 *  @param str   str description
 *  @param image image description
 */
- (void)setNavLeftItemWith:(NSString *)str andImage:(UIImage *)image;

/**
 *  设置导航的rightitem
 *
 *  @param str   str description
 *  @param image image description
 */
- (void)setNavRightItemWith:(NSString *)str andImage:(UIImage *)image;
- (void)setNavRightItems:(NSArray *)arrays;

- (void)setData;

- (void)rightItemClick:(id)sender;
- (void)rightItem2Click:(id)sender;
- (void)leftItemClick:(id)sender;
@end
