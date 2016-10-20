//
//  VASampleDetilNewVCViewController.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/4.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "VASampleDetilNewVCViewController.h"
#import "VASampleDeatailNewVCCell.h"

@implementation VASampleDetilNewVCViewController
- (void)setData{
    self.titleForNav = @"样品详情";
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self makeArrayData];
    [self initSubViews];
}

- (void)initSubViews{
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64)];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    [self.table registerClass:[VASampleDeatailNewVCCell class] forCellReuseIdentifier:[VASampleDeatailNewVCCell cellIdentifier]];
    
}

- (void)makeArrayData{
    NSArray *arrayTitle = @[@"样品编号",@"样品名称",@"规格名称",@"强度等级名称",@"代表数量",@"工程部位",@"生产单位",@"备案证",@"检测日期",@"样品检测结论",@"评定依据",@"检测方法"];
    NSMutableArray *arrayContent = [NSMutableArray arrayWithObjects:self.dicData[@"Sample_Id"],self.dicData[@"SampleName"],self.dicData[@"SpecName"],self.dicData[@"GradeName"],self.dicData[@"DelegateQuan"],self.dicData[@"ProjectPart"],self.dicData[@"ProduceFactory"],self.dicData[@"Record_Certificate"],self.dicData[@"DetectionDate"],self.dicData[@"Exam_Result"],self.dicData[@"AccessRuleCode"],self.dicData[@"DetectonRule"], nil];
    self.arrayData = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<arrayTitle.count; i++) {
        XSCellModel *cellModel = [[XSCellModel alloc] init];
        cellModel.title = arrayTitle[i];
        cellModel.content = arrayContent[i];
        if (i%2==0) {
            cellModel.tagColor = YES;
        }else {
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
    VASampleDeatailNewVCCell *cell = [tableView dequeueReusableCellWithIdentifier:[VASampleDeatailNewVCCell cellIdentifier]];
    id model = [self.arrayData objectAtIndex:indexPath.row];
    [cell reloadDataForCell:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = [self.arrayData objectAtIndex:indexPath.row];
    NSString* text = [NSString stringWithFormat:@"%@：%@",((XSCellModel*)model).title,((XSCellModel*)model).content];
    
    CGFloat heightShow = [NSString calculateTextHeight:DeviceWidth-36-15 Content:text font:themeFont17];
    heightShow = heightShow +5 >30?heightShow:kscaleDeviceHeight(17);
//    self.viewBG.frame = CGRectMake(0, 0, DeviceWidth, 28+heightShow);
    return kscaleDeviceHeight(23)+heightShow;
}

@end
