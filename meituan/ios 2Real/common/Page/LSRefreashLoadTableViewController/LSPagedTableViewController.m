//
//  LSVerySimplePagedTableViewController.m
//  YinfengShop
//
//  Created by lessu on 13-12-19.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

//v 1.1
//新增加载提示
//v 1.1.1
//refresh 失败后清空list
#import "LSPagedTableViewController.h"

@interface LSPagedTableViewController ()
{
    NSString *_reuseIdentifier;
    BOOL _firstDisplay;
}
@property(nonatomic,retain)         UIView *emptyHintView;
 
@end

@implementation LSPagedTableViewController

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
        _loadOnlyOnce = true;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpPageController];
    
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    NSString *nibName = [self simpleTableViewCellNibName:_tableView];
    _reuseIdentifier = @"Cell";
    if (nibName) {
        [_tableView registerNib:[UINib nibWithNibName:nibName bundle:0] forCellReuseIdentifier:_reuseIdentifier];
    }
    _isFirstLoad = true;
    _firstDisplay = true;
    _loadOnlyOnce = false;
	// Do any additional setup after loading the view.
    
    ///导航条的设置
    [self setdataForNav];
    
    [self setTitleforNavgationVicontroller];
}

- (void)setdataForNav{
    
}

- (void)setTitleforNavgationVicontroller {
    self.labelNavTitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 160, 44)];
    self.labelNavTitle.text = self.titleForNav;
    self.labelNavTitle.textColor = [UIColor whiteColor];
    self.labelNavTitle.textAlignment = NSTextAlignmentCenter;
    self.labelNavTitle.font = [UIFont systemFontOfSize:15];
    self.navigationItem.titleView = self.labelNavTitle;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:41/255.0 green:124/255.0 blue:199/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [bSelf.tableView reloadData];
        [bSelf setHasMore:bPageController.hasMore];
        [bSelf finishRefreash];
        
    }];
    [_pageController setOnRefreashFailedBlock:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        [bSelf finishRefreash];
        bPageController.list = [NSMutableArray array];
        [bSelf.tableView reloadData];
    }];
    [_pageController setOnNextSuccessBlock:^(NSArray *mergedList,NSDictionary *result) {
        [bSelf.tableView reloadData];
        [bSelf setHasMore:bPageController.hasMore];
        [bSelf finishLoading];
    }];
    [_pageController setOnNextFailedBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        [bSelf finishLoading];
    }];
    [_pageController setOnCacheNextBlock:^(NSArray *mergedList, NSDictionary *result) {
        [bSelf.tableView reloadData];
        [bSelf setHasMore:bPageController.hasMore];
    }];
    [self afterInitPageController:_pageController];
}
#pragma mark -
#pragma mark LSRefreashAndLoadMoreViewController
- (void)lsViewControllerShouldRefreash:(LSRefreashAndLoadMoreViewController *)viewController{
    BOOL result = [self onRefreshRequest];
    if (result) {
        [_pageController refreshNoMerge];
    }else{
        [self finishRefreash];
    }
}
- (void)lsViewControllerShouldLoadMore:(LSRefreashAndLoadMoreViewController *)viewController{
    BOOL result = [self onNextRequest];
    if (result) {
        [_pageController nextPage];
    }else{
        [self finishLoading];
    }
}

#pragma mark method
- (NSDictionary *)itemForIndexPath:(NSIndexPath *)indexPath{
    if (_enableDebugMode) {
        return _debugItemData;
    }
//    return  _pageController.list == 0 ? @{} :_pageController.list[indexPath.row];
    NSLog(@"%d",indexPath.row);
    if (_pageController.list.count != 0) {
        return  _pageController.list[indexPath.row];
    }else {
        return @{};
    }
    
}


#pragma mark to Implement
- (void)toInitPageControllerWith:(NSString **) apiName params:(NSDictionary **)params{
    *apiName = nil;
    *params  = nil;
    NSAssert(false, @"please override it");
}
- (void)afterInitPageController:(LSPageController *)pageController{

}
- (void)        simpleTableView:(UITableView *)tableView fillCell:(id)cell withData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath{
    
    //    NSAssert(false, @"please override it");
}
- (NSString *)simpleTableViewCellNibName:(UITableView *)tableView{
    return NULL;
}
- (CGFloat)     simpleTableView:(UITableView *)tableView cellHeightForData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (void)        simpleTableView:(UITableView *)tableView didSelectedWithData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath{
    
}
- (BOOL)        onRefreshRequest{
    return true;
}
- (BOOL)        onNextRequest{
    return true;    
}
#pragma mark tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//
//    if (_pageController.list.count == 0) {
//        if (_emptyHintView == NULL) {
//            _emptyHintView = [[UIView alloc] initWithFrame:_tableView.frame];
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
//            label.height = _emptyHintView.height/3;
//            label.width  = _emptyHintView.width;
//            label.text = @"暂时没有数据";
//            label.textAlignment = NSTextAlignmentCenter;
//            [_emptyHintView addSubview:label];
//        }
//        [_tableView.superview addSubview:_emptyHintView];
//    }else{
//        [_emptyHintView removeFromSuperview];
//    }
    if (_enableDebugMode) {
        return  _debugItemCount;
    }
    return _pageController.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDictionary *item = [self itemForIndexPath:indexPath];
    [self simpleTableView:tableView fillCell:cell withData:item andIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = [self itemForIndexPath:indexPath];
    return [self simpleTableView:tableView cellHeightForData:item andIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = [self itemForIndexPath:indexPath];
    [self simpleTableView:tableView didSelectedWithData:item andIndexPath:indexPath];
}

- (void)        refreshNoMerge{
    self.pageController.list = [NSMutableArray array];
    [self.pageController refreshNoMerge];
}
- (void)        refresh{
    [self.pageController refresh:YES];
}
@end
