//
//  UnqualifiedSearchViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "UnqualifiedSearchViewController.h"
#import "LSFormTextFieldCell.h"
#import "LSFormSelectCell.h"
#import "LSFormTimeRangeCell.h"
#import "CommonAPI.h"
#import "UQReportListViewController.h"
#import "AppDelegate.h"
#import "LSFormTextFieldUnqualifyCell.h"
#import "LSFormTextViewCell.h"
#import "LSForm.h"
#import "LSFormSelectUnqualitifyNewCell.h"
#import "LSFormRangeUnqualitafyNewCell.h"
#import "LSFormDateUnqualifyCell.h"
#import "LSFormSelectChangeFrameSearchCell.h"

@interface UnqualifiedSearchViewController ()<LSFormTableViewControllerDelegate>{
    NSDictionary *areaMap;
    NSArray *_sampleMap;
    NSArray *_projectMap;
    LSFormSelectChangeFrameSearchCell *_kindCell;
    LSFormSelectChangeFrameSearchCell *_itemCell;
}
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *projectButton;
@property (weak, nonatomic) IBOutlet UIButton *sampleButton;

@property(nonatomic,retain) NSMutableDictionary *queryData;

@property(nonatomic,assign) BOOL dataRequestSuccess;

@property (nonatomic, strong)NSMutableDictionary *dickind;

@end

@implementation UnqualifiedSearchViewController
- (instancetype)init
{
    self = [super initWithMapper:@[]];
    if (self) {
      
    }
    return self;
}
- (void)setDatawithNavTitle{
    self.titleForNav = @"不合格信息查询";
}

-(void)updateCaiLiaoJianCe{
   
    
    NSDictionary *entrustTypeMap = @{
                                     @"-1":@"全部",
                                     @"0":@"常规检测",
                                     @"1":@"监理平行检测"
                                     };
    NSDictionary *uqExecStatusMap= @{
                                     @"-1":@"全部",
                                     @"0":@"未处理",
                                     @"1":@"已处理",
                                     @"2":@"处理中"
                                     };
    
    //
    
    _sampleMap = @[
                   [LSFormTextFieldUnqualifyCell mapperWithCellName:@"nameCell" keyName:@"ProjectName" label:@"工地名称"],
                   [LSFormSelectUnqualitifyNewCell mapperWithCellName:@"areaCell" keyName:@"ProjectArea" label:@"工程区县" andMapper:areaMap],
                   [LSFormTextFieldUnqualifyCell mapperWithCellName:@"unitCell" keyName:@"EntrustUnitName" label:@"委托单位"],
                   [LSFormTextFieldUnqualifyCell mapperWithCellName:@"itemNameCell" keyName:@"ItemName" label:@"项目名称"],
                   [LSFormRangeUnqualitafyNewCell mapperWithCellName:@"timeCell" keyName:@"Report_CreateDate" label:@"报告日期"],
                   [LSFormTextFieldUnqualifyCell mapperWithCellName:@"reportNumberCell" keyName:@"BuildingReportNumber" label:@"报建编号"],
                   [LSFormSelectUnqualitifyNewCell mapperWithCellName:@"entrustTypeCell" keyName:@"EntrustType" label:@"检测性质" andMapper:entrustTypeMap],
                   
                   [LSFormSelectUnqualitifyNewCell mapperWithCellName:@"jianceKindCell" keyName:@"jianceKind" label:@"检测类别" andMapper:@{} ],
                   [LSFormSelectUnqualitifyNewCell mapperWithCellName:@"jianceItermCell" keyName:@"ItemID" label:@"检测项目" andMapper:@{} ],
                   [LSFormSelectUnqualitifyNewCell mapperWithCellName:@"uqExecStatusCell" keyName:@"UqExecStatus" label:@"处理状态" andMapper:uqExecStatusMap],
                   ];
    
    if (self) {
        
        
    }

}

