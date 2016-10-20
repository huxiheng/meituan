//
//  ServerSelectSecondViewController.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/26.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "ServerSelectSecondViewController.h"
#import "ServerSelectSecondeViewCell.h"
#import "SMAPI.h"

@implementation ServerSelectSecondViewController
- (void)setData {
    self.titleForNav = @"选择服务器";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDataArray:8];
    
    self.view.backgroundColor = [UIColor colorWithHexString:kc00_f8f9fb];
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight) style:UITableViewStylePlain];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    self.table.rowHeight = 60;
    
    self.table.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    
    [self.table registerClass:[ServerSelectSecondeViewCell class] forCellReuseIdentifier:[ServerSelectSecondeViewCell cellIdentifier]];
    
}

- (void)setDataArray:(NSInteger)row{
    self.arrayData = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray *arrayTitle = @[@"电信服务器",@"联通服务器"];
    NSArray *arrayImage = @[[UIImage imageNamed:@"selectServerdianxin"],[UIImage imageNamed:@"selectServerliantong"]];
    for (int i=0; i<arrayTitle.count; i++) {
        XSCellModel *cellmodel = [[XSCellModel alloc] init];
        cellmodel.title = arrayTitle[i];
        cellmodel.images = arrayImage[i];
        cellmodel.tagColor = NO;
        
        if (!self.isFirst) {
            if (i==row) {
                cellmodel.tagColor = YES;
            }else {
                cellmodel.tagColor = NO;
            }
        }else{
            NSString *server = [LoginUtil valueForKey:@"server_select"];
            if (i==0&&[server isEqualToString:@"cnnet"]) {
                cellmodel.tagColor = YES;
            }
            if (i==1&&[server isEqualToString:@"union"]) {
                cellmodel.tagColor = YES;
            }
        }

        [self.arrayData addObject:cellmodel];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ServerSelectSecondeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ServerSelectSecondeViewCell cellIdentifier]];
    id model = [self.arrayData objectAtIndex:indexPath.row];
    [cell reloadDataForCell:model];
   
    
//    cell.blockClickBtn = ^(){
//       
//        
//        
//    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.isFirst = NO;
    [self setDataArray:indexPath.row];
    [self.table reloadData];
    
    if (indexPath.row == 0) {
        [LoginUtil setValue:@"cnnet" forKey:@"server_select"];
        [[USTApi sharedInstance] setServerUrl:CNNET_SERVER_URL];
        [[RPAPI sharedInstance] setServerUrl:CNNET_SERVER_URL];
        [[SMAPI sharedInstance] setServerUrl:CNNET_SERVER_URL];
        [[TSAPI sharedInstance] setServerUrl:CNNET_SERVER_URL];
        [[CommonAPI sharedInstance] setServerUrl:CNNET_SERVER_URL];
    }
    if (indexPath.row == 1) {
        [LoginUtil setValue:@"union" forKey:@"server_select"];
        [[USTApi sharedInstance] setServerUrl:UNION_SERVER_URL];
        [[RPAPI sharedInstance] setServerUrl:UNION_SERVER_URL];
        [[SMAPI sharedInstance] setServerUrl:UNION_SERVER_URL];
        [[TSAPI sharedInstance] setServerUrl:UNION_SERVER_URL];
        [[CommonAPI sharedInstance] setServerUrl:UNION_SERVER_URL];
    }
    
}

@end
