//
//  SampleListTableViewCell.h
//  Xieshi
//
//  Created by 明溢 李 on 14-11-18.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSTableViewCell.h"

@interface SampleListTableViewCell : XSTableViewCell
@property(nonatomic,retain) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UILabel *sampleIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *sampleResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *sampleIdTitle;
@property (weak, nonatomic) IBOutlet UILabel *resultTitle;
+ (CGFloat)cellHeight;
@end
