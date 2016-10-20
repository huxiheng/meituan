//
//  SampleListViewController.m
//  Xieshi
//
//  Created by 明溢 李 on 14-11-18.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "VASampleListViewController.h"
#import "VASampleListTableViewCell.h"
//#import "VASampleDetailViewController.h"
#import "VASampleDetilNewVCViewController.h"
#import "NSObject+SBJSON.h"
//#import "VASamplePropertyListViewController.h"
#import "VASamplePropertyNewListVCviewController.h"
@interface VASampleListViewController ()<VASampleListTableViewCellDelegate>

@end

@implementation VASampleListViewController
- (void)setData{
    self.titleForNav = @"样品列表";
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title=@"样品列表";
    [_tableView registerNib:[UINib nibWithNibName:@"VASampleListTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   NSString * text = [NSString stringWithFormat:@"工程名称：%@",_list[indexPath.row][@"SampleName"]];
    CGFloat heightName = [NSString calculateTextHeight:kscaleIphone5DeviceLength(269) Content:text font:themeFont17];
    heightName = heightName+5>30?heightName:kscaleDeviceHeight(17);

    return kscaleDeviceHeight(40)+kscaleDeviceHeight(40)+kscaleDeviceHeight(23)+heightName+kscaleDeviceHeight(40);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    VASampleListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.data = _list[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)sampleListTableViewCell:(VASampleListTableViewCell *)cell detailButtonDidPress:(UIButton *)button{
    NSDictionary *data = cell.data;
    VASampleDetilNewVCViewController *controller = [[VASampleDetilNewVCViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    controller.dicData = data;
}
- (void)sampleListTableViewCell:(VASampleListTableViewCell *)cell propertyButtonDidPress:(UIButton *)button{
    NSDictionary *data = cell.data;    
    VASamplePropertyNewListVCviewController *controller = [[VASamplePropertyNewListVCviewController alloc]init];
    controller.stringBianHao=data[@"Sample_Id"];
    controller.data = data[@"ParamInfo"];
    if (data[@"ParamInfo"]==@"""") {
        controller.data = nil;
    }
    [self.navigationController pushViewController:controller animated:YES];
}
@end
