//
//  SampleListViewController.h
//  Xieshi
//
//  Created by 明溢 李 on 14-11-18.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SampleListViewController : XSViewController
@property(nonatomic,assign) IBOutlet UITableView *tableView;
@property(nonatomic,retain) NSString *keyId;
@property(nonatomic,retain) NSString *checksum;
@end
