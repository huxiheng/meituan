//
//  TextInputViewController.m
//  Youxian100
//
//  Created by Lessu on 13-4-2.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFTextInputViewController.h"

@interface LSFTextInputViewController ()

@end

@implementation LSFTextInputViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithOnCompleteBlock:(void (^)(NSString *text))onComplete
{
    self = [super init];
    if (self) {
        _onComplete = onComplete;
    }
    return self;
}

- (id)initWithString:(NSString *)text OnCompleteBlock:(void (^)(NSString *text))onComplete
{
    self = [super init];
    if (self) {
        _onComplete = onComplete;
        _text = text;
    }
    return self;
}

-(void)setData{
    self.titleForNav = @"处理信息";
}

- (void)viewDidLoad
{
    IOS7_LAYOUT_FIX;
    [super viewDidLoad];
    STRING_SET_EMPTY_IF_NULL(_placeHoldText);
    [self.inputView setText:self.placeHoldText];
    
    if (STRING_NOT_EMPTY(_text)) {
        _inputView.text = _text;
    }
    [self.inputView becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(completeInput)];
    self.navigationItem.rightBarButtonItem = barItem;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
    [self setInputView:nil];
    [super viewDidUnload];
}
                                
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([self.inputView.text isEqualToString:self.placeHoldText]) {
        self.inputView.text = @"";
    }
    return YES;
}
- (void)completeInput{
    [self.inputView resignFirstResponder];
    if([self validateInputValue]){
        if (_onComplete)    {
            _onComplete(self.inputView.text);
        }
    }
}

- (BOOL)validateInputValue
{
    BOOL result = NO;
    if (_inputView.text.length == 0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"内容不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show]; 
    }
    else result = YES;
    
    return result;
}
@end