- (void)viewWillAppear:(BOOL)animated{
    
    if (_dataRequestSuccess == false) {
        [self dataRequestJianCeKind];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    IOS7_LAYOUT_FIX;
    UIView *viewBottonHeadLine = [[UIView alloc] initWithFrame:CGRectMake(0,kscaleDeviceHeight(49.5) , DeviceWidth,kscaleDeviceHeight(0.5) )];
    viewBottonHeadLine.backgroundColor =kcolorLine;
    [_headerView addSubview:viewBottonHeadLine];
    _headerView.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(50));
    _projectButton.frame= CGRectMake(kscaleIphone5DeviceLength(160), 0, kscaleIphone5DeviceLength(160), kscaleDeviceHeight(50));
    _sampleButton.frame = CGRectMake(0, 0, kscaleIphone5DeviceLength(160), kscaleDeviceHeight(50));
    
    
    self.tableView.tableHeaderView = _headerView;
    UIBarButtonItem *leftBarIterm = [[UIBarButtonItem alloc] init];
    UIButton * leftBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIImageView  *imageUp = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 20, 20)];
    imageUp.image = [UIImage imageNamed:@"navcaidan"];
    [leftBarButton addSubview:imageUp];
    UILabel *labelDown = [[UILabel alloc] initWithFrame:CGRectMake(10, 28, 25, 11)];
    labelDown.text = @"菜单";
    labelDown.textColor = [UIColor whiteColor];
    labelDown.font = themeFont10;
    labelDown.textAlignment = NSTextAlignmentCenter;
//    [leftBarButton addSubview:labelDown];
    [leftBarButton addTarget:self action:@selector(leftBarButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    
    [leftBarIterm setCustomView:leftBarButton];
    self.navigationItem.leftBarButtonItem = leftBarIterm;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_navigation_search"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDidPress:)];
//    self.navigationItem.rightBarButtonItem = rightBarButton;

    [self dataRequest];
    
    
    areaMap = @{
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
                              @"外省市":@"外省市",
                              @"闸北区":@"闸北区",
                              @"长宁区":@"长宁区",
                              @"嘉定区":@"嘉定区",
                              @"静安区":@"静安区",
                              @"虹口区":@"虹口区",
                              @"所有区县":@"所有区县"
                              };
}

//请求检测类别的网络数据
-(void)dataRequestJianCeKind{
    NSDictionary *params = @{
                             @"Token": [LoginUtil token]
                             };
     APIConnection *connection = [[CommonAPI sharedInstance]connectionWithApiName:APIMETHOD_ItemKindSource params:params];
    [connection setOnSuccess:^(id result) {
        _dataRequestSuccess = true;
        NSMutableDictionary *kindMapper = [NSMutableDictionary dictionary];
        NSArray *data = result[kAPIConnectionStandartDataKey];
        [data enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
            kindMapper[obj[@"Order"]] = obj[@"Name"];
        }];
        
        _kindCell.selectMapper = kindMapper;
        self.dickind = kindMapper;
        [SVProgressHUD dismiss];
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
    }];
    [SVProgressHUD show];
    [connection startAsynchronous];

}

//刷新检测项目的数据
- (BOOL)formTableView:(LSFormTableViewController*)viewController shouldCellSelected:(LSFormCell *)cell{
    id kindId = self.formData[@"jianceKind"];
    if (cell == _itemCell && kindId == NULL){
        [LSDialog showAlertWithTitle:@"提示" message:@"请先选择检测类别" callBack:0];
        
        return false;
    }
    return true;
}
- (void)jianceKindCellValueChanged:(LSFormSelectCell *)cell{
    //    [LSDialog showAlertWithTitle:@"tishi" message:@"change" callBack:0];
    _itemCell.selectMapper = nil;
    _itemCell.labelContent.text = @"";
    
    NSDictionary *params = @{
                             
                             @"Token": [LoginUtil token],
                             @"KindId":cell.data
                             };
     APIConnection *connection = [[CommonAPI sharedInstance]connectionWithApiName:APIMETHOD_ItemItemSource params:params];
    
    [connection setOnSuccess:^(id result) {
        NSMutableDictionary *itemMapper = [NSMutableDictionary dictionary];
        NSArray *data = result[kAPIConnectionStandartDataKey];
        [data enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
            itemMapper[obj[@"Id"]] = obj[@"Name"];
        }];
        
        _itemCell.selectMapper = itemMapper;
        
        [SVProgressHUD dismiss];
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
    }];
    [SVProgressHUD show];
    [connection startAsynchronous];
}

