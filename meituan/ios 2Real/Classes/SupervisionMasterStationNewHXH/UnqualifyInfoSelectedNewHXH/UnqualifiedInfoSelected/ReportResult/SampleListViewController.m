//
//  SampleListViewController.m
//  Xieshi
//
//  Created by 明溢 李 on 14-11-18.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "SampleListViewController.h"
#import "SampleListTableViewCell.h"
#import "SampleInfoViewController.h"
#import "NSObject+SBJSON.h"
@interface SampleListViewController ()
@property(nonatomic,retain) NSArray *list;
@end

@implementation SampleListViewController

- (void)setData {
    self.titleForNav = @"报告结论";
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title=@"样品列表";
    [_tableView registerNib:[UINib nibWithNibName:@"SampleListTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    NSDictionary *params = @{
                             @"Report_id":_keyId,
                             @"Checksum":_checksum,
                             @"Token"   : [LoginUtil token]
                             };
    
    
    APIConnection *connection = [[CommonAPI sharedInstance]connectionWithApiName:APIMETHOD_UQ_SampleList params:params];
    [connection setOnSuccess:^(id result) {
        _list = result[kAPIConnectionStandartDataKey];
        [_tableView reloadData];
        [SVProgressHUD dismiss];
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [SVProgressHUD show];
    [connection startAsynchronous];
    
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
    return [SampleListTableViewCell cellHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SampleListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.data = _list[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *datadic = _list[indexPath.row];
    
    SampleInfoViewController *controller = [[SampleInfoViewController alloc]init];
    controller.reportId = _keyId;
    controller.checksum = _checksum;
    controller.sampleId = datadic[@"Sample_Id"];
    [self.navigationController pushViewController:controller animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
