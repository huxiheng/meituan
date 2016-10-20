//
//  SampleSearchListViewController.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-25.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "LSPagedTableViewController.h"

@interface SampleSearchListViewController : LSPagedTableViewController
@property(nonatomic,retain) NSString* signNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelSaoMiao;
@property (weak, nonatomic) IBOutlet UIView *viewScanningBarCode;
@property (weak, nonatomic) IBOutlet UIView *viewScanningBarCodeInside;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewXuXianLine;
@property (weak, nonatomic) IBOutlet UIButton *btnCodeScanning;


@end
