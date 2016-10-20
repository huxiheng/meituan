//
//  VASamplePropertyNewListVCviewController.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/4.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "VASamplePropertyNewListVCviewController.h"
#import "VASamplePropertyNewListVCCell.h"

@implementation VASamplePropertyNewListVCviewController
- (void)setData{
    self.titleForNav = @"参数列表";
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setSubviews];
}

- (void)setSubviews{
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64) style:UITableViewStylePlain];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    
    [self.table registerClass:[VASamplePropertyNewListVCCell class] forCellReuseIdentifier:[VASamplePropertyNewListVCCell cellIdentifier]];
    
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 45)];
    viewHeader.backgroundColor = [UIColor whiteColor];
    
    UILabel *labelHeader = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, DeviceWidth-30, 45)];
    labelHeader.font = themeFont17;
    labelHeader.textColor = [UIColor colorWithHexString:kc00_999999];
    NSString *strHeader = [NSString stringWithFormat:@"当前样品编号：%@",self.stringBianHao];
    NSRange  range1 = [strHeader rangeOfString:self.stringBianHao];
    [labelHeader setAttributeText:strHeader nsrange:range1 andColorRGB:kc00_333333];
    
    UIView *viewLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, DeviceWidth, 0.5)];
    viewLineBottom.backgroundColor = kcolorLine;
    [viewHeader addSubview:viewLineBottom];
    
    [viewHeader addSubview:labelHeader];
    
    self.table.tableHeaderView = viewHeader;
    
}

#pragma mark ----UITableViewDelegate----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VASamplePropertyNewListVCCell  *cell = [tableView dequeueReusableCellWithIdentifier:[VASamplePropertyNewListVCCell cellIdentifier]];
    id model = [self.data objectAtIndex:indexPath.row];
    [cell reloadDataForCell:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kscaleDeviceHeight(200);
}

@end
