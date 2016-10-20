//
//  LSFormTextLabelCell.m
//  YinfengShop
//
//  Created by lessu on 13-12-23.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFormTextLabelCell.h"
#import "LSForm.h"
#import "LSFTextInputViewController.h"
#import "LSFormTableViewController.h"
NSString * LSFormTextLabelCellRuleCanEditKey    = @"canEdit";
NSString * LSFormTextLabelCellRuleKeyboardKey   = @"keyboard";

@implementation LSFormTextLabelCell

- (void)onInitWithLabel:(NSString *)label value:(NSString *)value andRule:(NSDictionary *)rule{
    self.textLabel.text         = label;
    self.data                   = value;
//    self.detailTextLabel.text   = value;
    if([rule[LSFormTextLabelCellRuleCanEditKey] boolValue]){
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [self setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }else{
        [self setAccessoryType:UITableViewCellAccessoryNone];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
}

- (void)setData:(NSString *)data{
    _data = data;
    if (IS_STRING(data)) {
        self.detailTextLabel.text = data;
    }
}

- (void)onSelected:(LSFormTableViewController *)viewController complete:(void (^)())onComplete{
    NSDictionary *rule = _mapper[LSFormTableMapperCellRuleKey];
    if([rule[LSFormTextLabelCellRuleCanEditKey] boolValue]){
        LSFTextInputViewController *controller = [[LSFTextInputViewController alloc]initWithString:self.detailTextLabel.text OnCompleteBlock:^(NSString *text) {
            self.data = text;
            if (onComplete) {
                onComplete();
            }
            [viewController.navigationController popViewControllerAnimated:YES];
            if ([self.delegate respondsToSelector:@selector(cell:valuedChanged:)]) {
                [self.delegate cell:self valuedChanged:self.data];
            }
        }];
        [viewController.navigationController pushViewController:controller animated:YES];
        UNUSED_VAR(controller.view);
        controller.title = self.textLabel.text;
        controller.inputView.keyboardType = [rule[LSFormTextLabelCellRuleKeyboardKey] floatValue];

    }else{
        if (onComplete) {
            onComplete();
        }
    }
}

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label andCanEdit:(BOOL)canEdit{
    return [LSFormCell mapperWithClassName:@"TextLabel" cellName:cellName keyName:keyName label:label value:nil andRule:[LSFormTextLabelCell ruleWithCanEdit:canEdit keyboardType:UIKeyboardTypeDefault cellStyle:UITableViewCellStyleValue1]];
}
+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label andCanEdit:(BOOL)canEdit cellStyle:(UITableViewCellStyle)style{
    return [LSFormCell mapperWithClassName:@"TextLabel" cellName:cellName keyName:keyName label:label value:nil andRule:[LSFormTextLabelCell ruleWithCanEdit:canEdit keyboardType:UIKeyboardTypeDefault cellStyle:style]];
}

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label andCanEdit:(BOOL)canEdit keyboardType:(UIKeyboardType)keyboardType cellStyle:(UITableViewCellStyle)style{
    return [LSFormCell mapperWithClassName:@"TextLabel" cellName:cellName keyName:keyName label:label value:nil andRule:[LSFormTextLabelCell ruleWithCanEdit:canEdit keyboardType:keyboardType cellStyle:style]];
}
+ (NSDictionary *)ruleWithCanEdit:(BOOL)canEdit keyboardType:(UIKeyboardType)keyboard cellStyle:(UITableViewCellStyle)style{
    return @{
             LSFormCellRuleCellStyleKey       : @(style),
             LSFormTextLabelCellRuleCanEditKey : @(canEdit),
             LSFormTextLabelCellRuleKeyboardKey: @(keyboard),
             };
}
@end

