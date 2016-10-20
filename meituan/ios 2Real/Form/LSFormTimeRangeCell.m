//
//  LSFormTimeRangeCell.m
//  YinfengShop
//
//  Created by lessu on 13-12-24.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFormTimeRangeCell.h"
#import "LSFTimeRangePickerViewController.h"
#import "LSFormTableViewController.h"
@implementation LSFormTimeRangeCell

- (void)onInitWithLabel:(NSString *)label value:(id)value andRule:(NSDictionary *)rule{
    self.textLabel.text         = label;
    self.detailTextLabel.text   = @" ";
    self.detailTextLabel.text   = STRING_EMPTY_IF_NULL(value);
    _dateFormat = @"HH:mm";
}

- (CGFloat)cellHeight{
    return 44;
}

- (void)setData:(NSArray *)data{
    NSAssert(IS_ARRAY(data), @"data must be an array");

    _data = data;
    self.detailTextLabel.text   = STRING_FORMAT(@"%@-%@",data[0],data[1]);
    
    static NSDateFormatter *formatter;
    if (formatter == NULL) {
        formatter= [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
    }
    _startDate = [formatter dateFromString:data[0]];
    _endDate   = [formatter dateFromString:data[1]];
}

- (void)onSelected:(LSFormTableViewController *)viewController complete:(void (^)())onComplete{
    LSFTimeRangePickerViewController *controller = [[LSFTimeRangePickerViewController alloc]init];
    VIEW_CONTROLLER_LOAD(controller);
    [viewController presentModalViewController:wrapNavigationController(controller) animated:YES];
    
    controller.title = @"选择时间";
    controller.type = _type;
    [controller setOnClose:^{
        [viewController dismissViewControllerAnimated:YES completion:0];
    }];

    [controller setOnConfirm:^(NSTimeInterval start, NSTimeInterval end) {
        if (start>end) {
            [LSDialog showMessage:@"开始时间需要小于结束时间"];
            return ;
        }
        self.data = @[timeStringOfTimeIntervalWithFormat(start, _dateFormat),
                      timeStringOfTimeIntervalWithFormat(end  , _dateFormat)
                      ];
        if ([self.delegate respondsToSelector:@selector(cell:valuedChanged:)]) {
            [self.delegate cell:self valuedChanged:self.data];
        }
        [viewController dismissViewControllerAnimated:YES completion:^{
            onComplete();
        }];
        
//        NSLog(@"%@",timeStringOfTimeIntervalWithFormat(start,@"yyyy/MM/dd"));

    }];
    UNUSED_VAR(controller.view);
    controller.startTimeInterval = [_startDate timeIntervalSince1970];
    controller.endTimeInterval   = [_endDate   timeIntervalSince1970];
}


+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label{
    return [LSFormCell mapperWithClassName:@"TimeRange" cellName:cellName keyName:keyName label:label value:nil andRule:@{LSFormCellRuleCellStyleKey:@(UITableViewCellStyleValue1)}];
}
@end
