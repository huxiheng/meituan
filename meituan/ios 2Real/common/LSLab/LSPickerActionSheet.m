//
//  LSPickerActionSheet.m
//  Yingfeng
//
//  Created by Lessu on 13-7-25.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSPickerActionSheet.h"
@interface LSPickerActionSheet()
{
    UIPickerView *_pickerView;
}
@end

@implementation LSPickerActionSheet

- (id)initWithTitle:(NSString *)title andList:(NSArray *)list
{
    self = [super initWithTitle:title andCostomView:nil];
    if (self) {
        COPY_ASSIGN(_list, list);

        _pickerView = [[UIPickerView alloc]init];
        _pickerView .delegate = self;
        _pickerView .dataSource = self;
        _pickerView .showsSelectionIndicator = YES;

        self.costomView = _pickerView;
        __block typeof(self) bSelf = self;
        [super setOnConfirm:^BOOL{
            int index = [bSelf -> _pickerView selectedRowInComponent:0];
            BOOL shouldClose = true;
            if (bSelf -> _onSelected) {
                shouldClose = bSelf -> _onSelected(index);
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
    _pickerView.frame = CGRectMake(0, 0, view.width, 180);
    [super showInView:view];
}
- (void)dealloc
{
    Block_release(_onSelected);
    [_pickerView release];
    [_list release];
    [super dealloc];
}
- (void)setList:(NSArray *)list{
    _list = list;
    [_pickerView reloadAllComponents];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _list.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _list[row];
}
@end
