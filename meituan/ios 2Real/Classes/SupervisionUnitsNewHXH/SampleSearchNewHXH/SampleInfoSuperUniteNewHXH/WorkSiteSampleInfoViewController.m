//
//  WorkSiteSampleInfoViewController.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/25.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "WorkSiteSampleInfoViewController.h"
#import "workSiteSampleInfoCell.h"


@implementation WorkSiteSampleInfoViewController
- (void)setData {
    self.titleForNav = @"样品信息";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setdataForShow];
    [self initSubViews];
    
}

- (void)initSubViews{
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64) style:UITableViewStylePlain];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    [self.table registerClass:[workSiteSampleInfoCell class] forCellReuseIdentifier:[workSiteSampleInfoCell cellIdentifier]];
}

- (void)setdataForShow{
    NSArray *arrayTitle = @[@"检测项目",@"项目名称",@"规格",@"强度",@"标志区间",@"操作状态",@"检测状态",@"检测类别",@"参数",@"原样品纪录ID",@"工程部位",@"见证人",@"取样人",@"备案证",@"生产厂家",@"代表数量",@"成型日期",@"龄期",@"入库批号"];
    NSMutableArray *dicContent = [[NSMutableArray alloc] initWithObjects:self.dataDic[@"ItemName"],self.dataDic[@"SampleName"],self.dataDic[@"SpecName"],self.dataDic[@"GradeName"],self.dataDic[@"CoreCodeNo"],self.dataDic[@"DownStatus"],self.dataDic[@"Sample_Status"],self.dataDic[@"Exam_Kind"],self.dataDic[@"Exam_Parameter_Cn"],self.dataDic[@"ReExam_OldSample_Id"],self.dataDic[@"ProJect_Part"],self.dataDic[@"JZCertificate"],self.dataDic[@"QYCertificate"],self.dataDic[@"Record_Certificate"],self.dataDic[@"Produce_Factory"],self.dataDic[@"Delegate_Quan"],self.dataDic[@"Molding_Date"],self.dataDic[@"AgeTime"],self.dataDic[@"BatchNumber"], nil];
    self.arrayData = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<arrayTitle.count; i++) {
        XSCellModel *cellModel = [[XSCellModel alloc] init];
        cellModel.title = arrayTitle[i];
        cellModel.content = dicContent[i];
        [self.arrayData addObject:cellModel];
    }
    
}

#pragma  mark ----UItableViewDelegate----

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    workSiteSampleInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[workSiteSampleInfoCell cellIdentifier]];
    id model = [self.arrayData objectAtIndex:indexPath.row];
    [cell reloadDataForCell:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row%2==0) {
        cell.viewBG.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1.0];
    }else {
        cell.viewBG.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self.arrayData objectAtIndex:indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%@：%@",((XSCellModel*)model).title,((XSCellModel*)model).content];
    CGFloat heightShow = [NSString calculateTextHeight:DeviceWidth-30 Content:str font:themeFont13];
    CGFloat  heightShowReal= (heightShow+5>22)?heightShow+5 :kscaleDeviceHeight(13);

    return kscaleDeviceHeight(20)+heightShowReal+kscaleDeviceHeight(5);
}

@end
