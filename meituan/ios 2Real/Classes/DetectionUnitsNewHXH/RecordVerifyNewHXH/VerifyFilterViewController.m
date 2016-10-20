//
//  VerifyFilterViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-6.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "VerifyFilterViewController.h"
#import "LSFormSelectCell.h"
#import "LSFormSwitchCell.h"
#import "LSFormSelectChangeFrameSearchCell.h"

@interface VerifyFilterViewController ()<LSFormTableViewControllerDelegate>
{
    LSFormSelectChangeFrameSearchCell *_kindCell;
    LSFormSelectChangeFrameSearchCell *_itemCell;
    LSFormSelectChangeFrameSearchCell *_isCompleteCell;
}
@property(nonatomic,retain) NSArray *items;
@property(nonatomic,retain) NSArray *kinds;
@property(nonatomic,assign) BOOL dataRequestSuccess;

@end

@implementation VerifyFilterViewController
- (void)setDatawithNavTitle {
    if (_type==FilterViewControllerTypeVerify) {
        self.titleForNav = @"纪录审核查询";
    }else{
       self.titleForNav = @"报告批准查询";
    }
    
   
    
}

- (instancetype)initWithtype:(FilterViewControllerType )type{
   
    _type = type;
    self = [super initWithMapper:@[
                                   formTableViewFormMapper(@[
                                                             [LSFormSelectChangeFrameSearchCell mapperWithCellName:@"kindCell" keyName:@"kind" label:@"审核类别" andMapper:@{} andHeight:@"57"],
                                                             [LSFormSelectChangeFrameSearchCell mapperWithCellName:@"itemCell" keyName:@"item" label:@"审核项目" andMapper:@{} andHeight:@"57"],[LSFormSelectChangeFrameSearchCell mapperWithCellName:@"isCompleteCell" keyName:@"isComplete" label:@"查询已审核纪录" andMapper:@{@"0":@"否",@"1":@"是"} andHeight:@"57"],
                                                             
                                                             ]
                                                           )
                                   ]];
    if (self) {
        _kindCell = self.cellsDict[@"kindCell"];
        _itemCell = self.cellsDict[@"itemCell"];
        _isCompleteCell = self.cellsDict[@"isCompleteCell"];
        _isCompleteCell.labelContent.text = @"否";
    }
    return self;
}

- (instancetype)init
{
    self = [super initWithMapper:@[
                                   formTableViewFormMapper(@[
                                                             [LSFormSelectChangeFrameSearchCell mapperWithCellName:@"kindCell" keyName:@"kind" label:@"批准类别" andMapper:@{} andHeight:@"57"],
                                                             [LSFormSelectChangeFrameSearchCell mapperWithCellName:@"itemCell" keyName:@"item" label:@"批准项目" andMapper:@{} andHeight:@"57"],[LSFormSelectChangeFrameSearchCell mapperWithCellName:@"isCompleteCell" keyName:@"isComplete" label:@"查询已批准纪录" andMapper:@{@"0":@"否",@"1":@"是"} andHeight:@"57"],
//                                                             [LSFormSelectCell mapperWithCellName:@"kindCell" keyName:@"kind" label:@"类别" andMapper:@{}],
//                                                             [LSFormSelectCell mapperWithCellName:@"itemCell" keyName:@"item" label:@"项目" andMapper:@{}],
//                                                             [LSFormSwitchCell mapperWithCellName:@"isCompleteCell" keyName:@"isComplete" andLabel:@"已批准/审核记录"]
                                                             ]
                                                           )
                                   ]];
    if (self) {
        _kindCell = self.cellsDict[@"kindCell"];
        _itemCell = self.cellsDict[@"itemCell"];
        _isCompleteCell = self.cellsDict[@"isCompleteCell"];
        _isCompleteCell.labelContent.text = @"否";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataRequestSuccess = false;

    self.delegate = self;

    
}
- (void)viewWillAppear:(BOOL)animated{
    if (_dataRequestSuccess == false) {
        [self dataRequest];
       
    }
}

//- (void)rightBarButtonDidPress:(UIBarButtonItem *)sender{
//    NSDictionary *data = self.formData;
//    if (!(data[@"kind"]&&data[@"item"])) {
//        [LSDialog showMessage:@"请选择项目"];
//        return;
//    }
//    if (_onComplete) {
//
//        _onComplete(data[@"kind"],data[@"item"],[data[@"isComplete"] boolValue], _itemCell.selectMapper[data[@"item"]]);
//    }
//}

- (void)dataRequest{
    
    NSDictionary *params = @{
                             @"Type" : _type == FilterViewControllerTypeApply?@"0": @"1",
                             @"Token": [LoginUtil token]
                             };
    APIConnection *connection = [[USTApi sharedInstance]connectionWithApiName:APIMETHOD_UST_AuditedExamedKind params:params];
    [connection setOnSuccess:^(id result) {
        _dataRequestSuccess = true;
        NSMutableDictionary *kindMapper = [NSMutableDictionary dictionary];
        NSArray *data = result[kAPIConnectionStandartDataKey];
        [data enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
            kindMapper[obj[@"KindId"]] = obj[@"KindName"];
        }];
        
        _kindCell.selectMapper = kindMapper;

        [SVProgressHUD dismiss]; 
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
    }];
    [SVProgressHUD show];
    [connection startAsynchronous];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)formTableView:(LSFormTableViewController*)viewController shouldCellSelected:(LSFormCell *)cell{
    id kindId = self.formData[@"kind"];
    if (cell == _itemCell && kindId == NULL){
        [LSDialog showAlertWithTitle:@"提示" message:@"请先选择类别" callBack:0];

        return false;
    }
    return true;
}


- (void)kindCellValueChanged:(LSFormSelectCell *)cell{
//    [LSDialog showAlertWithTitle:@"tishi" message:@"change" callBack:0];
    _itemCell.selectMapper = nil;
    _itemCell.labelContent.text = @"";
    
    NSDictionary *params = @{
                             @"Type" : _type == FilterViewControllerTypeApply?@"0": @"1",
                             @"Token": [LoginUtil token],
                             @"KindId":cell.data
                             };
    APIConnection *connection = [[USTApi sharedInstance]connectionWithApiName:APIMETHOD_UST_AuditedExamedItem params:params];
    [connection setOnSuccess:^(id result) {
        NSMutableDictionary *itemMapper = [NSMutableDictionary dictionary];
        NSArray *data = result[kAPIConnectionStandartDataKey];
        [data enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
            itemMapper[obj[@"ItemId"]] = obj[@"ItemName"];
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
- (void)itemCellValueChanged:(LSFormSelectCell *)cell{
    
}

#pragma mark ----UITableViewDelegate----
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 84)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = CGRectMake((DeviceWidth-194)/2, 44, 194, 40);
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
    return 84;
}

- (void)btnclickSureButton{
    NSDictionary *data = self.formData;
    if (!(data[@"kind"]&&data[@"item"])) {
        [LSDialog showMessage:@"请选择项目"];
        return;
    }
    
    if (_onComplete) {
        _onComplete(data[@"kind"],data[@"item"],[data[@"isComplete"] boolValue], _itemCell.selectMapper[data[@"item"]]);
    }
}
@end
