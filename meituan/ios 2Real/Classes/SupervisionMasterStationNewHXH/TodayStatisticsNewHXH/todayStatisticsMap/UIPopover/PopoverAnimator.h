//
//  PopoverAnimator.h
//  DItuProjectText
//
//  Created by Tesiro on 16/10/11.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class XSPresentationController;

@interface PopoverAnimator : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>{
    BOOL isPresented;
}
@property (nonatomic, strong)UIButton *button;
@property (nonatomic, strong)XSPresentationController *xsPresentationController;
@end
