//
//  LSVerySimplePagedTableViewController.m
//  YinfengShop
//
//  Created by lessu on 13-12-19.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

//v 1.1
//新增加载提示
#import "LSPagedListViewController.h"

@interface LSPagedListViewController ()
//{
//    NSString *_reuseIdentifier;
//}
//@property(nonatomic,retain)         UIView *emptyHintView;
@end

@implementation LSPagedListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {
        _loadOnlyOnce = false;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpPageController];
//    NSAssert(nibName,@"无法获取到nib name");

//    _reuseIdentifier = @"Cell";
//    if (nibName) {
//        [_tableView registerNib:[UINib nibWithNibName:nibName bundle:0] forCellReuseIdentifier:_reuseIdentifier];
//    }
    _isFirstLoad = true;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_loadOnlyOnce || (_loadOnlyOnce && _isFirstLoad)) {
        [_pageController refresh];
        
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		_listView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        [_refreshHeaderView setState:EGOOPullRefreshLoading];
        _listView.contentOffset = CGPointMake(0, -60);
		[UIView commitAnimations];
    }
    _isFirstLoad = false;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_pageController cancelLoading];
    [_pageController cancelRefreashing];
}

#pragma mark method
- (NSDictionary *)itemForIndexPath:(NSIndexPath *)indexPath{
    return  _pageController.list[indexPath.row];
}

- (void)setUpPageController{
    _pageController = [[LSPageController alloc]initWithApiName:self.apiName];
    __block LSPageController *bPageController = _pageController;
    __block typeof(self) bSelf = self;
    
    [_pageController setOnRefreashSuccessBlock:^(NSArray *mergedList,NSDictionary *result) {
        [bSelf -> _delegate listViewController:bSelf toListViewReload : bSelf->_listView];
        [bSelf setHasMore:bPageController.hasMore];
        [bSelf finishRefreash];
    }];
    
    [_pageController setOnRefreashFailedBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        [bSelf finishRefreash];
    }];
    [_pageController setOnNextSuccessBlock:^(NSArray *mergedList,NSDictionary *result) {
        [bSelf -> _delegate listViewController:bSelf toListViewReload : bSelf->_listView];
        [bSelf setHasMore:bPageController.hasMore];
        [bSelf finishLoading];
    }];
    [_pageController setOnNextFailedBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        [bSelf finishLoading];
    }];
    [_pageController setOnCacheNextBlock:^(NSArray *mergedList, NSDictionary *result) {
        [bSelf -> _delegate listViewController:bSelf toListViewReload : bSelf->_listView];
        [bSelf setHasMore:bPageController.hasMore];
    }];
    [_delegate listViewController:self afterInitPageController:_pageController];
}

#pragma mark -
#pragma mark LSRefreashAndLoadMoreViewController
- (void)lsViewControllerShouldRefreash:(LSRefreshAndLoadMoreListViewController *)viewController{
    if([_delegate respondsToSelector:@selector(listViewControllerOnRefreshRequest:)]){
        [_delegate listViewControllerOnRefreshRequest:self];
    }
    [_pageController refreshNoMerge];
}
- (void)lsViewControllerShouldLoadMore:(LSRefreshAndLoadMoreListViewController *)viewController{
    if([_delegate respondsToSelector:@selector(listViewControllerOnNextRequest:)]){
        [_delegate listViewControllerOnNextRequest:self];
    }
    [_pageController nextPage];
}

#pragma mark method
- (void)setApiParams:(NSDictionary *)apiParams{
    _pageController.apiParams =apiParams;
}
- (NSDictionary *)apiParams{
    return _pageController.apiParams;
}
@end