//请求工程现场的网络数据
- (void)dataRequest{
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
//    [params setObject:[LoginUtil token] forKey:@"Token"];
    NSDictionary *params = @{
                             @"Token" : [LoginUtil token]
                             };
    APIConnection *connection = [[CommonAPI sharedInstance]connectionWithApiName:APIMETHOD_BHGItemSource params:params];
    [connection setOnSuccess:^(id result) {
        NSArray *data = result[kAPIConnectionStandartDataKey];
        [self updateUI:data];
        [SVProgressHUD dismiss];
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
    }];
    [connection setOnFinal:^{
        
    }];
    [SVProgressHUD show];
    [connection startAsynchronous];
}
- (void)updateUI:(NSArray *)data{
    NSMutableDictionary *queryKeyMap =[NSMutableDictionary dictionary];
    NSMutableDictionary *queryNameMap =[NSMutableDictionary dictionary];
    
    _queryData = [NSMutableDictionary dictionary];
    [data enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        queryKeyMap[obj[@"BhgId"]]    = obj[@"BhgId"];
        queryNameMap[obj[@"BhgItem"]] = obj[@"BhgItem"];
        _queryData[obj[@"BhgItem"]] = obj[@"BhgId"];
    }];
    
    [self updateCaiLiaoJianCe];
    //        Type(int)					数据实体类别	（值1）
    //        Token					令牌号		（GUID）
    
    _projectMap = @[
                     [LSFormSelectUnqualitifyNewCell mapperWithCellName:@"keyNameCell" keyName:@"KeyName" label:@"检测项目" andMapper:queryNameMap],
                      [LSFormSelectUnqualitifyNewCell mapperWithCellName:@"areaCell" keyName:@"ProjectArea" label:@"所属区县" andMapper:areaMap],
                    
                    [LSFormDateUnqualifyCell mapperWithCellName:@"unqualitydatecell" keyName:@"StartDate" label:@"开始日期" dateType:@"starteTypeDate"],
                    [LSFormDateUnqualifyCell mapperWithCellName:@"unqualitydateEndcell" keyName:@"EndDate" label:@"结束日期" dateType:@"endTypeDate"],
                   
                    
//                    [LSFormTextFieldCell mapperWithCellName:@"memberIdCell" keyName:@"MemberId" label:@"会员编号" placeHold:@"会员编号"],
//                    [LSFormTimeRangeCell mapperWithCellName:@"timeCell" keyName:@"date" label:@"日期范围"],
                    

//                    [LSFormSelectCell mapperWithCellName:@"keyNameCell"    keyName:@"KeyName" label:@"检测项目" andMapper:queryNameMap],
//                    [LSFormTextFieldCell mapperWithCellName:@"queryPowerCell" keyName:@"QueryPower" label:@"查询权限" placeHold:@"查询权限"],

                    ];
   
    
    self.type = UnqualifiedSearchViewControllerSample;
}

