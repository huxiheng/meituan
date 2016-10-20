//
//  UIViewController+LSTransitionExntends.h
//  Ivoryer
//
//  Created by Lessu on 13-5-21.
//  Copyright (c) 2013年 duohuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LSTransitionExntends)

@property(nonatomic,retain) UIViewController * _fadeInViewController;
@property(nonatomic,retain) UIViewController * fadeInParentViewController;

- (void)fadeInViewController:(UIViewController *)controller animate:(BOOL)animate;

- (void)fadeOutViewControllerAnimate:(BOOL)animate;


- (void)flipView:(UIView *)view toPresentViewController:(UIViewController *)controller;
- (void)flipView:(UIView *)view toPresentViewController:(UIViewController *)controller completion:(void (^)(void))completion ;

- (void)flipView:(UIView *)view toShowView:(UIView *)showView completion:(void (^)(void))completion;

@end



@interface UIViewController (LSTransitionExntends_Ivory)

- (void)dropViewController:(UIViewController *)viewController;

@end
