//
//  WorkSiteSampleInfoViewController.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/25.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSViewController.h"

@interface WorkSiteSampleInfoViewController : XSViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSDictionary *dataDic;
@property(nonatomic,assign) BOOL isQRDetail;
@property(nonatomic,retain) NSString *qrcode;

@property (nonatomic,strong)NSMutableArray *arrayData;

@property (nonatomic,strong)UITableView *table;

@end
