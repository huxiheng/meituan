//
//  ReportListViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "UQReportListViewController.h"
#import "ReportTableViewCell.h"
//#import "ApplyDetailViewController.h"
//#import "UQReportDetailViewController.h"
#import "ReportProjectTableViewCell.h"
#import "ReportCheckViewController.h"

@interface UQReportListViewController ()


@end

@implementation UQReportListViewController

- (void)setdataForNav {
    if (_isProjectType) {
        self.titleForNav = @"工程列表";
    }else {
        self.titleForNav = @"检测报告";
    }
    
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.loadOnlyOnce = true;
    self.pageController.pageName = @"CurrentPageNo";
    self.pageController.stepName = @"PageSize";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//to Implement
- (void)toInitPageControllerWith:(NSString **) apiName params:(NSDictionary **)params{
    *apiName = APIMETHOD_UQ_ReportList;
    *params  =  [_params mutableCopy];
}
- (void)afterInitPageController:(LSPageController *)pageController{
    pageController.apiClass = @"CommonAPI";
    [pageController setPageinfoAdapter:^(NSDictionary *input, BOOL *success, NSArray *__autoreleasing * list, int *totalCount, NSString *__autoreleasing *errorMessage) {
        *success = [input[kAPIConnectionStandartSuccessKey] boolValue];
        if (success) {
            *list = ARRAY_EMPTY_IF_NOT( input[kAPIConnectionStandartDataKey][@"ListContent"] );
            *totalCount = [input[kAPIConnectionStandartDataKey][@"PageCount"] integerValue];
        }else{
            *errorMessage = input[kAPIConnectionStandartMessageKey];
        }
    }];
}

- (void)        simpleTableView:(UITableView *)tableView fillCell:(ReportTableViewCell *)cell withData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath{
    cell.data = item;
}
- (NSString *)  simpleTableViewCellNibName:(UITableView *)tableView{
    if (_isProjectType) {
        return @"ReportProjectTableViewCell";
    }else{
        return @"ReportTableViewCell";
    }
}
- (CGFloat)     simpleTableView:(UITableView *)tableView cellHeightForData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath;{
    if (_isProjectType) {
      
        NSString *stringProjectName =  [NSString stringWithFormat:@"工程名称：%@",item[@"ProjectName"]] ;
        CGFloat heightProjectName = [NSString calculateTextHeight:kscaleIphone5DeviceLength(269) Content:stringProjectName    font:themeFont17];
        heightProjectName = heightProjectName+5>35?heightProjectName:kscaleDeviceHeight(17);
        
        NSString *stringContructionUnit = [NSString stringWithFormat:@"建设单位：%@",item[@"ConstructionUnit"]] ;
        CGFloat heightcontructionUnit = [NSString calculateTextHeight:kscaleIphone5DeviceLength(269) Content:stringContructionUnit    font:themeFont17];
        heightcontructionUnit = heightcontructionUnit+5>35?heightcontructionUnit:kscaleDeviceHeight(17);
        
     
        NSString *stringBuildUnit = [NSString stringWithFormat:@"施工单位：%@",item[@"BuildUnit"]] ;
        CGFloat heightBuildUnit = [NSString calculateTextHeight:kscaleIphone5DeviceLength(269) Content:stringBuildUnit    font:themeFont17];
        heightBuildUnit = heightBuildUnit+5>35?heightBuildUnit:kscaleDeviceHeight(17);
        
        
       
        NSString *stringSupervisorUnit = [NSString stringWithFormat:@"监督单位：%@",item[@"SupervisorUnit"]] ;
        CGFloat heightSuperVisorUnit = [NSString calculateTextHeight:kscaleIphone5DeviceLength(269) Content:stringSupervisorUnit    font:themeFont17];
        heightSuperVisorUnit = heightSuperVisorUnit+5>35?heightSuperVisorUnit:kscaleDeviceHeight(17);
        
       
        NSString *stringSupervisorkey = [NSString stringWithFormat:@"质监站：%@",item[@"SuperviserKey"]] ;
        CGFloat heightSuperVisorKey = [NSString calculateTextHeight:kscaleIphone5DeviceLength(269) Content:stringSupervisorkey    font:themeFont17];
        heightSuperVisorKey = heightSuperVisorKey+5>35?heightSuperVisorUnit:kscaleDeviceHeight(17);
        // self.viewBottom.frame = CGRectMake(0,kscaleDeviceHeight(225) +heightProjectName+kscaleDeviceHeight(25) +heightcontructionUnit+kscaleDeviceHeight(25) +heightBuildUnit+kscaleDeviceHeight(25)+heightSuperVisorUnit+kscaleDeviceHeight(25) +heightSuperVisorKey+kscaleDeviceHeight(25)+kscaleDeviceHeight(45), DeviceWidth,kscaleDeviceHeight(45));
        
        return kscaleDeviceHeight(200) +heightProjectName+kscaleDeviceHeight(23) +heightcontructionUnit+kscaleDeviceHeight(23) +heightBuildUnit+kscaleDeviceHeight(23)+heightSuperVisorUnit+kscaleDeviceHeight(23) +heightSuperVisorKey+kscaleDeviceHeight(23)+kscaleDeviceHeight(40)+kscaleDeviceHeight(40);
    }else{
        NSString *stringProjectName=[NSString stringWithFormat:@"工程名称：%@",item[@"ProJectName"]];
        CGFloat heightProjectName = [NSString calculateTextHeight:kscaleIphone5DeviceLength(269) Content:stringProjectName    font:themeFont17];
        heightProjectName = heightProjectName+5>35?heightProjectName:kscaleDeviceHeight(17);
        return kscaleDeviceHeight(40)+kscaleDeviceHeight(23)+heightProjectName+kscaleDeviceHeight(40)+kscaleDeviceHeight(40)+kscaleDeviceHeight(40);
    }

}
- (void)        simpleTableView:(UITableView *)tableView didSelectedWithData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath{
    if (!_isProjectType) {
//        UQReportDetailViewController *controller = [[UQReportDetailViewController alloc]init];
//        controller.checkSum = item[@"IdentifyingCode"];
//        controller.reportId = item[@"Report_ID"];
//        [self.navigationController pushViewController:controller animated:YES];

        ReportCheckViewController *controller = [[ReportCheckViewController alloc] init];
        controller.keyId =item[@"Report_ID"];
        controller.checksum=item[@"IdentifyingCode"];
//        controller.dataDic = item;
         [self.navigationController pushViewController:controller animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


@end
