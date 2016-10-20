//
//  AgreementListTableViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "AgreementListViewController.h"
#import "AgreementTableViewCell.h"
#import "SampleSearchListViewController.h"
@interface AgreementListViewController ()

@end

@implementation AgreementListViewController

- (void)setdataForNav {
    self.titleForNav = @"检测合同";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loadOnlyOnce = true;
    self.pageController.pageName = @"CurrentPageNo";
    self.pageController.stepName = @"PageSize";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//to Implement
- (void)toInitPageControllerWith:(NSString **) apiName params:(NSDictionary **)params{
    *apiName = APIMETHOD_SM_ConsignList;
    *params  =  @{
                  @"ProjectId"          : _projectId,
                  
                  @"Token"              : [LoginUtil token],
                  @"NotFinishedOnly"    : @"true",
                  @"QueryStr"           : @""	
                  };
}
- (void)afterInitPageController:(LSPageController *)pageController{
    pageController.apiClass = @"CommonAPI";
    [pageController setPageinfoAdapter:^(NSDictionary *input, BOOL *success, NSArray *__autoreleasing * list, int *totalCount, NSString *__autoreleasing *errorMessage) {
        *success = [input[kAPIConnectionStandartSuccessKey] boolValue];
        if (success) {
            *list = input[kAPIConnectionStandartDataKey][@"ListContent"];
            *totalCount = [input[kAPIConnectionStandartDataKey][@"PageCount"] integerValue];
        }else{
            *errorMessage = input[kAPIConnectionStandartMessageKey];
        } 
    }];
}

- (void)        simpleTableView:(UITableView *)tableView fillCell:(AgreementTableViewCell *)cell withData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath{
    cell.data = item;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (NSString *)  simpleTableViewCellNibName:(UITableView *)tableView{
    return @"AgreementTableViewCell";
}
- (CGFloat)     simpleTableView:(UITableView *)tableView cellHeightForData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath;{
    NSString *stringDection        = [NSString stringWithFormat:@"检测单位：%@",item[@"DetectionUnitName"]];
    CGFloat heightDetection = [NSString calculateTextHeight:kscaleIphone5DeviceLength(274) Content:stringDection font:themeFont15];
    NSString *stringBuilder  = [NSString stringWithFormat:@"施工单位：%@",item[@"BuildUnitName"]];
    CGFloat height = [NSString calculateTextHeight:kscaleIphone5DeviceLength(274) Content:stringBuilder font:themeFont15];
     CGFloat heightRealDectection = heightDetection+5>30?heightDetection:16;
    CGFloat  heightRealBuilder = height+5>30?height: 16;
    
    return kscaleDeviceHeight(160)+kscaleDeviceHeight(heightRealDectection)+kscaleDeviceHeight(5)+kscaleDeviceHeight(19)+kscaleDeviceHeight(19)+kscaleDeviceHeight(heightRealBuilder)+kscaleDeviceHeight(5);
}
- (void)        simpleTableView:(UITableView *)tableView didSelectedWithData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath{
    SampleSearchListViewController *controller = [[SampleSearchListViewController alloc]init];
    controller.signNumber = item[@"ContractSignNumber"];
    [self.navigationController pushViewController:controller animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}
@end
