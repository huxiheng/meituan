//
//  UIViewController+KeyboardShowAndHide.m
//  Youxian100
//
//  Created by Lessu on 13-3-28.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "UIViewController+KeyboardShowAndHide.h"
#import <objc/runtime.h>


@implementation UIViewController (KeyboardShowAndHide)

@dynamic isKeyboardHidden,showKeyboardToolbar;
static char kPropertyisKeyboardHidden;
static char kPropertyisKeyboardToolbarShow;

- ( BOOL ) isKeyboardHidden {
    return [( NSNumber * ) objc_getAssociatedObject(self, &(kPropertyisKeyboardHidden) ) boolValue]; \
}
- (void) setIsKeyBoradHidden:(BOOL)hidden{
    objc_setAssociatedObject(self, &(kPropertyisKeyboardHidden), [NSNumber numberWithBool:hidden],OBJC_ASSOCIATION_COPY);
}

ADD_DYNAMIC_PROPERTY(NSNumber *, prevKeyboardHeight, setPrevKeyboardHeight);

- ( BOOL ) showKeyboardToolbar {
    return [( NSNumber * ) objc_getAssociatedObject(self, &(kPropertyisKeyboardToolbarShow) ) boolValue]; \
}
- (void) setShowKeyboardToolbar:(BOOL)show{
    objc_setAssociatedObject(self, &(kPropertyisKeyboardToolbarShow), [NSNumber numberWithBool:show],OBJC_ASSOCIATION_COPY);
}

ADD_DYNAMIC_PROPERTY(UIToolbar *, keyboardToolbar, setKeyboardToolbar);

ADD_DYNAMIC_PROPERTY(NSArray *, responders, setResponders);



#pragma mark - method
- (void)addToggleKeyboardObserver{
    if (self.responders == NULL) {
        [self refreashView];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self setIsKeyBoradHidden:YES];
    
    if (self.keyboardToolbar == NULL) {
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
        UIBarButtonItem *prevItem  = [[UIBarButtonItem alloc] initWithTitle:@"  <  " style:UIBarButtonItemStylePlain target:self action:@selector(prevButtonPressed:)];
        UIBarButtonItem *nextItem  = [[UIBarButtonItem alloc] initWithTitle:@"  >" style:UIBarButtonItemStylePlain target:self action:@selector(nextButtonPressed:)];
        UIBarButtonItem *flexableItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭键盘" style:UIBarButtonItemStylePlain target:self action:@selector(toolbarCloseButtonPressed)];
        
        [toolbar setItems:@[prevItem,nextItem,flexableItem,closeItem]];
        
        toolbar.hidden = true;
        self.keyboardToolbar = toolbar;
        
        [toolbar release];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil]; //监听是否触发home键挂起程序.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];

}

- (void)applicationWillResignActive:(UIApplication *)application{
    UIResponder *firstResponder = findFirstResponder(self.view);
    [firstResponder resignFirstResponder];
}
- (void)applicationDidBecomeActive:(UIApplication *)application{
    
}

- (void)removeToggleKeyboardObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.keyboardToolbar removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];

}

- (void)refreashView{
    self.responders = allViewsOfClasses(@[[UITextField class],[UITextView class]], self.view);
}

#pragma mark - actions
- (void)prevButtonPressed:(UIBarButtonItem *)sender{
    UIResponder *firstResponder = findFirstResponder(self.view);
    int index = [self.responders indexOfObject:firstResponder];
    if (index != NSNotFound) {
        if (index == 0) {
            
        }else{
            UIResponder* nextResponder = self.responders [ index - 1 ];
            [nextResponder becomeFirstResponder];
        }
    }
}
- (void)nextButtonPressed:(UIBarButtonItem *)sender{
    UIResponder *firstResponder = findFirstResponder(self.view);
    int index = [self.responders indexOfObject:firstResponder];
    if (index != NSNotFound) {
        if (index == self.responders.count - 1) {
            [firstResponder resignFirstResponder];
        }else{
            UIResponder* nextResponder = self.responders [ index + 1 ];
            [nextResponder becomeFirstResponder];
        }
    }
}
- (void)toolbarCloseButtonPressed{
    [self resignFirstResponder];
    UIResponder *firstResponder = findFirstResponder(self.view);
    [firstResponder resignFirstResponder];
}


