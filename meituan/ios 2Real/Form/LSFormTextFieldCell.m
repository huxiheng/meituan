//
//  LSFormTextFieldCell.m
//  YinfengShop
//
//  Created by lessu on 13-12-23.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFormTextFieldCell.h"
#import "LSForm.h"

NSString *LSFormTextFieldCellRuleKeyboardKey = @"LSFormTextFieldCellRuleKeyboardKey";
NSString *LSFormTextFieldCellRulePlaceHoldKey= @"LSFormTextFieldCellRulePlaceHoldKey";
@implementation LSFormTextFieldCell

- (void)onInitWithLabel:(NSString *)label value:(NSString *)value andRule:(NSDictionary *)rule{
    self.textLabel.text = label;
    self.textLabel.minimumFontSize = 9;
//    self.textLabel.adjustsFontSizeToFitWidth = YES;
    
    _textField= [[UITextField alloc]initWithFrame:CGRectZero];
    _textField.autoresizingMask = !UIViewAutoresizingNone;
    _textField.textAlignment = UITextAlignmentRight;
    _textField.keyboardType  = [rule[LSFormTextFieldCellRuleKeyboardKey] integerValue];
    [self addSubview:_textField];
    
    _textField.placeholder = rule[LSFormTextFieldCellRulePlaceHoldKey];
    _textField.text = value;
    
    _textField.delegate = self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.width = 80;
    _textField.left = self.textLabel.left + self.textLabel.width + 10;
    _textField.width= self.width - _textField.left - 20;
    _textField.height= 23 ;
    _textField.top   = (self.cellHeight - 23 )/2.0;
}
- (void)setData:(NSString *)data{
    _data = data;
    if (IS_STRING(data)) {
        _textField.text = data;
    }
}
- (id)data{
    [super resignFirstResponder];
    [_textField resignFirstResponder];
    return _data;
}
- (void)onSelected:(LSFormTableViewController *)viewController complete:(void (^)())onComplete{
    [_textField becomeFirstResponder];
    if (onComplete) {
        onComplete();
    }
}
#pragma mark UITextField Delegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.data = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

- (BOOL)resignFirstResponder{
    [super resignFirstResponder];
    [_textField resignFirstResponder];
    return YES;
}

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label placeHold:(NSString *)placeHold{
    return [LSFormCell mapperWithClassName:@"TextField" cellName:cellName keyName:keyName label:label value:nil andRule:[LSFormTextFieldCell ruleWithKeyboardType:UIKeyboardTypeDefault andPlaceHolder:placeHold]];
}
+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label placeHold:(NSString *)placeHold andKeyboardType:(UIKeyboardType)keyboardType{
    return [LSFormCell mapperWithClassName:@"TextField" cellName:cellName keyName:keyName label:label value:nil andRule:[LSFormTextFieldCell ruleWithKeyboardType:keyboardType andPlaceHolder:placeHold]];
}
+ (NSDictionary *)ruleWithKeyboardType:(UIKeyboardType)keyboard andPlaceHolder:(NSString *)placeholder{
    return @{
             LSFormTextFieldCellRuleKeyboardKey: @(keyboard),
             LSFormTextFieldCellRulePlaceHoldKey:placeholder
            };
}
@end
