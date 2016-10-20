//
//  SampleSearchViewController.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-14.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "LSFormTableViewController.h"

@interface WorkSiteSearchViewController : LSFormTableViewController
@property(nonatomic,copy) void(^onComplete)(BOOL isComplete,NSString* keyword);
@property(nonatomic,retain) NSString *completeLabelText;
@end
