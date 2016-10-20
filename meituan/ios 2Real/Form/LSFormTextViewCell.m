//
//  LSFormTextViewCell.m
//  YinfengShop
//
//  Created by lessu on 13-12-23.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFormTextViewCell.h"
#import "LSForm.h"

NSString *LSFormTextViewCellRuleCanEditKey  = @"LSFormTextViewCellRuleCanEditKey";
NSString *LSFormTextViewCellRuleHeightKey   = @"LSFormTextViewCellRuleHeightKey";

@implementation LSFormTextViewCell

- (void)onInitWithLabel:(NSString *)label value:(NSString *)value andRule:(NSDictionary *)rule{
    self.height = [self cellHeight];
    _textView= [[UITextView alloc]initWithFrame:CGRectMake(10, 0, self.width - 20, self.height)];
    _textView.autoresizingMask = !UIViewAutoresizingNone;
    _textView.backgroundColor = [UIColor clearColor];
    [self addSubview:_textView];
    
    _textView.text = value;
    _textView.delegate = self;
}

- (void)setData:(NSString *)data{
    _data = data;

    if (IS_STRING(data)) {
        _textView.text = data;
    }
}
- (id)data{
    [super resignFirstResponder];
    [_textView resignFirstResponder];
    return _data;
}

- (CGFloat)cellHeight{
    return [self.mapper[LSFormTableMapperCellRuleKey][LSFormTextViewCellRuleHeightKey] floatValue];
}

- (void)onSelected:(LSFormTableViewController *)viewController complete:(void (^)())onComplete{
    [_textView becomeFirstResponder];
    if (onComplete) {
        onComplete();
    }
}
+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName andCanEdit:(BOOL)canEdit andHeight:(CGFloat)height{
    return [LSFormCell mapperWithClassName:@"TextView" cellName:cellName keyName:keyName label:nil value:nil andRule:[LSFormTextViewCell ruleWithCanEdit:YES andHeight:height]];
}
+ (NSDictionary *)ruleWithCanEdit:(BOOL)canEdit andHeight:(CGFloat)height{
    return @{LSFormTextViewCellRuleCanEditKey:@(canEdit),
             LSFormTextViewCellRuleHeightKey :@(height)
             };
}
#pragma mark UITextField Delegate
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.data = textView.text;
    if ([self.delegate respondsToSelector:@selector(cell:valuedChanged:)]) {
        [self.delegate cell:self valuedChanged:self.data];
    }
}
- (BOOL)resignFirstResponder{
    [super resignFirstResponder];
    [_textView resignFirstResponder];
    return YES;
}
@end