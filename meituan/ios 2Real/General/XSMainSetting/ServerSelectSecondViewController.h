//
//  ServerSelectSecondViewController.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/26.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSViewSecondController.h"
#define CNNET_SERVER_URL @"www.scetia.com"
#define UNION_SERVER_URL @"www.schetia.com"
@interface ServerSelectSecondViewController : XSViewSecondController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView      *table;
@property (nonatomic, strong)NSMutableArray   *arrayData;
@property (nonatomic, assign)BOOL               isFirst;

@end