- (void)setType:(UnqualifiedSearchViewControllerType)type{
    _type = type;
    switch (type) {
        case UnqualifiedSearchViewControllerSample:{
         
            self.formMapper = @[formTableViewFormMapper(_sampleMap)];
            [self refreshTableViewCellHeight];
            
            LSFormRangeUnqualitafyNewCell *timeCell = self.cellsDict[@"timeCell"];
            _kindCell = self.cellsDict[@"jianceKindCell"];
            _itemCell = self.cellsDict[@"jianceItermCell"];
            _kindCell.selectMapper = self.dickind;
            
            timeCell.type = LSFTimeRangePickerViewControllerTypeDate;
            timeCell.dateFormat = @"yyyy-MM-dd";
            timeCell.data =[NSString stringWithFormat:@"%@,%@",timeStringOfTimeIntervalWithFormat([[NSDate date] timeIntervalSince1970]-24*60*60,@"yyyy-MM-dd"),timeStringOfTimeIntervalWithFormat([[NSDate date] timeIntervalSince1970],@"yyyy-MM-dd")] ;
            LSFormTimeRangeCell *unqualitafyRangeTimecell = self.cellsDict[@"unqualitafyRangeTimecell"];
            unqualitafyRangeTimecell.type = LSFTimeRangePickerViewControllerTypeDate;
            unqualitafyRangeTimecell.dateFormat = @"yyyy/MM/dd";
            unqualitafyRangeTimecell.data = [NSString stringWithFormat:@"%@,%@",timeStringOfTimeIntervalWithFormat([[NSDate date] timeIntervalSince1970]-24*60*60,@"yyyy-MM-dd"),timeStringOfTimeIntervalWithFormat([[NSDate date] timeIntervalSince1970],@"yyyy-MM-dd")];
        }
        break;
            
        case UnqualifiedSearchViewControllerProject:{
            self.formMapper = @[formTableViewFormMapper(_projectMap)];
            [self refreshTableViewCellHeight];
            LSFormTimeRangeCell *timeCell = self.cellsDict[@"timeCell"];
            timeCell.type = LSFTimeRangePickerViewControllerTypeDate;
            timeCell.dateFormat = @"YYYY-MM-dd";
            timeCell.data = @[timeStringOfTimeIntervalWithFormat([[NSDate date] timeIntervalSince1970]-24*60*60,@"YYYY-MM-dd"),
                              timeStringOfTimeIntervalWithFormat([[NSDate date] timeIntervalSince1970],@"YYYY-MM-dd"),
                              ];
            LSFormDateUnqualifyCell *unqualitydatecell = self.cellsDict[@"unqualitydatecell"];
            unqualitydatecell.type = UIDatePickerModeDate;
            unqualitydatecell.dateFormat = @"YYYY-MM-dd";
            unqualitydatecell.data=timeStringOfTimeIntervalWithFormat([[NSDate date] timeIntervalSince1970],@"YYYY-MM-dd");
            
            LSFormDateUnqualifyCell *unqualitydateEndcell = self.cellsDict[@"unqualitydateEndcell"];
            unqualitydateEndcell.type = UIDatePickerModeDate;
            unqualitydateEndcell.dateFormat = @"YYYY-MM-dd";
            unqualitydateEndcell.data=timeStringOfTimeIntervalWithFormat([[NSDate date] timeIntervalSince1970],@"YYYY-MM-dd");
        }
            
            
            break;
        default:
            break;
    }
}

