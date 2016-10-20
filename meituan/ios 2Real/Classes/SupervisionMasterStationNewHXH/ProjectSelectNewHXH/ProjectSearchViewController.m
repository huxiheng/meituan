//
//  ProjectSearchViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-15.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "ProjectSearchViewController.h"
#import "LSFormSelectCell.h"
#import "LSFormSelectChangeFrameSearchCell.h"
#import "LSForm.h"

@interface ProjectSearchViewController ()

@end

@implementation ProjectSearchViewController

- (void)setDatawithNavTitle{
    self.titleForNav = @"工程查询";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *hourMap = @{
                      @"01":@"01",
                      @"02":@"02",
                      @"03":@"03",
                      @"04":@"04",
                      @"05":@"05",
                      @"06":@"06",
                      @"07":@"07",
                      @"08":@"08",
                      @"09":@"09",
                      @"10":@"10",
                      
                      @"11":@"11",
                      @"12":@"12",
                      @"13":@"13",
                      @"14":@"14",
                      @"15":@"15",
                      @"16":@"16",
                      @"17":@"17",
                      @"18":@"18",
                      @"19":@"19",
                      @"20":@"20",
                      
                      @"21":@"21",
                      @"22":@"22",
                      @"23":@"23",
                      @"24":@"24"
                      };
    self.formMapper = @[
                        formTableViewFormMapper(@[
                                                  [LSFormSelectChangeFrameSearchCell mapperWithCellName:@"memberCodeCell" keyName:@"memberCode" label:@"工程名" andMapper:@{@"":@"请稍候"} andHeight:@"50"],
                                                  [LSFormSelectChangeFrameSearchCell mapperWithCellName:@"timeCell" keyName:@"time" label:@"时效" andMapper:hourMap andHeight:@"50"],
//                                                  SelectCell( @"memberCode", @"会员号", @{@"":@"请稍候"}),
//                                                  SelectCell( @"time", @"时效", hourMap)
                                                  ])
                        ];
//
//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDidPress:)];
//    self.navigationItem.rightBarButtonItem = barButton;
//    self.title = @"筛选";
    [self dataRequest];
}
- (void)dataRequest{
    NSDictionary *params = @{
                             @"Token" : [LoginUtil token]
                             };
    APIConnection *connection = [[CommonAPI sharedInstance]connectionWithApiName:APIMETHOD_STAKE_MemberList params:params];
    [connection setOnSuccess:^(id result) {
        [SVProgressHUD dismiss];
        
        NSArray *list = result[kAPIConnectionStandartDataKey];
        NSMutableDictionary *map = [NSMutableDictionary dictionary];
        [list enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
            map[obj[@"MemberCode"]] = obj[@"MemberName"];
        }];
        LSFormSelectCell *cell = [self cellForName:@"memberCodeCell"];
        cell.selectMapper = map;
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
    }];
    [SVProgressHUD show];
    [connection startAsynchronous];
}
- (void)rightBarButtonDidPress:(UIBarButtonItem *)sender{
    if (_onComplete) {
        NSDictionary *data = self.formData;
        _onComplete(STRING_EMPTY_IF_NOT( data[@"memberCode"] ), STRING_EMPTY_IF_NOT( data[@"time"] ));
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 100)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = CGRectMake((DeviceWidth-194)/2, 60, 194, 40);
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
    if (_onComplete) {
        NSDictionary *data = self.formData;
        _onComplete(STRING_EMPTY_IF_NOT( data[@"memberCode"] ), STRING_EMPTY_IF_NOT( data[@"time"] ));
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.formMapper enumerateObjectsUsingBlock:^(NSDictionary* formSection, NSUInteger idx, BOOL *stop) {
        if (IS_ARRAY(formSection[LSFormTableMapperFormCellKey]))
        {
            //            LSFormCell *cell = self.cellsDict[ item[LSFormTableMapperCellNameKey] ]
            NSArray *formSectionCells = formSection[LSFormTableMapperFormCellKey];
            [formSectionCells enumerateObjectsUsingBlock:^(NSDictionary* cellMapper, NSUInteger idx, BOOL *stop) {
                LSFormCell *cell = self.cellsDict[ cellMapper[LSFormTableMapperCellNameKey] ];
                
                [cell resignFirstResponder];
                
            }
             ];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
