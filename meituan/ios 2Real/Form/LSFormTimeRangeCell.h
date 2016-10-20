//
//  LSFormTimeRangeCell.h
//  YinfengShop
//
//  Created by lessu on 13-12-24.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFormCell.h"
#import "LSFTimeRangePickerViewController.h"

#define TimeRangeCell(__key,__label) [LSFormTimeRangeCell mapperWithCellName:CellNameKeyed(__key) keyName:__key label:__label]

//data = @[@"00:00",@"12:00"]
@interface LSFormTimeRangeCell : LSFormCell

@property(nonatomic,retain) NSDate* startDate;
@property(nonatomic,retain) NSDate *endDate ;
//HH:ss
@property(nonatomic,retain) NSString *dateFormat;
@property(nonatomic,assign) LSFTimeRangePickerViewControllerType type;
+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label;

@end
