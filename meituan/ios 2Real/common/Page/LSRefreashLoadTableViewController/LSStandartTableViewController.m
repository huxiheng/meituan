//
//  LSStandartTableViewController.m
//  Yingcheng
//
//  Created by lessu on 14-2-19.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "LSStandartTableViewController.h"

@interface LSStandartTableViewController ()

@end

@implementation LSStandartTableViewController


- (id)initWithCellClass:(Class)cellClass
{
    self = [super init];
    if (self) {
        _cellClass = cellClass;
        _reuseIdentifier = @"Cell";

    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    if (_cellClass) {
        NSString* classString = NSStringFromClass(_cellClass);
        [_tableView registerNib:[UINib nibWithNibName:classString bundle:0] forCellReuseIdentifier:_reuseIdentifier];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    LSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDictionary *item = _list[indexPath.row];
    cell.data = item;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    NSDictionary *item = _list[indexPath.row];
    LSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    return [cell heightForData:item];
}
@end