#pragma mark - Responding to keyboard events
- (void)keyboardWillShow:(NSNotification *)notification {
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's
    // coordinate system. The bottom of the text view's frame should align with the top
    // of the keyboard's final position.
    //
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationOptions option  = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    if (!self.isKeyboardHidden) {
        float deletaHeight = [self.prevKeyboardHeight floatValue] - keyboardRect.size.height;
        [self setPrevKeyboardHeight:[NSNumber numberWithFloat:keyboardRect.size.height]];
//        [self keyboardHeightChangedWithHeight:keyboardRect.size.height delataHeight:deletaHeight andAnimatingDuration:duration];
        [self keyboardHeightChangedWithHeight:keyboardRect.size.height delataHeight:deletaHeight andAnimatingDuration:duration option:option];

    }else{
        [self setIsKeyBoradHidden:NO];
        [self setPrevKeyboardHeight:[NSNumber numberWithFloat:keyboardRect.size.height]];
//        [self keyboardWillShowWithHeight:keyboardRect.size.height andAnimatingDuration:duration];
        [self keyboardWillShowWithHeight:keyboardRect.size.height andAnimatingDuration:duration option:option];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    if (self.isKeyboardHidden) return;
    [self setIsKeyBoradHidden:YES];

    NSDictionary *userInfo = [notification userInfo];

    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's
    // coordinate system. The bottom of the text view's frame should align with the top
    // of the keyboard's final position.
    //
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationOptions option  = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];

//    [self keyboardWillHideWithHeight:keyboardRect.size.height andAnimatingDuration:duration];
    [self keyboardWillHideWithHeight:keyboardRect.size.height andAnimatingDuration:duration option:option];
}


#pragma mark keyboard show and hide
- (void)keyboardWillShowWithHeight:(float)height andAnimatingDuration:(float)duration option:(UIViewAnimationOptions)option{
    CGFloat barHeight = 0;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden) {
        barHeight += 49;
    }
    CGFloat cachedHeight = self.view .height;
    if (self.showKeyboardToolbar) {
        self.keyboardToolbar.top = self.view.window.height;// - 0 - self.keyboardToolbar.height;
        self.keyboardToolbar.hidden = false;
        [self.view.window addSubview:self.keyboardToolbar];
    }
    [UIView animateWithDuration:duration delay:0.0 options:option animations:^{
        self.view .height -= height - barHeight;
        self.keyboardToolbar.top = self.view.window.height - height - self.keyboardToolbar.height;
    } completion:^(BOOL finished) {
        self.view .height = cachedHeight - (height - barHeight);
    }];
}

- (void)keyboardWillHideWithHeight:(float)height andAnimatingDuration:(float)duration option:(UIViewAnimationOptions)option{\
    CGFloat barHeight = 0;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden) {
        barHeight += 49;
    }
    CGFloat cachedHeight = self.view .height;
    [UIView animateWithDuration:duration delay:0.0 options:option animations:^{
        self.view .height += height - barHeight;
        self.keyboardToolbar.top = self.view.window.height;// - 0 - self.keyboardToolbar.height;
    } completion:^(BOOL finished) {
        self.view .height = cachedHeight + (height - barHeight);
        [self.keyboardToolbar removeFromSuperview];
        self.keyboardToolbar.hidden = true;
    }];
}
- (void)keyboardHeightChangedWithHeight:(float)height delataHeight:(float)deltaHeight andAnimatingDuration:(float)duration option:(UIViewAnimationOptions)option{
    if (duration == 0){
        self.view .height += deltaHeight;
        self.keyboardToolbar.top = self.view.window.height - height - self.keyboardToolbar.height;

    }else{
        CGFloat cachedHeight = self.view .height;
        [UIView animateWithDuration:duration delay:0.0 options:option animations:^{
            self.view .height += deltaHeight;
            self.keyboardToolbar.top = self.view.window.height - height - self.keyboardToolbar.height;
        } completion:^(BOOL finished) {
            self.view .height = cachedHeight + deltaHeight;
        }];
    }
}


@end

static inline UIViewAnimationOptions animationOptionsWithCurve(UIViewAnimationCurve curve)
{
    UIViewAnimationOptions opt = (UIViewAnimationOptions)curve;
    return opt << 16;
}

UIResponder *findFirstResponder(UIView* view){
    UIResponder *responder = NULL;
    if (view.isFirstResponder) {
        return view;
    }else{
        NSArray *subviews = view.subviews;
        for (int i = 0 ; i<subviews.count; i++) {
            responder = findFirstResponder(subviews[i]);
            if (responder) {
                return responder;
            }
        }
    }
    return NULL;
}
void __allViewsOfClasses(NSArray *types,UIView *view,NSMutableArray *array);
NSArray *allViewsOfClasses(NSArray *types,UIView *view){
    NSMutableArray *array = [NSMutableArray array];
    __allViewsOfClasses(types, view , array);
    return array;
}

void __allViewsOfClasses(NSArray *types,UIView *view,NSMutableArray *array){
    for (int i = 0 ; i < types.count; i++) {
        if ([view isKindOfClass:types[i]]) {
            [array addObject:view];
        }
    }
    for (int i = 0; i < view.subviews.count; i++) {
        __allViewsOfClasses(types, view.subviews[i], array);
    }
    
}
