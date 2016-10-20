//
//  LSFormTextFieldNewCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/25.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSFormTextFieldNewCell.h"
#import "LSForm.h"


NSString *LSFormTextFieldCellRuleKeyboardNewKey = @"LSFormTextFieldCellRuleKeyboardNewKey";
NSString *LSFormTextFieldCellRulePlaceHoldNewKey= @"LSFormTextFieldCellRulePlaceHoldNewKey";

@implementation LSFormTextFieldNewCell
- (void)onInitWithLabel:(NSString *)label value:(NSString *)value andRule:(NSDictionary *)rule{
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 45)];
    self.viewBG.backgroundColor  = [UIColor colorWithHexString:kcolorBJ_f0eff4];
    [self addSubview:self.viewBG];
    
    UIView *viewTextField= [[UIView alloc] initWithFrame:CGRectMake(28, 0, DeviceWidth-56, 40)];
    viewTextField.backgroundColor = [UIColor whiteColor];
    viewTextField.layer.cornerRadius = 5;
    viewTextField.layer.masksToBounds = YES;
    [self.viewBG addSubview:viewTextField];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, DeviceWidth-56-24, 40)];
    self.textField.placeholder = @" 关键词";
    self.textField.font = themeFont16;
    self.textField.textColor = [UIColor colorWithHexString:kc00_333333];
    self.textField.keyboardType = UIKeyboardTypeDefault;
    self.textField.delegate = self;
    [viewTextField addSubview:self.textField];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    if ([self.delegate respondsToSelector:@selector(cell:valuedChanged:)]) {
        [self.delegate cell:self valuedChanged:self.data];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstResponder];
    return YES;
}

- (BOOL)resignFirstResponder{
    [super resignFirstResponder];
    [_textField resignFirstResponder];
    return YES;
}

- (CGFloat)cellHeight {
    return 45;
}

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName placeHold:(NSString *)placeHold {
    return [LSFormCell mapperWithClassName:@"TextFieldNew" cellName:cellName keyName:keyName label:nil value:nil andRule:[LSFormTextFieldNewCell ruleWithKeyboardType:UIKeyboardTypeDefault andPlaceHolder:placeHold]];
}
+ (NSDictionary *)ruleWithKeyboardType:(UIKeyboardType)keyboard andPlaceHolder:(NSString *)placeholder{
    return @{
             LSFormTextFieldCellRuleKeyboardNewKey: @(keyboard),
             LSFormTextFieldCellRulePlaceHoldNewKey:placeholder
             };
}
@end
