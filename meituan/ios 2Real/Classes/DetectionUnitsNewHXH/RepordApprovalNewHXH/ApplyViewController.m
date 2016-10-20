//
//  ApplyViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "ApplyViewController.h"
#import "ApplyTableViewCell.h"
#import "ApplyCompleteTableViewCell.h"
#import "VerifyFilterViewController.h"
//#import "ApplyDetailViewController.h"
#import "ApplyReportDetailNewViewController.h"
#import "AppDelegate.h"
@interface ApplyViewController ()<ApplyTableViewCellDelegate>
@property(nonatomic,retain) NSString *itemId;
@property (weak, nonatomic) IBOutlet UIView *verifyButtonLayout;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property(nonatomic,assign) BOOL isCompleteRecord;
@property (weak, nonatomic) IBOutlet UIView *viewProjectName;

@end
static NSString *ApplyViewControllerNormalCellIdentifier  = @"NormalCell";
static NSString *ApplyViewControllerCompleteCellIdentifier = @"CompleteCell";
@implementation ApplyViewController
- (void)setdataForNav {
    self.titleForNav = @"报告批准";
}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.isCompleteRecord = false;
    self.verifyButtonLayout.frame = CGRectMake(0, DeviceHeight-44-64, DeviceWidth, 44);
    self.tableView.frame = CGRectMake(0, 44, DeviceWidth, DeviceHeight-44-44-64);
    self.itemLabel.textColor = [UIColor colorWithHexString:kc00_333333];
    self.itemLabel.text = @"未选择";
    UIView *viewverifyUpLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 0.5)];
    viewverifyUpLine.backgroundColor = kcolorLine;
    [self.verifyButtonLayout addSubview:viewverifyUpLine];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_navigation_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonDidPress:)];
    self.navigationItem.leftBarButtonItem = barButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_navigation_search"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDidPress:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.loadOnlyOnce = true;
    self.pageController.pageName = @"CurrentPageNo";
    self.pageController.stepName = @"PageSize";
    [_tableView registerNib:[UINib nibWithNibName:@"ApplyTableViewCell" bundle:nil] forCellReuseIdentifier:ApplyViewControllerNormalCellIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:@"ApplyCompleteTableViewCell" bundle:nil] forCellReuseIdentifier:ApplyViewControllerCompleteCellIdentifier];
    
