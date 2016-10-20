//
//  VerifyDetailNewHViewController.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/5.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSViewSecondController.h"

@interface VerifyDetailNewHViewController : XSViewSecondController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView        *table;
@property(nonatomic,retain) NSString        *consignId;
@property (nonatomic,strong)NSMutableArray  *arrayData;
@property (nonatomic,strong)NSDictionary    *dataDic;


@end
