//
//  TextFieldLimiter.m
//  NipponComment
//
//  Created by lessu on 14-7-18.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "TextFieldLimiter.h"

@implementation TextFieldLimiter

+ (instancetype)limiterWithCount:(NSInteger)limit{
    return [[TextFieldLimiter alloc]initWithCount:limit];
}

- (instancetype)initWithCount:(NSInteger)limit
{
    self = [super init];
    if (self) {
        _limit = limit;
    }
    return self;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger length = textField.text.length;
    if (length >= _limit && string.length >0)
    {
        if ([_delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            [_delegate textField:textField shouldChangeCharactersInRange:range replacementString:string]; 
        }
        return NO;
    }
    if ([_delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [_delegate textField:textField shouldChangeCharactersInRange:range replacementString:string]; 
    }

    return YES;
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSInteger length = textView.text.length;
    if (length >= _limit && text.length >0)
    {
        if ([_delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
            [_delegate textView:textView shouldChangeTextInRange:range replacementText:text];            
        }

        return NO;
    }
    if ([_delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return[_delegate textView:textView shouldChangeTextInRange:range replacementText:text];            
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([_delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [_delegate textFieldShouldBeginEditing:textField];
    }
    return true;

}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([_delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [_delegate textFieldDidBeginEditing:textField];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([_delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {       
        return [_delegate textFieldShouldEndEditing:textField];    
    }
    return true;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([_delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {       
        [_delegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if ([_delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {       
        return [_delegate textFieldShouldClear:textField];
    }
    return true;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([_delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {       
        return [_delegate textFieldShouldReturn:textField];
    }
    return true;
}





- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([_delegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {       
        return [_delegate textViewShouldBeginEditing:textView];
    }
    return true;   
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([_delegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {       
        return [_delegate textViewShouldEndEditing:textView];
    }
    return true;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([_delegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {       
        [_delegate textViewDidBeginEditing:textView];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([_delegate respondsToSelector:@selector(textViewDidEndEditing:)]) {       
        [_delegate textViewDidEndEditing:textView];
    }
}


- (void)textViewDidChange:(UITextView *)textView{
    if ([_delegate respondsToSelector:@selector(textViewDidChange:)]) {       
        [_delegate textViewDidChange:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    if ([_delegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {       
        [_delegate textViewDidChangeSelection:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    if ([_delegate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)]) {       
        return [_delegate textView:textView shouldInteractWithURL:URL inRange:characterRange];
    }
    return true;
}
    
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange{
    if ([_delegate respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)]) {       
        return [_delegate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    }
    return true;
}

@end
