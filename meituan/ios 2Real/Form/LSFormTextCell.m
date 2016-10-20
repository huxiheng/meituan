//
//  LSFormTextCell.m
//  YinfengShop
//
//  Created by lessu on 13-12-23.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFormTextCell.h"
#import "LSForm.h"

@implementation LSFormTextCell

- (void)onInitWithLabel:(NSString *)label value:(NSString *)value andRule:(NSDictionary *)rule{
    self.textLabel.text = label;
    self.detailTextLabel.text = value;
}

- (void)setData:(NSString *)data{
    _data = data;
    if (IS_STRING(data)) {
        if (self.detailTextLabel) {
            self.detailTextLabel.text = data;
        }else{
            self.textLabel.text = data;
        }
    }
}

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName andKeyName:(NSString *)keyName{
    return [LSFormCell mapperWithClassName:@"Text" cellName:cellName keyName:keyName   label:nil value:nil andRule:nil];
}

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName andText:(NSString *)text{
    return [LSFormCell mapperWithClassName:@"Text" cellName:cellName keyName:nil       label:text value:nil andRule:nil];
}
+ (NSDictionary *)mapperWithCellName:(NSString *)cellName label:(NSString *)text andDetail:(NSString *)detail{
    return [LSFormCell mapperWithClassName:@"Text" 
                                  cellName:cellName 
                                   keyName:nil       
                                     label:text 
                                     value:detail 
                                   andRule:@{
                                             LSFormCellRuleCellStyleKey : @(UITableViewCellStyleValue1)
                                             }
            ];
}
+ (NSDictionary *)mapperWithCellName:(NSString *)cellName label:(NSString *)text detail:(NSString *)detail andCellStyle:(UITableViewCellStyle)style{
    return [LSFormCell mapperWithClassName:@"Text" 
                                  cellName:cellName 
                                   keyName:nil       
                                     label:text 
                                     value:detail 
                                   andRule:@{
                                             LSFormCellRuleCellStyleKey : @(style)
                                             }
            ];
}
+ (NSDictionary *)mapperWithCellName:(NSString *)cellName label:(NSString *)text detail:(NSString *)detail andCellStyle:(UITableViewCellStyle)style accessoryType:(UITableViewCellAccessoryType)accessoryType{
    return [LSFormCell mapperWithClassName:@"Text" 
                                  cellName:cellName 
                                   keyName:nil       
                                     label:text 
                                     value:detail 
                                   andRule:@{
                                             LSFormCellRuleCellStyleKey     : @(style),
                                             LSFormCellRuleAccessoryTypeKey : @(accessoryType)
                                             }
            ];
}
@end

