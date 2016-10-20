//
//  VerifyDetailNewHViewController.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/5.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "VerifyDetailNewHViewController.h"
#import "VerifyDetailNewHVCCell.h"

@implementation VerifyDetailNewHViewController
- (void)setData{
    self.titleForNav = @"样品信息";
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setSubViews];
    [self dataRequest];
    
   
}

- (void)setSubViews{
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64) style:UITableViewStylePlain];
    self.table.separatorStyle = UITableViewStylePlain;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    [self.table registerClass:[VerifyDetailNewHVCCell class] forCellReuseIdentifier:[VerifyDetailNewHVCCell cellIdentifier]];
    
}


- (void)dataRequest{
    NSDictionary *params = @{
                             @"ConsignId":_consignId,
                             @"Token":[LoginUtil token]
                             };
    APIConnection *connection = [[RPAPI sharedInstance]connectionWithApiName:APIMETHOD_RP_VERIFY_DETAIL_SAMPLE params:params];
    [connection setOnSuccess:^(id result) {
        
        @try {
            _dataDic = result[kAPIConnectionStandartDataKey][0];
            [self makeNewData:_dataDic];
            
            
            [SVProgressHUD dismiss];
            [self.table reloadData];
            
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

- (void)makeNewData:(NSDictionary *)dicData{
    NSArray *titleArray = @[@"规格名称",@"强度等级名称",@"收样日期",@"检测设备",@"检测日期",@"样品检测结论",@"评定依据",@"检测方法",@"报告编号"];
    NSMutableArray *arrayContent = [NSMutableArray arrayWithObjects:dicData[@"SpecName"],dicData[@"GradeName"],dicData[@"StartDate"],dicData[@"Equipment"],dicData[@"DetectionDate"],dicData[@"Exam_Result"],dicData[@"AccessRuleCode"],dicData[@"DetectonRule"],dicData[@"ReportID"], nil];
    self.arrayData = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i =0; i<titleArray.count; i++) {
        XSCellModel *cellModel = [[XSCellModel alloc] init];
        cellModel.title = titleArray[i];
        cellModel.content = arrayContent[i];
        if (i%2==0) {
            cellModel.tagColor = YES;
            
        }else{
            cellModel.tagColor = NO;
        }
        [self.arrayData addObject:cellModel];
    }
}

#pragma mark ----UITableViewDelegate----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VerifyDetailNewHVCCell *cell = [tableView dequeueReusableCellWithIdentifier:[VerifyDetailNewHVCCell cellIdentifier]];
    id model = [self.arrayData objectAtIndex:indexPath.row];
    [cell reloadDataForCell:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = [self.arrayData objectAtIndex:indexPath.row];
    NSString * text = [NSString stringWithFormat:@"%@：%@",((XSCellModel *)model).title,((XSCellModel *)model).content];
    CGFloat heightContent = [NSString calculateTextHeight:DeviceWidth-36-15 Content:text font:themeFont17];
    heightContent = heightContent+5>28?heightContent:kscaleDeviceHeight(17);
   
    return kscaleDeviceHeight(23)+heightContent;
}

@end
