//
//  WorkSiteSampleNewVCController.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/2.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSViewSecondController.h"

@interface WorkSiteSampleNewVCController : XSViewSecondController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *table;
@property (nonatomic, copy)NSDictionary  *dicData;
@property (nonatomic, strong)NSMutableArray *arrayDataNew;
@property (nonatomic, copy)NSString        *qrcode;
@end
