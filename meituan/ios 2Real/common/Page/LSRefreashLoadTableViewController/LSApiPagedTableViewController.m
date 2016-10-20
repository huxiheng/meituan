//
//  LSPagedTableViewController.m
//  Yingcheng
//
//  Created by lessu on 14-2-19.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "LSApiPagedTableViewController.h"

@interface LSApiPagedTableViewController ()
@property(nonatomic,strong) NSString * reuseIdentifier;
@end

@implementation LSApiPagedTableViewController

- (id)initWithApiName:(NSString *)apiName andCellClass:(Class)cellClass{
    self = [super init];
    if (self) {
        _apiName    = apiName;
        _cellClass = cellClass;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpPageController];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _reuseIdentifier = @"Cell";
    if (_cellClass) {
        NSString* classString = NSStringFromClass(_cellClass);
        [_tableView registerNib:[UINib nibWithNibName:classString bundle:0] forCellReuseIdentifier:_reuseIdentifier];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_pageController refresh];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_pageController cancelLoading];
    [_pageController cancelRefreashing];
}

- (void)setUpPageController{
    NSDictionary *params = @{};
    NSString     *apiName= self.apiName;
    if (!apiName) {
        return ;
    }
    _pageController = [[LSPageController alloc]initWithApiName:apiName andParams:params];
    __block LSPageController *bPageController = _pageController;
    __block typeof(self) bSelf = self;
    [_pageController setOnRefreashSuccessBlock:^(NSArray *mergedList,NSDictionary *result) {
        [bSelf.tableView reloadData];
        [bSelf setHasMore:bPageController.hasMore];
        [bSelf finishRefreash];
    }];
    [_pageController setOnRefreashFailedBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        [bSelf finishRefreash];
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
    [self afterInitPageController:_pageController];
}

- (void)afterInitPageController:(LSPageController *)pageController{
    
}
#pragma mark tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _pageController.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    LSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDictionary *item = _pageController.list[indexPath.row];
    cell.data = item;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    NSDictionary *item = _pageController.list[indexPath.row];
    LSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    return [cell heightForData:item];
}
@end
