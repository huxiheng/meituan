//
//  LSPickerActionSheet.h
//  Yingfeng
//
//  Created by Lessu on 13-7-25.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSActionSheet : UIView
{
    NSString    *_title;
    UIToolbar   *_toolBar;
    UIView      *_costomViewContainer;
    UIView      *_parentView;
    UIView      *_costomView;
    UILabel     *_titleLabel;
    UIView      *_backgroundMaskView;
}
- (id)initWithTitle:(NSString *)title andCostomView:(UIView *)costomView;

@property(nonatomic,retain) NSString* title;
@property(nonatomic,retain) UIView *costomView;


@property(nonatomic,copy)   BOOL (^onCancel)();
@property(nonatomic,copy)   BOOL (^onConfirm)();



- (void)showInView:(UIView *)view;
@end
