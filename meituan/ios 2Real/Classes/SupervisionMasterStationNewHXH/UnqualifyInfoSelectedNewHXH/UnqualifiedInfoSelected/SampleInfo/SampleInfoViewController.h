//
//  SampleInfoViewController.h
//  Xieshi
//
//  Created by Tesiro on 16/7/14.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSViewController.h"

@interface SampleInfoViewController : XSViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain) NSString *reportId;
@property(nonatomic,retain) NSString *checksum;
@property(nonatomic,retain) NSString *sampleId;
@property(nonatomic,strong) NSDictionary *dicData;
@end
