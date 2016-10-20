//
//  VASamplePropertyNewListVCviewController.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/4.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSViewSecondController.h"

@interface VASamplePropertyNewListVCviewController : XSViewSecondController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView           *table;
@property(nonatomic,retain) NSArray *data;
@property (nonatomic,copy)NSString *stringBianHao;

@end
