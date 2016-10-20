//
//  ProjectSearchViewController.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-15.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "LSFormTableViewController.h"

@interface ProjectSearchViewController : LSFormTableViewController
@property(nonatomic,copy) void(^onComplete)(NSString *memberCode,NSString *hour);

@end
