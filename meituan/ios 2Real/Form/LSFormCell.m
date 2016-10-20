//
//  LSFormCell.m
//  YinfengShop
//
//  Created by lessu on 13-12-23.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//
//extern NSString     *LSFormCellEmptyString;
//extern NSDictionary *LSFormCellEmptyDictionary;
//extern NSArray      *LSFormCellEmptyArray;

#import "LSFormCell.h"
#import "LSForm.h"
#import "LSFormTableViewController.h"
NSString *LSFormCellRuleCellStyleKey                = @"cellStyle";
NSString *LSFormCellRuleAccessoryTypeKey            = @"accessoryType";


@implementation LSFormCell
@dynamic cellName;
- (instancetype)initWithMapper:(NSDictionary *)mapper{
    NSString *reuseIdentify = nil;
    NSDictionary *rule = DICTIONARY_EMPTY_IF_NOT(mapper[LSFormTableMapperCellRuleKey]);
    if (mapper[LSFormTableMapperCellNameKey]){
        reuseIdentify = mapper[LSFormTableMapperCellNameKey];
    }

    self = [super initWithStyle:[rule[LSFormCellRuleCellStyleKey] integerValue] reuseIdentifier:reuseIdentify];
    if (self) {
        self.accessoryType = [rule[LSFormCellRuleAccessoryTypeKey] integerValue];
        self.mapper = mapper;
        [self onInitWithLabel:mapper[LSFormTableMapperCellLabelKey] value:mapper[LSFormTableMapperCellValueKey] andRule:mapper[LSFormTableMapperCellRuleKey]];
    }
    return self;
}
- (void)onInitWithLabel:(NSString *)label value:(NSString *)value andRule:(NSDictionary *)rule{
    
}


- (void)onSelected:(LSFormTableViewController *)viewController complete:(void (^)())onComplete{
    if(onComplete){
        onComplete();
    }
}

- (CGFloat)cellHeight{
    return 44;
}
#pragma mark getter/setter
- (NSString *)cellName{
    return _mapper[LSFormTableMapperCellNameKey];
}

+ (NSDictionary *)mapperWithClassName:(NSString *)className cellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label value:(NSString *)value andRule:(NSDictionary*)rule andDateType:(NSString * )type{
    @try {
        NSMutableDictionary* ret = [NSMutableDictionary dictionary];
        if (className) {
            ret[LSFormTableMapperCellClassKey]  = className;
        }
        if (cellName) {
            ret[LSFormTableMapperCellNameKey]   = cellName;
        }
        if (keyName) {
            ret[LSFormTableMapperCellKeyNameKey]= keyName;
        }
        if (label) {
            ret[LSFormTableMapperCellLabelKey]  = label;
        }
        if (value) {
            ret[LSFormTableMapperCellValueKey]  = value;
        }
        if (rule) {
            ret[LSFormTableMapperCellRuleKey]   = rule;
        }
        if (type) {
//            ret[LSFormTableMapperCellTypeNewKey]   = type;
        }
        
        return ret;
    }
    @catch (NSException *exception) {
        NSLog(@"mapper create error");
        NSDictionary* ret = @{
                              LSFormTableMapperCellClassKey  : @"TextLabel",
                              LSFormTableMapperCellNameKey   : @"TextLabelError",
                              LSFormTableMapperCellKeyNameKey: @"",
                              LSFormTableMapperCellLabelKey  : @"错误的Mapper数据",
                              LSFormTableMapperCellRuleKey   : @{}
                              };
        return ret;
    }
}

+ (NSDictionary *)mapperWithClassName:(NSString *)className cellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label value:(NSString *)value andRule:(NSDictionary*)rule andHeight:(NSString *)height{
    @try {
        NSMutableDictionary* ret = [NSMutableDictionary dictionary];
        if (className) {
            ret[LSFormTableMapperCellClassKey]  = className;
        }
        if (cellName) {
            ret[LSFormTableMapperCellNameKey]   = cellName;
        }
        if (keyName) {
            ret[LSFormTableMapperCellKeyNameKey]= keyName;
        }
        if (label) {
            ret[LSFormTableMapperCellLabelKey]  = label;
        }
        if (value) {
            ret[LSFormTableMapperCellValueKey]  = value;
        }
        if (rule) {
            ret[LSFormTableMapperCellRuleKey]   = rule;
        }
        if (height) {
            ret[LSFormTableMapperCellHeightNewKey]   = height;
        }
        
        return ret;
    }
    @catch (NSException *exception) {
        NSLog(@"mapper create error");
        NSDictionary* ret = @{
                              LSFormTableMapperCellClassKey  : @"TextLabel",
                              LSFormTableMapperCellNameKey   : @"TextLabelError",
                              LSFormTableMapperCellKeyNameKey: @"",
                              LSFormTableMapperCellLabelKey  : @"错误的Mapper数据",
                              LSFormTableMapperCellRuleKey   : @{}
                              };
        return ret;
    }
}


+ (NSDictionary *)mapperWithClassName:(NSString *)className cellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label value:(NSString *)value andRule:(NSDictionary*)rule{
    @try {
        NSMutableDictionary* ret = [NSMutableDictionary dictionary];
        if (className) {
            ret[LSFormTableMapperCellClassKey]  = className;
        }
        if (cellName) {
            ret[LSFormTableMapperCellNameKey]   = cellName;
        }
        if (keyName) {
            ret[LSFormTableMapperCellKeyNameKey]= keyName;
        }
        if (label) {
            ret[LSFormTableMapperCellLabelKey]  = label;
        }
        if (value) {
            ret[LSFormTableMapperCellValueKey]  = value;
        }
        if (rule) {
            ret[LSFormTableMapperCellRuleKey]   = rule;
        }

        return ret;
    }
    @catch (NSException *exception) {
        NSLog(@"mapper create error");
        NSDictionary* ret = @{
                              LSFormTableMapperCellClassKey  : @"TextLabel",
                              LSFormTableMapperCellNameKey   : @"TextLabelError",
                              LSFormTableMapperCellKeyNameKey: @"",
                              LSFormTableMapperCellLabelKey  : @"错误的Mapper数据",
                              LSFormTableMapperCellRuleKey   : @{}
                              };
        return ret;
    }
}

+ (NSDictionary *)ruleWithCellStyle:(UITableViewCellStyle)style 
                      accessoryType:(UITableViewCellAccessoryType)type{
    return @{
             LSFormCellRuleCellStyleKey     : @(style),
             LSFormCellRuleAccessoryTypeKey : @(type)
             };
}

@end