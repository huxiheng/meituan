//
//  TimeRangePickerViewController.m
//  YinfengShop
//
//  Created by lessu on 13-12-22.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFTimeRangePickerViewController.h"



@interface LSFTimeRangePickerViewController()
{
    __weak IBOutlet UIDatePicker *_startDatePicker;
    __weak IBOutlet UIDatePicker *_endDatePicker;
}

@end
@implementation LSFTimeRangePickerViewController
@synthesize startTimeInterval   = _startTimeInterval;
@synthesize endTimeInterval     = _endTimeInterval;

- (void)setData {
    self.titleForNav = @"时间选择";
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    IOS7_LAYOUT_FIX;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUpNavi];

    self.startTimeInterval = _startTimeInterval;
    self.endTimeInterval   = _endTimeInterval;

}
- (IBAction)closeButtonPressed:(id)sender {
    if (_onClose) {
        _onClose();
    }
}
- (IBAction)confirmButtonPressed:(id)sender {
    if (_onConfirm) {
        _onConfirm(self.startTimeInterval,self.endTimeInterval);
    }
}
- (void)setUpNavi{
   
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirmButtonPressed:)];
    self.navigationItem.rightBarButtonItem = barButton;
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonPressed:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;

}
- (NSTimeInterval)startTimeInterval{
    return [_startDatePicker.date timeIntervalSince1970];
}

- (NSTimeInterval)endTimeInterval{
    return [_endDatePicker.date timeIntervalSince1970];
    
}

- (void)setStartTimeInterval:(NSTimeInterval)startTimeInterval{
    _startTimeInterval = startTimeInterval;
    if (startTimeInterval  !=0) {
        _startDatePicker.date = [NSDate dateWithTimeIntervalSince1970:startTimeInterval];
    }
}

- (void)setEndTimeInterval:(NSTimeInterval)endTimeInterval{
    _endTimeInterval = endTimeInterval;
    if (_endTimeInterval  !=0) {
        _endDatePicker.date = [NSDate dateWithTimeIntervalSince1970:endTimeInterval];
    }
}

- (void)setType:(LSFTimeRangePickerViewControllerType)type{
    switch (type) {
        case LSFTimeRangePickerViewControllerTypeDate:
            _startDatePicker.datePickerMode = UIDatePickerModeDate;
            _endDatePicker.datePickerMode = UIDatePickerModeDate;
            break;
        case LSFTimeRangePickerViewControllerTypeTime:
            _startDatePicker.datePickerMode = UIDatePickerModeTime;
            _endDatePicker.datePickerMode = UIDatePickerModeTime;
            break;
        case LSFTimeRangePickerViewControllerTypeDateTime:
            _startDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
            _endDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
            break;
            
        default:
            break;
    }
}
@end
