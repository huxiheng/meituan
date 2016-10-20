//
//  SampleSearchTableViewCell.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SampleSearchTableViewCell : UITableViewCell
{
    
    IBOutletCollection(UILabel) NSArray *_sampleLabels;
    
    __weak IBOutlet UILabel *_cellSampleNameLabel;

    __weak IBOutlet UILabel *cellGradeName;
    __weak IBOutlet UILabel *cellSpecName;
    
    __weak IBOutlet UILabel *cellProjectPart;
    __weak IBOutlet UILabel *cellDelegateQuan;
    __weak IBOutlet UILabel *_cellExamResultLabel;
    
    __weak IBOutlet UILabel *_cellDateLabel;
    __weak IBOutlet UILabel *_cellSampleStatusLabel;
}

+ (CGFloat)cellHeight;
@property(nonatomic,retain) NSDictionary *data;
@property(nonatomic,strong) NSIndexPath   *indexPathSampleSearch;
@property (weak, nonatomic) IBOutlet UIView *viewCellBGBig;
@property (weak, nonatomic) IBOutlet UIView *viewCellBGSecond;


@end
