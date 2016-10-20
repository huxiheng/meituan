//
//  SampleSearchListViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-25.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "SampleSearchListViewController.h"
#import "SampleSearchTableViewCell.h"
//#import "WorkSiteSampleDetailViewController.h"
#import "WorkSiteSampleNewVCController.h"
#import "WorkSiteSampleInfoViewController.h"
#import "WorkSiteSearchViewController.h"
//#import "QRCodeViewController.h"
@interface SampleSearchListViewController ()
@property(nonatomic,retain) WorkSiteSearchViewController *searchController;
@end

@implementation SampleSearchListViewController

- (void)setdataForNav {
    self.titleForNav = @"样品信息查询";
    
}

- (void)setFrames{
    _viewScanningBarCode.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(40));
    _viewScanningBarCodeInside.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(40));
    
    _imageviewXuXianLine.frame = CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1));
    _btnCodeScanning.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(40));
    
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, kscaleDeviceHeight(0), DeviceWidth, DeviceHeight-kscaleDeviceHeight(0)-64);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFrames];
    _btnCodeScanning.hidden = YES;//隐藏搜索按钮
    
    self.loadOnlyOnce = true;
    self.pageController.pageName = @"CurrentPageNo";
    self.pageController.stepName = @"PageSize";
//    self.title = @"样品信息查询";
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_navigation_search"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDidPress:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;

    self.labelSaoMiao.textColor = [UIColor colorWithHexString:kc00_7ED127];
    self.labelSaoMiao.userInteractionEnabled = YES;
    

}
- (IBAction)qrcodeButtonDidPress:(id)sender {
//    QRCodeViewController *controller = [[QRCodeViewController alloc]init];
//    [self.navigationController pushViewController:controller animated:YES];
//    
//    [controller setOnRecognized:^(NSString *qrresult) {
//        
//        [self.navigationController popViewControllerAnimated:NO];
//        
//        NSDictionary *params = @{
//                                 @"CoreCode":qrresult,
//                                 @"Token":[LoginUtil token]
//                                 };
//        APIConnection *connection = [[CommonAPI sharedInstance]connectionWithApiName:APIMETHOD_SM_SampleDetailQR params:params];
//        [connection setOnSuccess:^(id result) {
//            [SVProgressHUD dismiss];
//        WorkSiteSampleNewVCController *controller = [[WorkSiteSampleNewVCController alloc]init];
//        controller.dicData = result[kAPIConnectionStandartDataKey];
//           controller.qrcode = qrresult; 
//            [self.navigationController pushViewController:controller animated:YES];
//        }];
//        [connection setOnFailed:^(NSError *error) {
//            NSString *errorDescription = [error localizedDescription];
//            [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
//        }];
//        [SVProgressHUD show];
//        [connection startAsynchronous];
//    }];
}
- (void)rightBarButtonDidPress:(id)sender {
    if (!_searchController) {
        _searchController = [[WorkSiteSearchViewController alloc]init];
        _searchController.completeLabelText = @"不包括作废样品";
    }
    [self.navigationController pushViewController:_searchController animated:YES];
    weakAlias(wSelf, self);
    [_searchController setOnComplete:^(BOOL isComplete, NSString *keyword) {
        NSMutableDictionary *params = [wSelf.pageController.apiParams mutableCopy];
        params[@"QueryStr"] = STRING_EMPTY_IF_NOT(keyword);
        params[@"NotCancelOnly"] = isComplete ? [NSNumber numberWithBool:true] : [NSNumber numberWithBool:false];
        
        wSelf.pageController.apiParams = params;
        
        [wSelf.pageController refreshNoMerge];
        
        [wSelf.navigationController popViewControllerAnimated:YES];
    }]; 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//to Implement
- (void)toInitPageControllerWith:(NSString **) apiName params:(NSDictionary **)params{
    *apiName = APIMETHOD_SM_SampleList;
    *params  =  @{
                  @"ContractSignNumber"         : _signNumber,
                  @"NotCancelOnly"              : [NSNumber numberWithBool:true],
                  @"QueryStr"           : @"",
                  
                  @"Token"              : [LoginUtil token]
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

- (void)        simpleTableView:(UITableView *)tableView fillCell:(SampleSearchTableViewCell *)cell withData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath{
    cell.data = item;
    cell.indexPathSampleSearch = indexPath;
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
}
- (NSString *)  simpleTableViewCellNibName:(UITableView *)tableView{
    return @"SampleSearchTableViewCell";
}
- (CGFloat)     simpleTableView:(UITableView *)tableView cellHeightForData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath;{

    return 114;
}
- (void)        simpleTableView:(UITableView *)tableView didSelectedWithData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *params = @{
                             @"Id"          : item[@"Id"],
                             @"MemberCode"  : item[@"MemberCode"],
                             @"Token"       : [LoginUtil token]
                             };
    APIConnection *connection = [[CommonAPI sharedInstance]connectionWithApiName:APIMETHOD_SM_SampleDetail params:params];
    [connection setOnSuccess:^(id result) {
        [SVProgressHUD dismiss];
        WorkSiteSampleInfoViewController *controller = [[WorkSiteSampleInfoViewController alloc]init];
        controller.isQRDetail = false;
        controller.dataDic = result[kAPIConnectionStandartDataKey];
        [self.navigationController pushViewController:controller animated:YES];
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
    }];
    [SVProgressHUD show];
    [connection startAsynchronous];

    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
