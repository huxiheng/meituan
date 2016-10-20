//
//  WorkSiteSampleDetailViewController.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-14.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "TemplatedWebViewController.h"

@interface WorkSiteSampleDetailViewController : TemplatedWebViewController
@property(nonatomic,strong) NSDictionary *data;
@property(nonatomic,assign) BOOL isQRDetail;
@property(nonatomic,retain) NSString *qrcode;
@end
