//
//  UIViewController+LSTransitionExntends.m
//  Ivoryer
//
//  Created by Lessu on 13-5-21.
//  Copyright (c) 2013年 duohuo. All rights reserved.
//

#import "UIViewController+LSTransitionExntends.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

@implementation UIViewController (LSTransitionExntends)

ADD_DYNAMIC_PROPERTY(UIViewController *, _fadeInViewController, set_fadeInViewController);
ADD_DYNAMIC_PROPERTY(UIViewController *, fadeInParentViewController, setFadeInParentViewController);
//
- (void)fadeInViewController:(UIViewController *)controller animate:(BOOL)animate{
//    controller.fadeInParentViewController = self;
//    self._fadeInViewController = controller;
//    controller.view.alpha=0;
//    [APPDELEGATE.window addSubview:controller.view];
//    
//    controller.view.frame = APPDELEGATE.window.frame;
//    controller.view.top=20;
//    controller.view.height-=20;
//    [controller.view layoutSubviews];
//    if (animate) {
//        [UIView animateWithDuration:0.25 animations:^{
//            controller.view.alpha = 1;
//            [controller viewWillAppear:YES];
//        } completion:^(BOOL finished) {
//            [controller viewDidAppear:YES];
//        }];
//        
//    }else{
//        controller.view.alpha = 1;
//        [controller viewWillAppear:NO];
//        [controller viewDidAppear:NO];
//        
//    }
}
- (void)fadeOutViewControllerAnimate:(BOOL)animate{
    if (self.fadeInParentViewController!=NULL) {
        
        if (animate) {
            [UIView animateWithDuration:0.25 animations:^{
                self.view.alpha = 0;
                [self viewWillDisappear:YES];
            } completion:^(BOOL finished) {
                [self viewDidDisappear:YES];
                [self.view removeFromSuperview];
                self.fadeInParentViewController=NULL;
                self._fadeInViewController = NULL;

            }];
        }else{
            self.view.alpha = 0;

            [self viewWillDisappear:YES];
            [self viewDidDisappear:YES];
            
            [self.view removeFromSuperview];
            self.fadeInParentViewController=NULL;
            self._fadeInViewController = NULL;
        }
        

    }
}
- (void)flipView:(UIView *)view toPresentViewController:(UIViewController *)controller completion:(void (^)(void))completion {
    [self retain];
    [view retain];
    [controller retain];
    //调整大小
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect frame = window.frame;
    frame.size.height -= 20;
    frame.origin.y = 20;
    controller.view.frame = frame;
    [controller.view layoutIfNeeded];
    //预渲染一遍
    [self presentViewController:controller animated:NO completion:nil];
    [controller dismissViewControllerAnimated:NO completion:0];
    
    //获取将要显示的 View 的 Image
    UIGraphicsBeginImageContextWithOptions(controller.view.frame.size, controller.view.opaque, 0.0);
    [controller.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewControllerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //保存被翻转的View 的 Image
    UIGraphicsBeginImageContextWithOptions(view.frame.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImgae = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //坐标转化
    frame = view.frame;
    UIView *parentView = view.superview;
    if (parentView == window) {
    }else{
        UIView *parentParentView = parentView.superview;
        while (parentParentView&&parentView&&(parentView != self.view&&parentParentView != window)) {
            frame = [parentParentView convertRect:frame fromView:parentView];
            parentView=parentParentView;
            parentParentView = parentParentView.superview;
        }
    }
    frame = [window convertRect:frame fromView:parentView];
    
    //包裹旋转的View
    UIView      *imageLayout=[[UIView alloc]initWithFrame:window.bounds];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    [imageView setImage:viewImgae];
    
    [imageLayout addSubview:imageView];
    [window addSubview:imageLayout];
    
    [imageLayout release];
    [imageView release];
    
    
    CATransform3D rotationTransform = CATransform3DMakeRotation(M_PI*1.0f/2.0f, 0, 1, 0);
    
    [view setHidden:YES];
    //投影矩阵
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0/800.0;
    imageLayout .layer.sublayerTransform = perspective;
    imageLayout .layer .zPosition = 2000;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        imageView.layer.transform = rotationTransform;
        
    } completion:^(BOOL finished) {
        [imageView setImage:viewControllerImage];
        imageView.layer.transform = CATransform3DMakeRotation(-M_PI*1.0f/2.0f, 0, 1, 0);
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            imageView.layer.transform = CATransform3DIdentity;
            
            CGRect frame = window.frame;
            frame.size.height -= 20;
            frame.origin.y = 20;
            imageView.frame =  frame;
        } completion:^(BOOL finished) {
            [self presentViewController:controller animated:NO completion:completion];
            
            [imageLayout removeFromSuperview];
            [view setHidden:NO];
            [view release];
            [self release];
            [controller release];

        }];
        
    }];
}
- (void)flipView:(UIView *)view toShowView:(UIView *)showView completion:(void (^)(void))completion{
    [self retain];
    [view retain];
    [showView retain];
    //获取将要显示的 View 的 Image
    UIGraphicsBeginImageContextWithOptions(showView.frame.size, showView.opaque, 0.0);
    [showView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *showViewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //保存被翻转的View 的 Image
    UIGraphicsBeginImageContextWithOptions(view.frame.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImgae = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    //坐标转化
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect frame = view.frame;
    UIView *parentView = view.superview;
    if (parentView == window) {
    }else{
        UIView *parentParentView = parentView.superview;
        while (parentParentView&&parentView&&(parentView != self.view&&parentParentView != window)) {
            frame = [parentParentView convertRect:frame fromView:parentView];
            parentView=parentParentView;
            parentParentView = parentParentView.superview;
        }
    }
    frame = [window convertRect:frame fromView:parentView];
    //包裹旋转的View
    UIView      *imageLayout=[[UIView alloc]initWithFrame:window.bounds];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    [imageView setImage:viewImgae];
    
    [imageLayout addSubview:imageView];
    [window addSubview:imageLayout];
    
    [imageLayout release];
    [imageView release];
    
    
    CATransform3D rotationTransform = CATransform3DMakeRotation(M_PI*1.0f/2.0f, 0, 1, 0);
    
    [view setHidden:YES];
    //投影矩阵
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0/800.0;
    imageLayout .layer.sublayerTransform = perspective;
    imageLayout .layer .zPosition = 2000;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        imageView.layer.transform = rotationTransform;
        
    } completion:^(BOOL finished) {
        [imageView setImage:showViewImage];
        imageView.layer.transform = CATransform3DMakeRotation(-3.1415926*1.0f/2.0f, 0, 1, 0);
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            imageView.layer.transform = CATransform3DIdentity;
            
            
//            imageView.frame = showView.frame;
            CGRect frame = showView.frame;
//            frame.size.height -= 20;
            frame.origin.y = 20;
            imageView.frame =  frame;
        } completion:^(BOOL finished) {
//            [self presentViewController:controller animated:NO completion:completion];
            if (completion) {
                completion();
            }
            [imageLayout removeFromSuperview];
            [view setHidden:NO];
            [view release];
            [self release];
            [showView release];

        }];
        
    }];
}

- (void)flipView:(UIView *)view toPresentViewController:(UIViewController *)controller{
    [self flipView:view toPresentViewController:controller completion:0];
}

@end

@implementation UIViewController (LSTransitionExntends_Ivory)

- (void)dropViewController:(UIViewController *)viewController{
    
}

@end

