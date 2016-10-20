//
//  SampleInfoViewController.m
//  Xieshi
//
//  Created by Tesiro on 16/7/14.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "SampleInfoViewController.h"
#import "NSObject+SBJSON.h"
#import "SampleInfoHeaderView.h"
#import "SampleInfoFooterView.h"
#import "SampleInfoTableViewCell.h"


#import "BlockUI.h"
#import "LSFTextInputViewController.h"

@interface SampleInfoViewController ()
@property (nonatomic, strong)UITableView     *table;
@property (nonatomic, strong)NSMutableArray         *arrayData;
@property (nonatomic, strong)NSMutableArray *arrayHeight;

@end

@implementation SampleInfoViewController

- (void)setData {
    self.titleForNav = @"样品信息";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:kcolorBJ_f0eff4];
    [self setSubviews];
    
    [self setNavRightItemWith:@"处理" andImage:nil];
    
}

- (void)getRequestDataARRAY{
    self.arrayData = [[NSMutableArray alloc] initWithCapacity:0];
    self.arrayHeight = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray *arrayTitle = @[@"样品名称",@"代表数量",@"委托编号",@"检测项目",@"规格",@"强度",@"参数",@"标示号区间",@"备案证号",@"生产厂家",@"工程部位"];
    NSArray *arrayContent = [[NSMutableArray alloc] initWithObjects:_dicData[@"SampleName"],_dicData[@"Delegate_Quan" ],_dicData[@"ConSign_ID"],_dicData[@"ItemName"],_dicData[@"Spec_Cn"],_dicData[@"Grade_Cn"],_dicData[@"Exam_parameter_Cn"],_dicData[@"BsNO"],_dicData[@"Record_Certificate"],_dicData[@"Produce_Factory"],_dicData[@"ProJect_Part"], nil];
    for (int i=0; i<arrayTitle.count; i++) {
        XSCellModel *xscellModel = [[XSCellModel alloc] init];
        xscellModel.title = arrayTitle[i];
        xscellModel.content = arrayContent[i];
        
        
        NSString *stringShow = [NSString stringWithFormat:@"%@ : %@",arrayTitle[i],arrayContent[i]];
        xscellModel.heightcontent = [NSString calculateTextHeight:DeviceWidth-34 Content:stringShow font:themeFont(12)];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic = [self returndicWithHeight:stringShow];
        [self.arrayHeight addObject:dic];
        
        if (i%2==0) {
            xscellModel.tagColor = YES;
        }else {
            xscellModel.tagColor = NO;
        }
        [self.arrayData addObject:xscellModel];
    }
    
}

- (NSMutableDictionary *)returndicWithHeight:(NSString *)str{
    CGFloat cellHeight =0;
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    CGFloat contentWidth = DeviceWidth-34;
    CGSize constraint = CGSizeMake(contentWidth, 20000.0f);
    CGSize size1 = [str sizeWithFont:themeFont(12) constrainedToSize:constraint];
    CGFloat heightContent = ceil(size1.height);
    if (heightContent>20) {
        dic2[@"height"]=@"51";
    }else{
        dic2[@"height"]=@"32";
    }
    return dic2;
}

- (void)setSubviews{
    self.view.backgroundColor = [UIColor colorWithHexString:kcolorBJ_f0eff4];
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64) style:UITableViewStylePlain];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.delegate = self;
    self.table.dataSource = self;
//    self.table.rowHeight = 41;
    [self.view addSubview:self.table];
    
    [self.table registerClass:[SampleInfoTableViewCell class] forCellReuseIdentifier:[SampleInfoTableViewCell cellIdentifier]];
    
    NSDictionary *params = @{
                             @"Report_id":_reportId,
                             @"Checksum":_checksum,
                             @"Sample_id":_sampleId,
                             @"Token"    :[LoginUtil token]
                             };
    APIConnection *connection = [[CommonAPI sharedInstance]connectionWithApiName:APIMETHOD_UQ_SampleDetail params:params];
    [connection setOnSuccess:^(id result) {
                self.dicData= result[kAPIConnectionStandartDataKey];
                [self getRequestDataARRAY];
                [self.table reloadData];
        
                ///根据内容适应行高
                NSString *stringReport = [NSString stringWithFormat:@"检测结果:%@",self.dicData[@"Exam_Result"]];
                CGFloat reportHeight = [NSString calculateTextHeight:DeviceWidth-34 Content:stringReport font:themeFont(17)];
                NSDictionary *dicReport = @{@"dataMessage":self.dicData,@"height":[NSString stringWithFormat:@"%f",reportHeight]};
        
                SampleInfoHeaderView *sampleHeaderView = [[SampleInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 92)];
                [sampleHeaderView reloadDataForView:dicReport];
                self.table.tableHeaderView = sampleHeaderView;
        
                SampleInfoFooterView *sampleFotterView = [[SampleInfoFooterView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 68)];
                [sampleFotterView reloadDataForView:self.dicData];
                self.table.tableFooterView = sampleFotterView;
        [SVProgressHUD dismiss];
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
    }];
    [SVProgressHUD show];
    [connection startAsynchronous];
        
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SampleInfoTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:[SampleInfoTableViewCell cellIdentifier]];
    id model = [self.arrayData objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell reloadDataForCell:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [((NSDictionary *)[self.arrayHeight objectAtIndex:indexPath.row])[@"height"] intValue];
}

- (void)rightItemClick:(id)sender{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"操作" message:@"请选择操作" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"已处理",@"处理中" ,nil];
    [alertView showWithCompletionHandler:^(NSInteger buttonIndex) {
        NSString *uqExecStatus ;
        switch (buttonIndex) {
            case 1:
                uqExecStatus = @"1";
                break;
            case 2:
                uqExecStatus = @"2";
                break;
            case 0:
                return ;
            default:
                uqExecStatus = @"2";
                break;
        }
        LSFTextInputViewController *controller = [[LSFTextInputViewController alloc]init];
        controller.text = _dicData[@"ExecContent"];
        controller.title = @"处理信息";
        [controller setOnComplete:^(NSString *text) {
            if (text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入处理信息"];
            }
            NSDictionary *params = @{
                                     @"UqSampleID"      : _dicData[@"UqSampleID"],
                                     @"ExecContent"     : text,
                                     @"UqExecStatus"    : uqExecStatus,
                                     @"Token"           : [LoginUtil token]
                                     };
            APIConnection *connection = [[CommonAPI sharedInstance]connectionWithApiName:APIMETHOD_UQ_SampleExec params:params];
            [connection setOnSuccess:^(id result) {
                [self.navigationController popViewControllerAnimated:YES];
                [SVProgressHUD dismissWithSuccess:@"处理成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [connection setOnFailed:^(NSError *error) {
                NSString *errorDescription = [error localizedDescription];
                [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
            }];
            [SVProgressHUD show];
            [connection startAsynchronous];
            
        }];
        [self.navigationController pushViewController:controller animated:YES];
    }];
}

@end
