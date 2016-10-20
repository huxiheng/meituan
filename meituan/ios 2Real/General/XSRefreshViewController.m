//
//  XSRefreshViewController.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/20.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSRefreshViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"


@interface XSRefreshViewController (){
    BOOL _firstDisplay;
   
        UIScrollView *_dataScrollView;
    
}

@end

@implementation XSRefreshViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpPageController];

    _isFirstLoad = true;
    _firstDisplay = true;
    _loadOnlyOnce = false;
    
    
    //／导航栏
    [self setData];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.navigationController.fd_interactivePopDisabled = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate=(id<UIGestureRecognizerDelegate>)self;
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    [self setTitleforNavgationVicontroller];
    
    if (self.navigationController.viewControllers.count>1) {
        self.navigationItem.leftBarButtonItem =  [self setbackNavGationBarIterm];
    }else {
        
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_loadOnlyOnce || (_loadOnlyOnce && _isFirstLoad)) {
        BOOL result = [self onRefreshRequest];
        if (result) {
            [_pageController refresh];
        }
    }
    _isFirstLoad = false;
    if (_firstDisplay) {
        //        [UIView beginAnimations:nil context:NULL];
        //        [UIView setAnimationDuration:0.2];
        //        _tableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        //        [_refreshHeaderView setState:EGOOPullRefreshLoading];
        //        _tableView.contentOffset = CGPointMake(0, -60);
        //        [UIView commitAnimations];
    }
    _firstDisplay = false;
    
    
    if (self.navigationController&&[self.navigationController.viewControllers count]==1) {
                self.navigationController.interactivePopGestureRecognizer.enabled =YES;
        //        [self replaceSystemGesture];
    }
    else {
        self.navigationController.interactivePopGestureRecognizer.enabled =YES;
    }
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_pageController cancelLoading];
    [_pageController cancelRefreashing];
}

- (void)setUpPageController{
    if(_enableDebugMode){
        return ;
    }
    
    NSDictionary * params = nil;
    NSString     * apiName= nil;
    [self toInitPageControllerWith:&apiName params:&params];
    _pageController = [[LSPageController alloc]initWithApiName:apiName andParams:params];
    __block LSPageController *bPageController = _pageController;
    __block typeof(self) bSelf = self;
    [_pageController setOnRefreashSuccessBlock:^(NSArray *mergedList,NSDictionary *result) {
//        [bSelf.tableView reloadData];
//        [bSelf setHasMore:bPageController.hasMore];
        [bSelf endRefresh];
    }];
    [_pageController setOnRefreashFailedBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
//        [bSelf finishRefreash];
        [bSelf endRefresh];
        bPageController.list = [NSMutableArray array];
//        [bSelf.tableView reloadData];
    }];
    [_pageController setOnNextSuccessBlock:^(NSArray *mergedList,NSDictionary *result) {
//        [bSelf.tableView reloadData];
//        [bSelf setHasMore:bPageController.hasMore];
//        [bSelf finishLoading];
        [bSelf endRefresh];
    }];
    [_pageController setOnNextFailedBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
//        [bSelf finishLoading];
        [bSelf endRefresh];
    }];
    [_pageController setOnCacheNextBlock:^(NSArray *mergedList, NSDictionary *result) {
//        [bSelf.tableView reloadData];
//        [bSelf setHasMore:bPageController.hasMore];
    }];
    [self afterInitPageController:_pageController];
}

#pragma mark to Implement
- (void)toInitPageControllerWith:(NSString **) apiName params:(NSDictionary **)params{
    *apiName = nil;
    *params  = nil;
    NSAssert(false, @"please override it");
}
- (void)afterInitPageController:(LSPageController *)pageController{
    
}

- (BOOL)        onRefreshRequest{
    return true;
}

- (BOOL)        onNextRequest{
    return true;
}

- (void)addRefreshHeader:(UIScrollView *)scroll {
    _dataScrollView =scroll;
    scroll.header =[MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}
- (void)addRefreshFooter:(UIScrollView *)scroll {
    _dataScrollView =scroll;
    //    self.isNeedLoadMore =YES;
    scroll.footer =[MJDIYAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
- (void)addRefreshHeaderAndFooter:(UIScrollView *)scroll {
    [self addRefreshFooter:scroll];
    [self addRefreshHeader:scroll];
}
- (void)endRefresh {
    if (_dataScrollView.header) {
        [_dataScrollView.header endRefreshing];
    }
    if (_dataScrollView.footer) {
        [_dataScrollView.footer endRefreshing];
    }
}
- (void)setRefreshFooterStatus:(MJRefreshState)status {
    _dataScrollView.footer.state =status;
}
- (void)removeRefreshFooter {
    [_dataScrollView.footer removeFromSuperview];
}
- (void)needAddRefreshFooter {
    _dataScrollView.footer =[MJDIYAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadNewData{
    BOOL result = [self onRefreshRequest];
    if (result) {
        [_pageController refreshNoMerge];
        
    }else{
//        [self finishRefreash];
    }
}

- (void)loadMoreData{
    BOOL result = [self onNextRequest];
    if (result) {
        [_pageController nextPage:_dataScrollView];
    }else{
//        [self finishLoading];
    }
}



#pragma  mark 导航栏
- (void)setTitleforNavgationVicontroller {
    self.labelNavTitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 160, 44)];
    self.labelNavTitle.text = self.titleForNav;
    self.labelNavTitle.textColor = [UIColor whiteColor];
    self.labelNavTitle.textAlignment = NSTextAlignmentCenter;
    self.labelNavTitle.font = [UIFont systemFontOfSize:15];
    self.navigationItem.titleView = self.labelNavTitle;
    
}

- (UIBarButtonItem *)setbackNavGationBarIterm{
    UIBarButtonItem *leftBarIterm = [[UIBarButtonItem alloc] init];
    UIButton * leftBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftBarButton setImage:[UIImage imageNamed:@"houtui"] forState:UIControlStateNormal];
    [leftBarButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [leftBarButton addTarget:self action:@selector(popNav:) forControlEvents:UIControlEventTouchUpInside];
    [leftBarIterm setCustomView:leftBarButton];
    return leftBarIterm;
}

- (void)popNav:(UIButton *)btn{
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
    }
}

- (void)setData {
    
}

- (void)setNavLeftItemWith:(NSString *)str andImage:(UIImage *)image {
    if ([self.navigationController.viewControllers count] ==1){
        if ([str isEqualToString:@""])
        {
            UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
            self.navigationItem.leftBarButtonItem = leftItem;
        }
        else
        {
            UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
            self.navigationItem.leftBarButtonItem = leftItem;
        }
    }
}

- (void)setNavRightItemWith:(NSString *)str andImage:(UIImage *)image
{
    if ([str isEqualToString:@""])
    {
        UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    else
    {
        UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
        
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

- (void)setNavRightItems:(NSArray *)arrays {
    NSMutableArray *rightBarButtonItems =[[NSMutableArray alloc] init];
    
    for (NSInteger i=0; i<arrays.count; i++) {
        if (i==0) {
            UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithImage:arrays[i] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
            [rightBarButtonItems addObject:rightItem];
        }
        if (i==1) {
            UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithImage:arrays[i] style:UIBarButtonItemStylePlain target:self action:@selector(rightItem2Click:)];
            [rightBarButtonItems addObject:rightItem];
        }
    }
    self.navigationItem.rightBarButtonItems =rightBarButtonItems;
}

- (void)rightItemClick:(id)sender{
    
}
- (void)rightItem2Click:(id)sender{
    
}
- (void)leftItemClick:(id)sender{
    
}
@end
