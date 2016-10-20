//
//  LSRefreshAndLoadMoreListViewController.m
//  Yingcheng
//
//  Created by lessu on 14-3-10.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//
#define TEXT_COLOR	 [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1.0]
#define FOOTER_OFFSET_Y 0
#import "LSRefreshAndLoadMoreListViewController.h"
#import "UIView+Sizes.h"

@interface LSRefreshAndLoadMoreListViewController()
{
    float   _scFooterHeight;
}
@end
@implementation LSRefreshAndLoadMoreListViewController


- (id)init
{
    self = [super init];
    if (self) {
        _minRequestTime = 0;
//        _loadMoreTriggerDistance = 50;
    }
    return self;
}

- (void)viewDidLoad
{
    IOS7_LAYOUT_FIX;
    [super viewDidLoad];
    NSAssert(_listView, @"listView 为 nil");
    NSAssert(_footerViewDataSource,   @"delegate 为 空");
    _hasMore = true;
    
    self .listView . clipsToBounds = NO;
    
    // Ego refreshHeader
	if (_refreshHeaderView == nil) {
        CGRect refreshHeaderFrame = CGRectMake(0.0f, 0.0f - self .listView .bounds.size.height, self .listView .bounds.size.width, self .listView.bounds.size.height);
		_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:refreshHeaderFrame];
		_refreshHeaderView.delegate = self;
		[_refreshHeaderView setBackgroundColor:[UIColor clearColor]];
		[self.listView addSubview:_refreshHeaderView];
	}
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, FOOTER_OFFSET_Y)];
    footView .clipsToBounds = NO;

    [_footerViewDataSource refreshAndLoadMoreListViewController:self setFooterView:footView];
    
    [footView release];
    
    // LS loadFooter
    if (_loadMoreFooterView == nil) {
        _loadMoreFooterView = [[LSTableViewPullLoadFooterView alloc]initWithFrame:CGRectMake(0, footView.frame.size.height , self.listView.frame.size.width, self .listView .frame.size.height)];
        _loadMoreFooterView.delegate = self;
        [footView addSubview:_loadMoreFooterView];
    }
    
    [self.listView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:self.listView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

//- (void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//    CGSize contentSize = _listView .contentSize;
//    float deltaHeight = _listView .height - contentSize .height;
//    deltaHeight = MAX(0 , deltaHeight);
//    
//    CGFloat top = deltaHeight + self.loadMoreTriggerDistance;
//    if (IS_IOS7 && self.tabBarController && !self.tabBarController.hidesBottomBarWhenPushed) {
//        top -= self.tabBarController.tabBar.height;
//    }
//    _loadMoreFooterView.frame = CGRectMake(0, top , self.listView.frame.size.width, self .listView .frame.size.height);
//    _loadMoreFooterView.contentOffsetY = top;
//}

- (void)dealloc
{
    [self.listView removeObserver:self forKeyPath:@"contentSize"];
    [_listView release];               
    _listView = nil;
    [_refreshHeaderView release];
    [_loadMoreFooterView release];
    [_lastUpdate release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    CGSize contentSize = _listView .contentSize;
    float deltaHeight  = _listView .height - contentSize .height;
    deltaHeight = MAX(0 , deltaHeight);
    
    CGFloat top = deltaHeight;

    _loadMoreFooterView.frame = CGRectMake(0, top , self.listView.frame.size.width, self .listView .frame.size.height);
    _loadMoreFooterView.contentOffsetY = top;


}


#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    if (_hasMore) {
        [_loadMoreFooterView lsLoadScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    if (_hasMore) {
        [_loadMoreFooterView lsLoadScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark - EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
    
    [self performSelector:@selector(lsViewControllerShouldRefreash:) withObject:self afterDelay:_loadingDelay];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
    if (_isRefreashing) return _isRefreashing;
	return false;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
    [_lastUpdate release];
    _lastUpdate = [[NSDate alloc]init];
    return _lastUpdate;
    
}
#pragma mark - LSLoadTableFooterDelegate Methods
- (void)lsLoadTableFooterDidTriggerLoad:(LSTableViewPullLoadFooterView*)view{
    
    [self performSelector:@selector(lsViewControllerShouldLoadMore:) withObject:self afterDelay:_loadingDelay];
}
- (BOOL)lsLoadTableFooterDataSourceIsLoading:(LSTableViewPullLoadFooterView*)view{
    if (_isLoading) return _isLoading;
    return false;
}
#pragma mark -
#pragma mark Method
- (void)finishRefreash{
    _isRefreashing = false;
    [_refreshHeaderView performSelector:@selector(egoRefreshScrollViewDataSourceDidFinishedLoading:) withObject:self .listView];
}
- (void)finishLoading{
    
    _isLoading = false;
    [_loadMoreFooterView performSelector:@selector(lsLoadScrollViewDataSourceDidFinishedLoading:) withObject:self .listView];
}

- (void)setHasMore:(BOOL)hasMore{
    _hasMore = hasMore;
    [_loadMoreFooterView setHasMore:hasMore];
    [self.listView layoutSubviews];
}
- (void)setListView:(UIScrollView *)scrollView{
    if (_listView == scrollView) {
        return;
    }
    
    [_listView release];
    _listView = [scrollView retain];
    _listView .delegate = self;
}
#pragma mark - Methods should be Implement
- (void) lsViewControllerShouldRefreash:(LSRefreshAndLoadMoreListViewController*)viewController{
    _isRefreashing = true;
}
- (void) lsViewControllerShouldLoadMore:(LSRefreshAndLoadMoreListViewController *)viewController{
    _isLoading = true;
}

@end
