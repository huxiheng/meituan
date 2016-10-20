//
//  UIViewController+KeyboardShowAndHide.h
//  Youxian100
//
//  Created by Lessu on 13-3-28.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

UIResponder *findFirstResponder(UIView* view);
static inline UIViewAnimationOptions animationOptionsWithCurve(UIViewAnimationCurve curve);
NSArray *allViewsOfClasses(NSArray *types,UIView *view);

@interface UIViewController (KeyboardShowAndHide)

@property(nonatomic,readonly) BOOL isKeyboardHidden;
@property(nonatomic,readonly) NSNumber *prevKeyboardHeight;
@property(nonatomic,assign)   BOOL showKeyboardToolbar;
@property(nonatomic,readonly) UIToolbar *keyboardToolbar;
@property(nonatomic,readonly) NSArray * responders;
- (void)addToggleKeyboardObserver;
- (void)removeToggleKeyboardObserver;

- (void)keyboardWillShowWithHeight:(float)height andAnimatingDuration:(float)duration option:(UIViewAnimationOptions)curve;
- (void)keyboardWillHideWithHeight:(float)height andAnimatingDuration:(float)duration option:(UIViewAnimationOptions)curve;
- (void)keyboardHeightChangedWithHeight:(float)height delataHeight:(float)deltaHeight andAnimatingDuration:(float)duration option:(UIViewAnimationOptions)curve;
@end


#define KeyboardShowAndHideSimpleImplement(__view) \
- (void)keyboardWillShowWithHeight:(float)height andAnimatingDuration:(float)duration option:(UIViewAnimationOptions)option{\
    CGFloat barHeight = 0;\
    if (self.tabBarController) {\
        barHeight += 49;\
    }\
    CGFloat cachedHeight = self.view .height;\
    [UIView animateWithDuration:duration delay:0 options:option animations:^{\
        __view .height -= height - barHeight;\
    } completion:^(BOOL finished) {\
        __view .height = cachedHeight - (height - barHeight);\
    }];\
}\
\
- (void)keyboardWillHideWithHeight:(float)height andAnimatingDuration:(float)duration option:(UIViewAnimationOptions)option{\
    CGFloat barHeight = 0;\
    if (self.tabBarController) {\
        barHeight += 49;\
    }\
    CGFloat cachedHeight = self.view .height;\
    [UIView animateWithDuration:duration delay:0 options:option animations:^{\
        __view .height += height - barHeight;\
    } completion:^(BOOL finished) {\
        __view .height = cachedHeight + (height - barHeight);\
    }];\
}\
- (void)keyboardHeightChangedWithHeight:(float)height delataHeight:(float)deltaHeight andAnimatingDuration:(float)duration option:(UIViewAnimationOptions)option{\
    CGFloat cachedHeight = self.view .height;\
    [UIView animateWithDuration:duration delay:0 options:option animations:^{\
        __view .height += deltaHeight;\
    } completion:^(BOOL finished) {\
        __view .height = cachedHeight + deltaHeight;\
    }];\
}\
