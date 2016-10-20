//
//  SampleSearchViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-14.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "WorkSiteSearchViewController.h"
#import "LSFormTextFieldCell.h"
#import "LSFormSelectCell.h"
#import "LSFormSwitchCell.h"
#import "LSFormTextFieldNewCell.h"
#import "LSFormSwitchNewCell.h"
#import "LSForm.h"

@interface WorkSiteSearchViewController ()

@end

@implementation WorkSiteSearchViewController

//- (void)setDatawithNavTitle {
//    self.titleForNav = @"样品搜索";
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"样品搜索";
    self.labelNavTitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 160, 44)];
    self.labelNavTitle.text = @"样品搜索";
    self.labelNavTitle.textColor = [UIColor whiteColor];
    self.labelNavTitle.textAlignment = NSTextAlignmentCenter;
    self.labelNavTitle.font = [UIFont systemFontOfSize:15];
    self.navigationItem.titleView = self.labelNavTitle;
    
    if (_completeLabelText == NULL) {
        _completeLabelText = @"不包括作废样品";
    }
    #define TextLabelCellCanEdit(__key,__label) [LSFormTextLabelCell mapperWithCellName:CellNameKeyed(__key) keyName:__key label:__label andCanEdit:YES]
    self.formMapper = @[
                        formTableViewFormMapper(@[
                                                  TextFieldNewCell(@"keyword", @"关键词"),
                                    
                                                   SwitchNewCell(@"isClick", @"是否仅显示未完工的工地"),
                                                  
                                                  ])
                        ];
//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDidPress:)];
//    self.navigationItem.rightBarButtonItem = barButton;
    

}
- (void)rightBarButtonDidPress:(UIBarButtonItem *)sender{
    NSDictionary *data = self.formData;
    
    if (_onComplete) {
        _onComplete([data[@"isClick"] boolValue],data[@"keyword"]);
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
    NSDictionary *data = self.formData;
    
    if (_onComplete) {
        _onComplete([data[@"isClick"] boolValue],data[@"keyword"]);
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
