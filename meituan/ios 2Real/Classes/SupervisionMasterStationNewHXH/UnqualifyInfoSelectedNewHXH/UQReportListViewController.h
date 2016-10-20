//
//  ReportListViewController.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "LSPagedTableViewController.h"

@interface UQReportListViewController : LSPagedTableViewController
@property(nonatomic,retain) NSDictionary *params;
@property(nonatomic,assign) BOOL isProjectType;
@end
