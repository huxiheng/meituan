//
//  SampleListTableViewCell.h
//  Xieshi
//
//  Created by 明溢 李 on 14-11-18.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UQSampleListTableViewCell : UITableViewCell
@property(nonatomic,retain) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UILabel *sampleIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *sampleResultLabel;
+ (CGFloat)cellHeight;
@end
