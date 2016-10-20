//
//  LSSideViewController.h
//  LSLab
//
//  Created by Lessu on 13-5-8.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    LSSideViewControllerStatusShowCenter = 0,
    LSSideViewControllerStatusShowLeft,
    LSSideViewControllerStatusShowRight
}LSSideViewControllerStatus;

@protocol LSSideViewControllerDelegate;

@interface LSSideViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic,retain) UIViewController *leftViewController;
@property(nonatomic,retain) UIViewController *rightViewController;
@property(nonatomic,retain) UIView *centerContainerView;
@property(nonatomic,assign) LSSideViewControllerStatus status;
@property(nonatomic,assign) id<LSSideViewControllerDelegate> delegate;

- (void)showLeftAnimate:(BOOL)animate;
- (void)hideLeftAnimate:(BOOL)animate;
- (void)showRightAnimate:(BOOL)animate;
- (void)hideRightAnimate:(BOOL)animate;


@end



@interface LSSideViewController (Convinence)
- (void)showLeft;
- (void)hideLeft;
- (void)showRight;
- (void)hideRight;
@end


@protocol LSSideViewControllerDelegate <NSObject>
@optional
- (BOOL) sideViewControllerShouldShowLeft:(LSSideViewController *)viewController;
- (void) sideViewControllerWillShowLeft:(LSSideViewController *)viewController;
- (void) sideViewControllerDidShowLeft:(LSSideViewController *)viewController;

- (BOOL) sideViewControllerShouldShowRight:(LSSideViewController *)viewController;
- (void) sideViewControllerWillShowRight:(LSSideViewController *)viewController;
- (void) sideViewControllerDidShowRight:(LSSideViewController *)viewController;
@end
