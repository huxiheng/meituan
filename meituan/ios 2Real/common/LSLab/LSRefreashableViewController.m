//
//  LSRefreashableViewController.m
//  Yingfeng
//
//  Created by lessu on 13-12-31.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//
#if !__has_feature(objc_arc)
#error this file needs to arc support
#endif
#import "LSRefreashableViewController.h"
@interface LSRefreashableViewController ()
{
    EGORefreshTableHeaderView           *_refreshHeaderView;
    NSDate                              *_lastUpdate;
}
@end

@implementation LSRefreashableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    IOS7_LAYOUT_FIX;
    [super viewDidLoad];
    NSAssert(self.scrollView, @"scrollView为空");
//    self .scrollView . clipsToBounds = YES;
    self .scrollView . delegate = self;
    // Ego refreshHeader
    if (_refreshHeaderView == nil) {
        CGRect refreshHeaderFrame = CGRectMake(0.0f, 0.0f - self .scrollView .bounds.size.height, self .scrollView .bounds.size.width, self .scrollView.bounds.size.height);
		_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:refreshHeaderFrame];
		_refreshHeaderView.delegate = self;
		[_refreshHeaderView setBackgroundColor:[UIColor clearColor]];
		[self.scrollView addSubview:_refreshHeaderView];
	}

}
//- (void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//    if (_refreshHeaderView != nil) {
//        CGRect refreshHeaderFrame = CGRectMake(0.0f, 0.0f - self .scrollView .bounds.size.height, self .scrollView .bounds.size.width, self .scrollView.bounds.size.height);
//        _refreshHeaderView.frame = refreshHeaderFrame;
//	}
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
    [self performSelector:@selector(lsRefreashableViewControllerWillRefreash) withObject:self afterDelay:_loadingDelay];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
    if (_isRefreashing) return _isRefreashing;
	return false;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
    _lastUpdate = [[NSDate alloc]init];
    return _lastUpdate;
    
}
#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}
#pragma mark -
#pragma mark Method
- (void)finishRefreash{
    _isRefreashing = false;
    [_refreshHeaderView performSelector:@selector(egoRefreshScrollViewDataSourceDidFinishedLoading:) withObject:self .scrollView];
}

- (void)lsRefreashableViewControllerWillRefreash{
    [self finishRefreash];
}
@end
