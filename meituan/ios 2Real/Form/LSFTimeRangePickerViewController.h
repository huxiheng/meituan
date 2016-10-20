//
//  TimeRangePickerViewController.h
//  YinfengShop
//
//  Created by lessu on 13-12-22.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{
    LSFTimeRangePickerViewControllerTypeTime,
    LSFTimeRangePickerViewControllerTypeDate,
    LSFTimeRangePickerViewControllerTypeDateTime
}LSFTimeRangePickerViewControllerType;
@interface LSFTimeRangePickerViewController : XSViewSecondController

@property(nonatomic,copy) void(^onClose)();
@property(nonatomic,copy) void(^onConfirm)(NSTimeInterval startTime,NSTimeInterval endTime);

@property(nonatomic,assign,readwrite) NSTimeInterval startTimeInterval;
@property(nonatomic,assign,readwrite) NSTimeInterval endTimeInterval;
@property(nonatomic,assign) LSFTimeRangePickerViewControllerType type;
@end