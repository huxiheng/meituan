//
//  LSFormTextFieldCell.h
//  YinfengShop
//
//  Created by lessu on 13-12-23.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFormCell.h"
#define TextFieldCell(__key,__label,__placeHold) [LSFormTextFieldCell mapperWithCellName:CellNameKeyed(__key) keyName:__key label:__label placeHold:__placeHold]

@interface LSFormTextFieldCell : LSFormCell<UITextFieldDelegate>
@property(nonatomic,retain) UITextField *textField;

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label placeHold:(NSString *)placeHold;
+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label placeHold:(NSString *)placeHold andKeyboardType:(UIKeyboardType)keyboardType;
+ (NSDictionary *)ruleWithKeyboardType:(UIKeyboardType)keyboard andPlaceHolder:(NSString *)placeholder;

@end
