//
//  LSDateNewActionSheet.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/29.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSDateNewActionSheet.h"

@interface LSDateNewActionSheet (){
    UIDatePicker   *_datePicker;
    NSTimeInterval  timeIntervalSelected;
}

@end


@implementation LSDateNewActionSheet
- (id)initWithTitle:(NSString *)title{
    self = [super initWithTitle:title andCostomView:nil];
    if (self) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.locale = locale;
         [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        self.costomView = _datePicker;
        
        NSDate *date = [NSDate date];
        timeIntervalSelected = [date timeIntervalSince1970];
        _datePicker.maximumDate = [NSDate date];
        dpBlockSelf;
        [super setOnConfirm:^BOOL{
            BOOL shouldClose = true;
            if (_self -> _blockSelectdDate) {
                shouldClose = _self -> _blockSelectdDate(timeIntervalSelected);
            }
            return shouldClose;
        }];
    }
    return self;
}

- (void)setOnConfirm:(BOOL (^)())onConfirm{
    LSWarning(@"warning:don't set on confirm,using on selected");
    return ;
}
- (void)showInView:(UIView *)view{
    _datePicker.frame = CGRectMake(0, 0, view.width, 180);
    [super showInView:view];
}
- (void)dateChanged:(id)sender{
    UIDatePicker *control = (UIDatePicker *)sender;
    NSDate *date = control.date;
//    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];
//    [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *dateString = [pickerFormatter stringFromDate:date];;
   timeIntervalSelected = [date timeIntervalSince1970];
    NSLog(@"date = %f",timeIntervalSelected);
}

@end
