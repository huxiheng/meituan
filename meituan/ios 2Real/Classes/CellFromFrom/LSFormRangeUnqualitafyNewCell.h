//
//  LSFormRangeUnqualitafyNewCell.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/29.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSFormCell.h"
#import "LSFTimeRangePickerViewController.h"

#define TimeRangeNewCell(__key,__label) [LSFormRangeUnqualitafyNewCell mapperWithCellName:CellNameKeyed(__key) keyName:__key label:__label]
@interface LSFormRangeUnqualitafyNewCell : LSFormCell{
    NSTimeInterval  startInterval;
    NSTimeInterval  endInterval;
    CGFloat heightViewCell;
}

@property (nonatomic, strong)UIView         *viewBG;
@property (nonatomic, strong)UILabel        *labelTitle;
@property (nonatomic, strong)UILabel        *labelContent;
@property (nonatomic, strong)UIView         *viewLineBottom;

@property (nonatomic, copy)NSString         *strTitle;


@property(nonatomic,retain) NSDate* startDate;
@property(nonatomic,retain) NSDate *endDate ;
//HH:ss
@property(nonatomic,retain) NSString *dateFormat;
@property(nonatomic,assign) LSFTimeRangePickerViewControllerType type;
+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label;

@end
