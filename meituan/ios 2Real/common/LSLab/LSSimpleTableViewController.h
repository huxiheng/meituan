//
//  LSSimpleTableViewController.h
//  LSLab
//
//  Created by Lessu on 13-5-9.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LSSimpleTableViewController : UITableViewController

@property(nonatomic,retain) NSArray *list;
@property(nonatomic,copy)   NSString *textName;
@property(nonatomic,copy)   NSString *detailName;


@property(nonatomic,copy) void(^onSelected)(NSDictionary *data,UITableViewCell *cell);
@property(nonatomic,assign) UITableViewCellStyle cellStyle;

@end
