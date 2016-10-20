//
//  LSFormTextLabelCell.h
//  YinfengShop
//
//  Created by lessu on 13-12-23.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFormCell.h"
/**
 DefautlRule : {
    //打开LSFTextInputViewController进行修改
    canEdit : false
 }
 */
#define TextLabelCellCanEdit(__key,__label) [LSFormTextLabelCell mapperWithCellName:CellNameKeyed(__key) keyName:__key label:__label andCanEdit:YES]
#define TextLabelCellNOEdit(__key,__label) [LSFormTextLabelCell mapperWithCellName:CellNameKeyed(__key) keyName:__key label:__label andCanEdit:NO]

@interface LSFormTextLabelCell : LSFormCell
+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label andCanEdit:(BOOL)canEdit;
+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label andCanEdit:(BOOL)canEdit cellStyle:(UITableViewCellStyle)style;
+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label andCanEdit:(BOOL)canEdit keyboardType:(UIKeyboardType)keyboardType cellStyle:(UITableViewCellStyle)style;
+ (NSDictionary *)ruleWithCanEdit:(BOOL)canEdit keyboardType:(UIKeyboardType)keyboard cellStyle:(UITableViewCellStyle)style;
@end