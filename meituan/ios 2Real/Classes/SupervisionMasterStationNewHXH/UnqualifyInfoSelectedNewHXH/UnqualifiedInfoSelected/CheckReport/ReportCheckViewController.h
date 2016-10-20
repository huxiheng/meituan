//
//  ReportCheckViewController.h
//  Xieshi
//
//  Created by Tesiro on 16/7/13.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSViewController.h"


@interface ReportCheckViewController : XSViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain) NSDictionary *dataDic;
@property(nonatomic,retain) NSString *keyId;
@property(nonatomic,retain) NSString *checksum;
@property(nonatomic,retain) NSMutableArray *dataArray;
@property(nonatomic,strong) NSMutableArray *heightArray;

@end
