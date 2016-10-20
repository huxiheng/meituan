//
//  WorkSiteSampleNewVCController.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/2.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "WorkSiteSampleNewVCController.h"
#import "WorkSiteSampleNewVCCell.h"

@implementation WorkSiteSampleNewVCController

- (void)setData {
    self.titleForNav = @"样品信息";
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self getViewDataArray];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64) style:UITableViewStylePlain];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    [self.table registerClass:[WorkSiteSampleNewVCCell class] forCellReuseIdentifier:[WorkSiteSampleNewVCCell cellIdentifier]];
    
    
    
}

- (void)getViewDataArray{
    NSArray *arrayTitle = @[@"条码号",@"检测合同登记号",@"施工单位",@"工地名称",@"标识编号",@"大类",@"项目",@"规格",@"样品名称",@"备案证",@"强度／等级",@"使用部位",@"生产厂家",@"成型日期",@"龄期",@"检测参数",@"备注",@"委托编号",@"样品编号",@"检测日期",@"样品状态",@"产品标准",@"样品等级时间",@"报告日期",@"报告编号",@"检测结果",@"检测单位",@"工地地址",@"工地所属区县",@"委托单位",@"监理单位",@"报建编号",@"检测单位会员编号"];
    NSMutableArray *arrayContent = [[NSMutableArray alloc] initWithObjects:self.qrcode,self.dicData[@"Contract_SignNo"],self.dicData[@"BuildUnitName"],self.dicData[@"ProjectName"],self.dicData[@"Sample_BsId"],self.dicData[@"KindName"],self.dicData[@"ItemName"],self.dicData[@"SpecName"],self.dicData[@"SampleName"],self.dicData[@"Record_Certificate"],self.dicData[@"GradeName"],self.dicData[@"ProJect_Part"],self.dicData[@"Produce_Factory"],self.dicData[@"Molding_Date"],self.dicData[@"AgeTime"],self.dicData[@"Exam_Parameter_Cn"],self.dicData[@"Memo"],self.dicData[@"ConSign_ID"],self.dicData[@"Sample_ID"],self.dicData[@"DetectonDate"],self.dicData[@"Sample_Status"],self.dicData[@"SampleJudge"],self.dicData[@"CreateDateTime"],self.dicData[@"ReportDate"],self.dicData[@"ReportNumber"],self.dicData[@"Exam_Result"],self.dicData[@"DetectionUnitName"],self.dicData[@"ProjectAddress"],self.dicData[@"AreaKey"],self.dicData[@"ConstructUnitName"],self.dicData[@"SuperviseUnitName"],self.dicData[@"BuildingReportNumber"],self.dicData[@"MemberCode"], nil];
    self.arrayDataNew = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<arrayTitle.count; i++) {
        XSCellModel *cellmodel = [[XSCellModel alloc] init];
        cellmodel.title = arrayTitle[i];
        cellmodel.content = arrayContent[i];
        if (i%2==0) {
            cellmodel.tagColor = YES;
        }else {
            cellmodel.tagColor = NO;
        }
        [self.arrayDataNew addObject:cellmodel];
        
    }
}

#pragma mark ----UITableViewDelegate----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayDataNew.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkSiteSampleNewVCCell *cell = [tableView dequeueReusableCellWithIdentifier:[WorkSiteSampleNewVCCell cellIdentifier]];
    id model = [self.arrayDataNew objectAtIndex:indexPath.row];
    [cell reloadDataForCell:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self.arrayDataNew objectAtIndex:indexPath.row];
    NSString *strShow = [NSString stringWithFormat:@"%@：%@",((XSCellModel*)model).title,((XSCellModel*)model).content];
    CGFloat heightShow = [NSString calculateTextHeight:DeviceWidth-30 Content:strShow font:themeFont13];
    CGFloat  heightShowReal= (heightShow+5>22)?heightShow+5 :kscaleDeviceHeight(13);
//    self.viewBottomLine.frame = CGRectMake(0, 26+heightShowReal+1-0.5, DeviceWidth, 0.5);
    return kscaleDeviceHeight(20)+heightShowReal;
}

@end
