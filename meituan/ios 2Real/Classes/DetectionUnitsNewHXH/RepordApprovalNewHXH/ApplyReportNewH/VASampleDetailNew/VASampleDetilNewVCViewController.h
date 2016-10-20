//
//  VASampleDetilNewVCViewController.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/4.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSViewSecondController.h"

@interface VASampleDetilNewVCViewController : XSViewSecondController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *table;
@property (nonatomic, copy)NSDictionary  *dicData;
@property (nonatomic, strong)NSMutableArray  *arrayData;

@end
