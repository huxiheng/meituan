//
//  WorkSiteListViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "WorkSiteListViewController.h"
#import "WorkSiteTableViewCell.h"
#import "AgreementListViewController.h"
#import "WorkSiteSearchViewController.h"
#import "AppDelegate.h"
@interface WorkSiteListViewController ()
@property(nonatomic,retain) WorkSiteSearchViewController *searchController;
@end

@implementation WorkSiteListViewController

- (void)setdataForNav {
    self.titleForNav = @"工地列表";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loadOnlyOnce = true;
    self.pageController.pageName = @"CurrentPageNo";
    self.pageController.stepName = @"PageSize";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_navigation_search"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDidPress:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_navigation_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonDidPress:)];
    self.navigationItem.leftBarButtonItem = barButton;

}
- (void)leftBarButtonDidPress:(UIBarButtonItem *)sender{
    [APP_DELEGATE.rootMainViewController showLeft];
    
}
- (void)rightBarButtonDidPress:(UIBarButtonItem *)sender{

    if (!_searchController) {
        _searchController = [[WorkSiteSearchViewController alloc]init];
    }
    [self.navigationController pushViewController:_searchController animated:YES];
    weakAlias(wSelf, self);
    [_searchController setOnComplete:^(BOOL isComplete, NSString *keyword) {
        NSMutableDictionary *params = [wSelf.pageController.apiParams mutableCopy];
        params[@"QueryStr"] = STRING_EMPTY_IF_NOT(keyword);
        params[@"NotFinishedOnly"] = isComplete ? [NSNumber numberWithBool:true] : [NSNumber numberWithBool:false];
        
        wSelf.pageController.apiParams = params;
        
        [wSelf.pageController refreshNoMerge];
        [wSelf.navigationController popToRootViewControllerAnimated:YES];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//to Implement
- (void)toInitPageControllerWith:(NSString **) apiName params:(NSDictionary **)params{
    *apiName = APIMETHOD_SM_ProjectList;
    *params  =  @{
                  @"Token"              : [LoginUtil token],
                  @"NotFinishedOnly"    : [NSNumber numberWithBool:true],
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

- (void)        simpleTableView:(UITableView *)tableView fillCell:(WorkSiteTableViewCell *)cell withData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath{
    cell.data = item;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (NSString *)  simpleTableViewCellNibName:(UITableView *)tableView{
    return @"WorkSiteTableViewCell";
}
- (CGFloat)     simpleTableView:(UITableView *)tableView cellHeightForData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath;{
    return [WorkSiteTableViewCell cellHeight];   
}
- (void)        simpleTableView:(UITableView *)tableView didSelectedWithData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath{
    AgreementListViewController *controller = [[AgreementListViewController alloc]init];
    controller.projectId = item[@"ProjectId"];
    [self.navigationController pushViewController:controller animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


@end
