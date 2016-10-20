//
//  PopoverAnimator.m
//  DItuProjectText
//
//  Created by Tesiro on 16/10/11.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import "PopoverAnimator.h"
#import "XSPresentationController.h"

@implementation PopoverAnimator
-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    self.xsPresentationController = [[XSPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    self.xsPresentationController.frameForPresent = CGRectMake(_button.frame.origin.x, _button.frame.origin.y+kscaleIphone6DeviceHeight(29)+64, _button.frame.size.width, kscaleIphone6DeviceHeight(117));
    return self.xsPresentationController;
}

//自定义弹出的动画
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    isPresented = YES;
    return self;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    isPresented = NO;
    return self;
}
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    isPresented ? [self animationForPresentedView:transitionContext ] : [ self animationForDismissedView:transitionContext];
}

-(void)animationForPresentedView:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *presentView= [transitionContext viewForKey:UITransitionContextToViewKey];
    [transitionContext.containerView addSubview:presentView];
    presentView.transform = CGAffineTransformMakeScale(1.0, 0.0);
    presentView.layer.anchorPoint = CGPointMake(0.5, 0);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        presentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
-(void)animationForDismissedView:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.button.selected = !self.button.selected;
    // 1.获取消失的View
    UIView* dismissView = [transitionContext viewForKey:UITransitionContextFromViewKey ];
    
    // 2.执行动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        dismissView.transform = CGAffineTransformMakeScale(1.0, 0.0);
    } completion:^(BOOL finished) {
        [dismissView removeFromSuperview];
        // 必须告诉转场上下文你已经完成动画
        [transitionContext completeTransition:YES];
        
    }];
    
}

@end
