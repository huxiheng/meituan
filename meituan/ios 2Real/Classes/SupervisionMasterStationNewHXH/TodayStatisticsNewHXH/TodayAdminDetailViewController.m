//
//  TodayAdminDetailViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-3-19.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "TodayAdminDetailViewController.h"
#import "TodayAdminDetailTableViewCell.h"
#import "TSAPI.h"
@interface TodayAdminDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain,nonatomic) NSArray * list;
@end

@implementation TodayAdminDetailViewController

- (void)setData{
    self.titleForNav = @"详情列表";
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"统计详情";
    [self dataRequest];
    [_tableView registerNib:[UINib nibWithNibName:@"TodayAdminDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dataRequest{
    NSDictionary *params = @{
                             @"Type"    :@"1",
                             @"ProjectId":_projectId,
                             @"Token" : [LoginUtil token]
                             };
    APIConnection *connection = [[TSAPI sharedInstance]connectionWithApiName:APIMETHOD_TS_TODAY_MANAGE_UNIT_DETAIL params:params];
    [connection setOnSuccess:^(id result) {
        if (ARRAY_CAST(result[@"Data"][@"ListContent"]).count==0) {
            [SVProgressHUD dismissWithError:@"暂无记录"];
            [self.navigationController popViewControllerAnimated:YES];
            return ;
        }
        [self updateUI:result[kAPIConnectionStandartDataKey]];
        [SVProgressHUD dismiss];
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
    }];
    [SVProgressHUD show];
    [connection startAsynchronous];
    
    
}
- (void)updateUI:(NSDictionary *)data{
    _list =  ARRAY_EMPTY_IF_NOT( data[@"ListContent"] );
    [_tableView reloadData];
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
    return [TodayAdminDetailTableViewCell cellHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TodayAdminDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.data = _list[indexPath.row];
    return cell;
}

@end
