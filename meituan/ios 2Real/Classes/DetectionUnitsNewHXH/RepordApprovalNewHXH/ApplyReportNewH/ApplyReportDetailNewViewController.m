//
//  ApplyReportDetailNewViewController.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/4.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "ApplyReportDetailNewViewController.h"
#import "ApplyReportDetailNewVCCell.h"
#import "ApplyReportNewDetytailHeaderView.h"
#import "VASampleListViewController.h"

@implementation ApplyReportDetailNewViewController
- (void)setData{
    self.titleForNav = @"报告详情";
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self dataRequest];
    [self setsubviews];
    
}

- (void)setsubviews{
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64) style:UITableViewStylePlain];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    ApplyReportNewDetytailHeaderView *headerView = [[ApplyReportNewDetytailHeaderView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 62)];
    headerView.blockClickBG = ^(){
        VASampleListViewController *controller = [[VASampleListViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
        controller.list = ARRAY_EMPTY_IF_NOT( _dataDic[@"SampleInfo"] );
    };
    self.table.tableHeaderView = headerView;
    
    [self.table registerClass:[ApplyReportDetailNewVCCell class] forCellReuseIdentifier:[ApplyReportDetailNewVCCell cellIdentifier]];
}

- (void)dataRequest{
    NSDictionary *params = @{
                             @"ConsignId":_consignId,
                             @"Token":[LoginUtil token]
                             };
    APIConnection *connection = [[RPAPI sharedInstance]connectionWithApiName:APIMETHOD_RP_APPLY_DETAIL_REPORT params:params];
    [connection setOnSuccess:^(id result) {

        @try {
            _dataDic = result[kAPIConnectionStandartDataKey][0];
            [self makeNewData:_dataDic];
            [self.table reloadData];
            [SVProgressHUD dismiss];
        }
        @catch (NSException *exception) {
            [SVProgressHUD dismissWithError:@"数据错误！"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [SVProgressHUD show];
    [connection startAsynchronous];
}

- (void)makeNewData:(NSDictionary*)dic{
    NSArray *arrayTitle = @[@"报告编号",@"检测类型",@"委托日期",@"见证人信息",@"取样人信息",@"委托单位",@"工程名称",@"工程地址",@"施工单位",@"报告日期",@"防伪校验码"];
    NSMutableArray *arrayContent = [NSMutableArray arrayWithObjects:dic[@"Report_ID"],dic[@"Exam_Kind"],dic[@"Deliver_Date"],dic[@"Witness"],dic[@"Sampling"],dic[@"EntrustUnitName"],dic[@"ProjectName"],dic[@"ProjectAddress"],dic[@"BuildUnit"],dic[@"ReportDate"],dic[@"IdentifyingCode"], nil];
    self.arrayCellData = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<arrayTitle.count; i++) {
        XSCellModel *cellModel = [[XSCellModel alloc] init];
        cellModel.title = arrayTitle[i];
        cellModel.content = arrayContent[i];
        if (i%2==0) {
            cellModel.tagColor = YES;
        }else{
            cellModel.tagColor = NO;
        }
        [self.arrayCellData addObject:cellModel];
    }
}

#pragma  mark ----UITableViewDelegate----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayCellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ApplyReportDetailNewVCCell *cell = [tableView dequeueReusableCellWithIdentifier:[ApplyReportDetailNewVCCell cellIdentifier]];
    id model = [self.arrayCellData objectAtIndex:indexPath.row];
    [cell reloadDataForCell:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     id model = [self.arrayCellData objectAtIndex:indexPath.row];
    CGFloat heightContent = [NSString calculateTextHeight:DeviceWidth-30 Content:((XSCellModel *)model).content font:themeFont15];
    heightContent = heightContent+5>25?heightContent:15;
    
    return  heightContent+34;
}

@end
