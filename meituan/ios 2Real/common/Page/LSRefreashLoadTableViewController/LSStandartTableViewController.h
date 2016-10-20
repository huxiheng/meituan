//
//  LSStandartTableViewController.h
//  Yingcheng
//
//  Created by lessu on 14-2-19.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSTableViewCell.h"
@interface LSStandartTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak)   IBOutlet UITableView *tableView;
@property(nonatomic,strong) Class        cellClass;
@property(nonatomic,strong) NSArray*     list;
@property(nonatomic,strong) NSString *reuseIdentifier;

@end
