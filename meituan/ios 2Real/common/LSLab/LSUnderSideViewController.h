//
//  LSSideViewController.h
//  LSLab
//
//  Created by Lessu on 13-5-8.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//v1.1 enableGesture

#import <UIKit/UIKit.h>
typedef enum{
    LSUnderSideViewControllerStatusShowCenter = 0,
    LSUnderSideViewControllerStatusShowLeft,
    LSUnderSideViewControllerStatusShowRight
}LSUnderSideViewControllerStatus;

@protocol LSUnderSideViewControllerDelegate;

@interface LSUnderSideViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic,retain) UIViewController *leftViewController;
@property(nonatomic,retain) UIViewController *rightViewController;
@property(nonatomic,retain) UIView *centerContainerView;
@property(nonatomic,assign) LSUnderSideViewControllerStatus status;
@property(nonatomic,assign) id<LSUnderSideViewControllerDelegate> delegate;

- (void)showLeftAnimate:(BOOL)animate;
- (void)hideLeftAnimate:(BOOL)animate;
- (void)showRightAnimate:(BOOL)animate;
- (void)hideRightAnimate:(BOOL)animate;

@property(nonatomic,assign) BOOL canShowLeft;
@property(nonatomic,assign) BOOL canShowRight;
@property(nonatomic,assign) BOOL enableGesture;
@end



@interface LSUnderSideViewController (Convinence)
- (void)showLeft;
- (void)hideLeft;
- (void)showRight;
- (void)hideRight;
@end


@protocol LSUnderSideViewControllerDelegate <NSObject>
@optional
- (BOOL) underSideViewControllerShouldShowLeft:(LSUnderSideViewController *)viewController;
- (void) underSideViewControllerWillShowLeft:(LSUnderSideViewController *)viewController;
- (void) underSideViewControllerDidShowLeft:(LSUnderSideViewController *)viewController;

- (BOOL) underSideViewControllerShouldShowRight:(LSUnderSideViewController *)viewController;
- (void) underSideViewControllerWillShowRight:(LSUnderSideViewController *)viewController;
- (void) underSideViewControllerDidShowRight:(LSUnderSideViewController *)viewController;
@end