//    self.itemId = @"1110";

    
}
- (void)defualtId{
    if( self.itemId != NULL) return;
    NSDictionary *params = @{
                             @"Type" : @"1",
                             @"Token": [LoginUtil token]
                             };
    APIConnection *connection = [[USTApi sharedInstance]connectionWithApiName:APIMETHOD_UST_AuditedExamedKind params:params];
    [connection setOnSuccess:^(id result) {
        NSArray *data = ARRAY_EMPTY_IF_NOT( result[kAPIConnectionStandartDataKey] );
        if (data.count == 0) {
            [SVProgressHUD dismiss];
            return ;
        }
        NSDictionary *params = @{
                                 @"Type" :  @"1",
                                 @"Token": [LoginUtil token],
                                 @"KindId":data[0][@"KindId"]
                                 };
        APIConnection *connection = [[USTApi sharedInstance]connectionWithApiName:APIMETHOD_UST_AuditedExamedItem params:params];
        [connection setOnSuccess:^(id result) {
            NSArray *itemData = result[kAPIConnectionStandartDataKey];
            if (itemData.count > 0) {
                self.itemId = itemData[0][@"ItemId"];
                _itemLabel.text = itemData[0][@"ItemName"];
                [self refreshNoMerge];                
            }
            [SVProgressHUD dismiss];
        }];
        [connection setOnFailed:^(NSError *error) {
            NSString *errorDescription = [error localizedDescription];
           
            [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
        }];
        [connection startAsynchronous];
        
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
    }];
    [SVProgressHUD show];
    [connection startAsynchronous];
    
}
- (void)leftBarButtonDidPress:(UIBarButtonItem *)sender{
    [APP_DELEGATE.rootMainViewController showLeft];
}

- (void)viewWillAppear:(BOOL)animated{
//    if (_itemId == NULL && self.isFirstLoad) {
//        [self pushVerifyFilterViewController];
//    }
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   // [self defualtId];
//    if (_itemId == NULL){// && self.isFirstLoad) {
//        [LSDialog showAlertWithTitle:@"提示" message:@"您还没有选择项目，请先选择项目。" callBack:^{
//            [self pushVerifyFilterViewController];            
//        }];
//    }   
}

- (void)rightBarButtonDidPress:(UIBarButtonItem *)sender{
    [self pushVerifyFilterViewController];
}
- (void) pushVerifyFilterViewController{
    static VerifyFilterViewController *controller;
    if (controller == NULL) {
        controller = [[VerifyFilterViewController alloc]init];
    }
    controller.type = FilterViewControllerTypeApply;
    [self.navigationController pushViewController:controller animated:true];
    [controller setOnComplete:^(NSString *kindId, NSString *itemId, BOOL isCompleteRecord,NSString *label) {
        self.itemId = itemId;
        self.isCompleteRecord = isCompleteRecord;
        
        _itemLabel.text = label;
        [self.navigationController popViewControllerAnimated:YES];
        [self refreshNoMerge];
        [self refreshtableViewFrame];
        
    }];
}
- (void)refreshtableViewFrame{
    switch (self.isCompleteRecord) {
        case YES:
            self.tableView.frame = CGRectMake(0, 44, DeviceWidth, DeviceHeight-44-64);
            break;
        case NO:
            self.tableView.frame = CGRectMake(0, 44, DeviceWidth, DeviceHeight-44-44-64);
            break;
        default:
            break;
    }
}
- (void)setItemId:(NSString *)itemId{
    _itemId = itemId;
    
    NSMutableDictionary *params = [self.pageController.apiParams mutableCopy];
    params[@"ItemId"] = itemId;
//    params[@"ItemId"] = @"1108";
//    params[@"ItemId"] = @"1110";
    self.pageController.apiParams = params;
    [self.tableView setContentOffset:CGPointMake(0, 0)];
}



- (void)setIsCompleteRecord:(BOOL)isCompleteRecord{
    _isCompleteRecord = isCompleteRecord;
    if (isCompleteRecord) {
        _verifyButtonLayout.hidden = true;
        self.pageController.apiName = APIMETHOD_UST_AuditedList;
    }else{
        _verifyButtonLayout.hidden = false;
        self.pageController.apiName = APIMETHOD_UST_AuditList;        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifier = nil;
    if (_isCompleteRecord){
        cellIdentifier = ApplyViewControllerCompleteCellIdentifier;
    }else{
        cellIdentifier = ApplyViewControllerNormalCellIdentifier;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
   
    NSDictionary *item = [self itemForIndexPath:indexPath];
    [self simpleTableView:tableView fillCell:cell withData:item andIndexPath:indexPath];
    return cell;
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (_enableDebugMode) {
//        return  _debugItemCount;
//    }
    return self.pageController.list.count;
}


//to Implement
- (void)toInitPageControllerWith:(NSString **) apiName params:(NSDictionary **)params{
    *apiName = APIMETHOD_UST_AuditList;
    *params  =  @{@"Token":[LoginUtil token]};
}
- (void)afterInitPageController:(LSPageController *)pageController{
    pageController.apiClass = @"USTApi";
    weakAlias(wPageController, pageController);
    [pageController setPageinfoAdapter:^(NSDictionary *input, BOOL *success, NSArray *__autoreleasing * list, int *totalCount, NSString *__autoreleasing *errorMessage) {
        *success = [input[kAPIConnectionStandartSuccessKey] boolValue];
        if (success) {
            *list = input[kAPIConnectionStandartDataKey];
            *totalCount = wPageController.currentPage + 1;
        }else{
            *errorMessage = input[kAPIConnectionStandartMessageKey];
        } 
    }];
}

- (void)        simpleTableView:(UITableView *)tableView fillCell:(id)cell withData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath{
    if (_isCompleteRecord){
        LS_CAST(ApplyCompleteTableViewCell *, cell).data  = item;
    }else{
        LS_CAST(ApplyTableViewCell *, cell).data  = item;        
        LS_CAST(ApplyTableViewCell *, cell).delegate = self;
    }
}

- (NSString *)  simpleTableViewCellNibName:(UITableView *)tableView{
    return @"ApplyTableViewCell";
}

- (CGFloat)     simpleTableView:(UITableView *)tableView cellHeightForData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath{
    if (_isCompleteRecord){
        return [ApplyCompleteTableViewCell cellHeight];
    }else{
        NSString * text    = item[@"Report_CreateDate"];
        CGFloat heightDate = [NSString calculateTextHeight:kscaleIphone5DeviceLength(149) Content:text font:themeFont17];
        heightDate= heightDate+5>30?heightDate:17;
//        self.viewBottomLast.frame = CGRectMake(0, 28+heightDate+90, 270, 45)
        
//        return 28+heightDate+90+45;
        return kscaleDeviceHeight(23)+heightDate+kscaleDeviceHeight(80)+kscaleDeviceHeight(40);
    }
}
- (void)        simpleTableView:(UITableView *)tableView didSelectedWithData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath{
    if (_isCompleteRecord){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        ApplyReportDetailNewViewController *controller = [[ApplyReportDetailNewViewController alloc]init];
        controller.consignId = item[@"ConSign_ID"];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        //        if ([[tableView indexPathsForSelectedRows] containsObject:indexPath]){
        //            [tableView deselectRowAtIndexPath:indexPath animated:NO];
        //        }
    }
}

- (BOOL)onRefreshRequest{
    if (_itemId) {
        return true;        
    }else{
        return false;
    }
}

- (BOOL)onNextRequest{
    if (_itemId) {
        return true;        
    }else{
        return false;
    }
    
}
- (void)applyTableViewCellDidPress:(ApplyTableViewCell *)cell{
    NSDictionary *item = cell.data;
    ApplyReportDetailNewViewController *controller = [[ApplyReportDetailNewViewController alloc]init];
    controller.consignId = item[@"ConSign_ID"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)verifySelectedButtonDidPress:(id)sender {
    if([_tableView indexPathsForSelectedRows].count == 0 ){
        [LSDialog showAlertWithTitle:@"提示" message:@"未选择数据" callBack:0];
        return; 
    }
    __block NSInteger failedCount = 0;
    [SVProgressHUD showWithStatus:@"操作中"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [[_tableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(NSIndexPath* obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *data = [self itemForIndexPath:obj];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"Token"] = [LoginUtil token];
            params[@"ConSign_ID"]   = data[@"ConSign_ID"];
            params[@"Report_ID"]    = data[@"Report_ID"];
            params[@"Report_CreateDate"]    = data[@"Report_CreateDate"];
            APIConnection *connection = [[USTApi sharedInstance]connectionWithApiName:APIMETHOD_UST_Audit params:params];
            [connection setOnFailed:^(NSError *error) {
                failedCount ++ ;
            }];
            [connection startSynchronous];    
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(failedCount >0){
                [SVProgressHUD dismiss];
                [LSDialog showMessage:[NSString stringWithFormat:@"批准完成，有%d条记批准失败",failedCount]];
                [self refreshNoMerge];
            }else{
                [SVProgressHUD dismissWithSuccess:NULL];
                [self refreshNoMerge];         
            }
        });
        
    });
    
    
}
- (IBAction)verifyAllButtonDidPress:(id)sender {
    if(self.pageController.list.count == 0 ){
        [LSDialog showAlertWithTitle:@"提示" message:@"未选择数据" callBack:0];
        return; 
    }
    __block NSInteger failedCount = 0;
    [SVProgressHUD showWithStatus:@"操作中"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0 ; i < self.pageController.list.count; i++) {
            NSDictionary *data = self.pageController.list[i];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"Token"] = [LoginUtil token];
            params[@"ConSign_ID"]   = data[@"ConSign_ID"];
            params[@"Report_ID"]    = data[@"Report_ID"];
            params[@"Report_CreateDate"]    = data[@"Report_CreateDate"];
            
            APIConnection *connection = [[USTApi sharedInstance]connectionWithApiName:APIMETHOD_UST_Audit params:params];
            [connection setOnFailed:^(NSError *error) {
                failedCount ++ ;
            }];
            [connection startSynchronous];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if(failedCount >0){
                [SVProgressHUD dismiss];
                [LSDialog showMessage:[NSString stringWithFormat:@"批准完成，有%d条记录批准失败",failedCount]];
                [self refreshNoMerge];
            }else{
                [SVProgressHUD dismissWithSuccess:NULL];
                [self refreshNoMerge];         
            }
        });
    });
    
}
@end
