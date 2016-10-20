//
//  ApplyReportDetailNewViewController.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/4.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSViewSecondController.h"

@interface ApplyReportDetailNewViewController : XSViewSecondController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *table;
@property(nonatomic,retain) NSString *consignId;
@property (nonatomic, copy)NSDictionary *dataDic;
@property (nonatomic, strong)NSMutableArray *arrayCellData;

@end
