//
//  TodaySearchViewController.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-3-18.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSFormTableViewController.h"

@interface TodaySearchViewController : LSFormTableViewController
@property(nonatomic,copy) void (^onComplete)(NSString *projectName,NSString *projectArea,NSString * BuildingReportNumber,NSString* BuildUnitName,NSString * ConstructUnitName,NSString* SuperviseUnitName,NSString * DetectionUnitName);
@end
