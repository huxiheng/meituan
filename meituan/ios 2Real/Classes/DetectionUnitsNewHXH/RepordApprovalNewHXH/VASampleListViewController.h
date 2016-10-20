//
//  SampleListViewController.h
//  Xieshi
//
//  Created by 明溢 李 on 14-11-18.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VASampleListViewController : XSViewSecondController
@property(nonatomic,assign) IBOutlet UITableView *tableView;
@property(nonatomic,retain) NSArray *list;
@end
