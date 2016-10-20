//
//  TodaySearchViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-3-18.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "TodaySearchViewController.h"
#import "LSForm.h"

#import "LSFormSelectUnqualitifyNewCell.h"
#import "LSFormTextFieldUnqualifyCell.h"
@interface TodaySearchViewController ()

@end

@implementation TodaySearchViewController

- (void)setDatawithNavTitle{
    self.titleForNav = @"今日统计搜索";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *viewheader =[[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 0.001)];
    viewheader.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView =viewheader;
    
   
    NSDictionary *areaMap = @{
                              @"金山区":@"金山区",
                              @"崇明县":@"崇明县",
                              @"浦东新区":@"浦东新区",
                              @"南汇区":@"南汇区",
                              @"闵行区":@"闵行区",
                              @"卢湾区":@"卢湾区",
                              @"徐汇区":@"徐汇区",
                              @"奉贤区":@"奉贤区",
                              @"宝山区":@"宝山区",
                              @"杨浦区":@"杨浦区",
                              @"普陀区":@"普陀区",
                              @"黄浦区":@"黄浦区",
                              @"青浦区":@"青浦区",
                              @"松江区":@"松江区",
                              @"":@"所有区县",
                              @"闸北区":@"闸北区",
                              @"长宁区":@"长宁区",
                              @"嘉定区":@"嘉定区",
                              @"静安区":@"静安区",
                              @"虹口区":@"虹口区"
                              };
    
    self.formMapper = @[
                        formTableViewFormMapper(@[
                                                  [LSFormTextFieldUnqualifyCell mapperWithCellName:@"nameCell" keyName:@"ProjectName" label:@"工地名称"],
                                                  [LSFormSelectUnqualitifyNewCell mapperWithCellName:@"areaCell" keyName:@"ProjectArea" label:@"工地所属区县" andMapper:areaMap],
                                                  [LSFormTextFieldUnqualifyCell mapperWithCellName:@"BuildingReportNumberCell" keyName:@"BuildingReportNumber" label:@"报建编号"],
                                                  [LSFormTextFieldUnqualifyCell mapperWithCellName:@"ConstructUnitNameCell" keyName:@"ConstructUnitName" label:@"建设单位"],
                                                  [LSFormTextFieldUnqualifyCell mapperWithCellName:@"BuildUnitNameCell" keyName:@"BuildUnitName" label:@"施工单位"],
                                                  [LSFormTextFieldUnqualifyCell mapperWithCellName:@"SuperviseUnitNameCell" keyName:@"SuperviseUnitName" label:@"监理单位"],
                                                  [LSFormTextFieldUnqualifyCell mapperWithCellName:@"DetectionUnitNameCell" keyName:@"DetectionUnitName" label:@"检测单位"],
//                                                  [LSFormTextViewSearchNewCell mapperWithCellName:@"ProjectNameCell" keyName:@"ProjectName" label:@"项目名称" andHeight:@"50"],
//                                                  [LSFormSelectSearchCell mapperWithCellName:@"areaCell" keyName:@"ProjectArea" label:@"项目所属区县" andMapper:areaMap],
//                                                  
                                                  ])
                        ];

    self.title = @"筛选";
//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDidPress:)];
//    self.navigationItem.rightBarButtonItem = barButton;
    
    [self.formMapper enumerateObjectsUsingBlock:^(NSDictionary* formSection, NSUInteger idx, BOOL *stop) {
        if (IS_ARRAY(formSection[LSFormTableMapperFormCellKey]))
        {
            NSArray *formSectionCells = formSection[LSFormTableMapperFormCellKey];
            [formSectionCells enumerateObjectsUsingBlock:^(NSDictionary* cellMapper, NSUInteger idx, BOOL *stop) {
                NSString *cellName  = (cellMapper[LSFormTableMapperCellNameKey]);
                if ([cellName isEqualToString:@"ProjectNameCell"]) {
//                    [cellMapper setValue:@"50" forKey:LSFormTableMapperCellHeightNewKey];
//                    [cellMapper setValue:@"" forKey:LSFormTableMapperCellLabelKey];
                    [self.tableView reloadData];
                }
                
                
            }
             ];
        }
     }];
 
}

- (void)rightBarButtonDidPress:(UIBarButtonItem *)sender{
    NSDictionary *data = [self formData];
    if (_onComplete) {
//        _onComplete(data[@"ProjectName"],data[@"ProjectArea"]);
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 100)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = CGRectMake((DeviceWidth-kscaleDeviceWidth(194) )/2, 30, kscaleDeviceWidth(194), 40);
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setBackgroundColor:[UIColor colorWithRed:71.0/255.0 green:189.0/255.0 blue:234.0/255.0 alpha:1.0]];
    [button addTarget:self action:@selector(btnclickSureButton) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}

- (void)btnclickSureButton{
    NSDictionary *data = [self formData];
    if (_onComplete) {
        _onComplete(data[@"ProjectName"],data[@"ProjectArea"],data[@"BuildingReportNumber"],data[@"BuildUnitName"],data[@"ConstructUnitName"],data[@"SuperviseUnitName"],data[@"DetectionUnitName"]);
    }
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.formMapper enumerateObjectsUsingBlock:^(NSDictionary* formSection, NSUInteger idx, BOOL *stop) {
//        if (IS_ARRAY(formSection[LSFormTableMapperFormCellKey]))
//        {
////            LSFormCell *cell = self.cellsDict[ item[LSFormTableMapperCellNameKey] ]
//            NSArray *formSectionCells = formSection[LSFormTableMapperFormCellKey];
//            [formSectionCells enumerateObjectsUsingBlock:^(NSDictionary* cellMapper, NSUInteger idx, BOOL *stop) {
//                LSFormCell *cell = self.cellsDict[ cellMapper[LSFormTableMapperCellNameKey] ];
//               
//                [cell resignFirstResponder];
//                
//            }
//             ];
//        }
//    }];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
