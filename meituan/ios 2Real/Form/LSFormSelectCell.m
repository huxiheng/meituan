//
//  LSFormSelectCell.m
//  YinfengShop
//
//  Created by lessu on 13-12-25.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFormSelectCell.h"
#import "LSPickerActionSheet.h"
#import "LSFormTableViewController.h"
#import "LSForm.h"
@interface LSFormSelectCell()
@property(nonatomic,retain) NSDictionary *mapper;
@end
NSString *LSFormSelectCellRuleMapperKey = @"mapper";
@implementation LSFormSelectCell
- (void)onInitWithLabel:(NSString *)label value:(id)value andRule:(NSDictionary *)rule{
    self.textLabel.text = label;
    NSAssert(IS_DICTIONARY(rule[LSFormSelectCellRuleMapperKey]), @"mapper 必须是 dictionary");
    self.selectMapper = rule[LSFormSelectCellRuleMapperKey];
}
- (CGFloat)cellHeight{
    return 44;
}
- (void)setData:(NSString *)data{
    _data = data;
    if (data == NULL) {
        self.detailTextLabel.text = NULL;
    }else{
        self.detailTextLabel.text = self.selectMapper[data];
    }
}
- (id)data{
    return _data;
}

- (void)setSelectMapper:(NSDictionary *)selectMapper{
    _selectMapper = selectMapper;
    self.data = NULL;
}


- (void)onSelected:(LSFormTableViewController *)viewController complete:(void (^)())onComplete{
    
    NSArray *list = [self.selectMapper allValues] ;
    list = [list sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
        return [obj1 floatValue] > [obj2 floatValue];
    }];
    LSPickerActionSheet *pickerActionSheet = [[LSPickerActionSheet alloc]initWithTitle:self.mapper[LSFormTableMapperCellLabelKey] andList:list];
    [pickerActionSheet setOnSelected:^BOOL(int index) {
        if ([self.selectMapper allKeys].count == 0) {
            return true;
        }
        NSString* value = list[index];
        NSInteger valueIndex = [[self.selectMapper allValues] indexOfObject:value];
        self.data = [self.selectMapper allKeys][valueIndex];
        if ([self.delegate respondsToSelector:@selector(cell:valuedChanged:)]) {
            [self.delegate cell:self valuedChanged:self.data];
        }
        onComplete();
        return true;
    }];
    [pickerActionSheet setOnCancel:^BOOL{
        onComplete();
        return true;
    }];
    [pickerActionSheet showInView:viewController.view.window];
}

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label andMapper:(NSDictionary *)mapper{
    return [LSFormCell mapperWithClassName:@"Select" 
                                  cellName:cellName 
                                   keyName:keyName   
                                     label:label 
                                     value:nil 
                                   andRule:@{
                                             LSFormCellRuleCellStyleKey     : @(UITableViewCellStyleValue1),
                                             LSFormCellRuleAccessoryTypeKey : @(UITableViewCellAccessoryDisclosureIndicator),
                                             LSFormSelectCellRuleMapperKey  : mapper
                                             }
            ];
}


@end
