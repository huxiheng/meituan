//
//  LSPickerActionSheet.m
//  Yingfeng
//
//  Created by Lessu on 13-7-25.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSActionSheet.h"
#define LS_ACTION_ANIMATE_DURATION 0.3
@interface LSActionSheet()
{
}
@end

@implementation LSActionSheet
- (id)initWithTitle:(NSString *)title andCostomView:(UIView *)costomView
{
    self = [super init];
    if (self) {
        COPY_ASSIGN(_title, title);
        STRONG_ASSIGN(_costomView, costomView);
        [self _init];
    }
    return self;
}

- (void) _init{
    self.backgroundColor = [UIColor whiteColor];
    _costomViewContainer = [[UIView alloc]initWithFrame:CGRectZero];
    
    //创建工具栏
	UIBarButtonItem *confirmBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirmButtonPressed)];
	UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonPressed)];
    NSArray *items = @[cancelBtn,flexibleSpaceItem,confirmBtn];
    [cancelBtn release];
    [flexibleSpaceItem release];
    [confirmBtn release];

    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    _toolBar.hidden = NO;
    if (!IS_FLAT_STYLE) {
        _toolBar.barStyle = UIBarStyleBlackTranslucent;        
    }

    _toolBar.items = items;
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:_toolBar.bounds];
    _titleLabel .backgroundColor = [ UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.autoresizingMask = LSUI_VIEW_AUTORESIZE_W_H;
    [_toolBar addSubview:_titleLabel];
    
    _backgroundMaskView = [[UIView alloc]init];
    [self addSubview:_costomViewContainer];
    [self addSubview:_toolBar];
    
    self.title = _title;
}


- (void)dealloc
{
    [_title release];
    [_titleLabel release];
    [_toolBar release];
    [_costomViewContainer release];
    [_costomView release];
    [_parentView release];
    [_backgroundMaskView release];
    Block_release(_onConfirm);
    Block_release(_onCancel);
    [super dealloc];
}

- (void)showInView:(UIView *)view{
    STRONG_ASSIGN(_parentView, view);
    [_costomViewContainer addSubview:_costomView];

    _costomViewContainer.frame = CGRectMake(0, _toolBar.height, view.width , _costomView.top+_costomView.height);
    _toolBar.width = view.width;

    self.width  = view.width;
    self.height = _costomViewContainer .height + _toolBar.height;
    
    self.left = 0;
    self.top  = view.height;
    
    _backgroundMaskView.frame = view.bounds;
    [view addSubview:_backgroundMaskView];
    [view addSubview:self];
    _backgroundMaskView .backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:LS_ACTION_ANIMATE_DURATION animations:^{
        self.top  = view.height - self.height;
        _backgroundMaskView .backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }];
}


- (void) confirmButtonPressed{
    BOOL shouldClose = true;
    if (_onConfirm) {
        shouldClose = _onConfirm();
    }
    if (shouldClose) {
        [UIView animateWithDuration:LS_ACTION_ANIMATE_DURATION animations:^{
            self.top  = _parentView.height;
            _backgroundMaskView .backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];

            [_backgroundMaskView removeFromSuperview];
        }];
    }
}
- (void)cancelButtonPressed{
    BOOL shouldClose = true;
    if (_onCancel) {
        shouldClose = _onCancel();
    }
    if (shouldClose) {
        [UIView animateWithDuration:LS_ACTION_ANIMATE_DURATION animations:^{
            self.top  = _parentView.height;
            _backgroundMaskView .backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [_backgroundMaskView removeFromSuperview];
        }];
    }
}


#pragma mark setter/getter
- (void)setTitle:(NSString *)title{
    COPY_ASSIGN(_title, title);
    _titleLabel .text = title;
}


@end
