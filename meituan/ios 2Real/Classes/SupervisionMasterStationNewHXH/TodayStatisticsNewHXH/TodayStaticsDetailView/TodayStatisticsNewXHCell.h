//
//  TodayStatisticsNewXHCell.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/22.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSTableViewCell.h"

@interface TodayStatisticsNewXHCell : XSTableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewBG;
@property (weak, nonatomic) IBOutlet UIView *viewBGSecond;
@property (weak, nonatomic) IBOutlet UILabel *labalSuperProject;
@property (weak, nonatomic) IBOutlet UILabel *labalDelegateSample;
@property (weak, nonatomic) IBOutlet UILabel *labelSuperSample;
@property (weak, nonatomic) IBOutlet UILabel *labelUnqualifySample;

@property (nonatomic, strong)NSDictionary *data;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewBottomLine;

@end