- (NSDictionary *)genFilterParams{
    switch (_type) {
        case UnqualifiedSearchViewControllerSample:{
            NSMutableDictionary *params = [self.formData mutableCopy];;
            [params removeObjectForKey:@"jianceKind"];
            params[@"Token"] = [LoginUtil token];
            params[@"Type"] = @"0";
            return  params;
        }
            break;
        case UnqualifiedSearchViewControllerProject:{
            NSMutableDictionary *params = [self.formData mutableCopy];
            params[@"Token"] = [LoginUtil token];
            params[@"Type"] = @"1";
            
            params[@"QueryPower"] = @"";
            params[@"QueryKey"] =             _queryData[params[@"KeyName"]];
//            params[@"MemberId"] = @"";

//            params[@"StartDate"] = params[@"date"]?params[@"date"][0]:@"";
//            params[@"EndDate"] = params[@"date"]?params[@"date"][1]:@"";
//            [params removeObjectForKey:@"date"];
            return params;
            
        }break;
        default:
            break;
    }
    return nil;
            
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)rightBarButtonDidPress:(UIBarButtonItem *)sender{
    if (_type == UnqualifiedSearchViewControllerSample) {
        
        UQReportListViewController *controller = [[UQReportListViewController alloc]init];
        controller.isProjectType = false;
        controller.params = [self genFilterParams];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        if (!STRING_NOT_EMPTY (self.formData[@"KeyName"])) {
            [LSDialog showMessage:@"请选择查询项目"];
            return;
        }
        UQReportListViewController *controller = [[UQReportListViewController alloc]init];
        controller.isProjectType = true;
        controller.params = [self genFilterParams];
        [self.navigationController pushViewController:controller animated:YES];
    }

}
- (void)leftBarButtonDidPress:(UIBarButtonItem *)sender{
    [self resignFirstToTextView];
    
    
    [APP_DELEGATE.rootMainViewController showLeft];
    [self refreshTableViewCellHeight];
}
- (IBAction)sampleButtonDidPress:(UIButton *)sender {
    _projectButton.selected = false;
    _sampleButton.selected  = false;
    sender.selected  = true;
    
    
    self.type = UnqualifiedSearchViewControllerSample;
    
    [self.tableView reloadData];
}

- (IBAction)projectButtonDidPress:(UIButton *)sender {
    _projectButton.selected = false;
    _sampleButton.selected  = false;
    sender.selected  = true;

    self.type = UnqualifiedSearchViewControllerProject;
    [self.tableView reloadData];
}

- (void)refreshTableViewCellHeight{
    [self.formMapper enumerateObjectsUsingBlock:^(NSDictionary* formSection, NSUInteger idx, BOOL *stop) {
        if (IS_ARRAY(formSection[LSFormTableMapperFormCellKey])) {
            NSArray *formSectionCells = formSection[LSFormTableMapperFormCellKey];
            [formSectionCells enumerateObjectsUsingBlock:^(NSDictionary* cellMapper, NSUInteger idx, BOOL *stop) {
                NSString *cellName  = (cellMapper[LSFormTableMapperCellNameKey]);
                _kindCell.selectMapper = self.dickind;//解决显示左边视图，返回kindcell的值为空
                
                if ([cellName isEqualToString:@"nameCell"]||[cellName isEqualToString:@"unitCell"]||[cellName isEqualToString:@"itemNameCell"]||[cellName isEqualToString:@"reportNumberCell"]||[cellName isEqualToString:@"memberIdCell"]) {
                    NSString *heightStr  = [NSString stringWithFormat:@"%f", kscaleDeviceHeight(55)];
                    [cellMapper setValue:heightStr forKey:LSFormTableMapperCellHeightNewKey];
                    [self.tableView reloadData];
                }
                
                
            }
             ];
        }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self resignFirstToTextView];
}

- (void)resignFirstToTextView{
    switch (self.type) {
        case UnqualifiedSearchViewControllerSample:

            self.type = UnqualifiedSearchViewControllerSample;
            
            [self.cellsDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                LSFormCell *cell = (LSFormCell *)obj;
                [cell resignFirstResponder];
            }];
            break;
            
        case UnqualifiedSearchViewControllerProject:
            
            self.type = UnqualifiedSearchViewControllerProject;
            
            [self.cellsDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                LSFormCell *cell = (LSFormCell *)obj;
                [cell resignFirstResponder];
            }];
            break;
            
        default:
            break;
    }
}

#pragma mark ----- UITableviewDelegate ---------

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(84))];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = CGRectMake((DeviceWidth- kscaleDeviceWidth(190))/2,kscaleDeviceHeight(17) ,kscaleDeviceWidth(190), kscaleDeviceHeight(40));
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setBackgroundColor:[UIColor colorWithRed:71.0/255.0 green:189.0/255.0 blue:234.0/255.0 alpha:1.0]];
    [button addTarget:self action:@selector(btnclickSureButton) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kscaleDeviceHeight(84);
}

- (void)btnclickSureButton{
    [self rightBarButtonDidPress:nil];
}





@end
