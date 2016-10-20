//
//  LSUnderSideViewController.m
//  LSLab
//
//  Created by Lessu on 13-5-8.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSUnderSideViewController.h"
#import "UIView+Sizes.h"
@interface LSUnderSideViewController ()<UIGestureRecognizerDelegate>
{
    UIView *_leftContainerView;
    UIView *_rightContainerView;
    UIView *_centerContainerView;
//    UIView *_centerContainerView;
    UIScrollView *_scrollView;
    
    UIPanGestureRecognizer *_panGestureRecognizer;
    UITapGestureRecognizer *_tapGestureRecognizer;
    CGPoint                 _panGestureStartPoint;
    
    UIButton                *_maskButton;
    //    BOOL                    _panValid;
}
@end

@implementation LSUnderSideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//- (void)loadView{
//    [super loadView];
//
//    self.view = [[UIScrollView alloc]initWithFrame:CGRectZero];
//    self.view.backgroundColor = [UIColor blueColor];
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _enableGesture = true;
    _status = LSUnderSideViewControllerStatusShowCenter;
    if (!_centerContainerView) {
        _centerContainerView = [self.view retain];
    }
    _centerContainerView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;
    
    self.view = [[UIView alloc]initWithFrame:self.view.frame] ;
    [self.view setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    [self.view setClipsToBounds:YES];
    
    _leftContainerView = [[UIView alloc]initWithFrame:CGRectZero];
    _rightContainerView =[[UIView alloc]initWithFrame:CGRectZero];

    [self.view addSubview:_centerContainerView];
    
//    _panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(_viewPanedProcess:)];
//    _panGestureRecognizer.delegate = self;
//    [_centerContainerView addGestureRecognizer:_panGestureRecognizer];
//    
//
//    
//    _maskButton = [[UIButton alloc]initWithFrame:CGRectZero];
//    [_centerContainerView addSubview:_maskButton];
//    _maskButton .alpha = 0;
//    [_maskButton setUserInteractionEnabled:NO];
//    _maskButton.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
//    [_maskButton addTarget:self action:@selector(_viewTaped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
    [self.view addSubview:_leftContainerView];
    [self.view sendSubviewToBack:_leftContainerView];
//    [_leftViewController viewWillAppear:animated];
//    [_rightViewController viewWillAppear:animated];
    [_centerContainerView bringSubviewToFront:_maskButton];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [_leftViewController viewDidAppear:animated];
//    [_rightViewController viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [_leftViewController viewWillDisappear:animated];
//    [_rightViewController viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    [_leftViewController viewDidDisappear:animated];
//    [_rightViewController viewDidDisappear:animated];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

    
    _centerContainerView.top=0;
    _centerContainerView.height = self.view.height;
    [_centerContainerView setNeedsLayout];
    
    _leftContainerView.left = 0;
    _rightContainerView.right = self.view.width;
    
    _maskButton .frame = _centerContainerView.bounds;
    
}


- (void)dealloc
{
    [_maskButton release];
    [_scrollView release];
    [_leftContainerView release];
    [_rightContainerView release];
//    [_centerContainerView release];
    [super dealloc];
}

#pragma mark setter/getter
- (void)setLeftViewController:(UIViewController *)leftViewController{
    if (leftViewController == nil) {
        [_leftViewController .view removeFromSuperview];
        STRONG_ASSIGN(_leftViewController, leftViewController);
        _canShowLeft = false;
        return;
    }
    [_leftViewController.view removeFromSuperview];
    STRONG_ASSIGN(_leftViewController, leftViewController);
    leftViewController.view.height = self.view.height;      //?高度应该不需要在这里设置
    [leftViewController.view layoutSubviews];
    _leftContainerView .frame = leftViewController .view .bounds; //?
    [_leftContainerView addSubview:leftViewController .view];
    _canShowLeft = true;
}
- (void)setRightViewController:(UIViewController *)rightViewController{
    if (rightViewController == nil) {
        [_rightViewController .view removeFromSuperview];
        STRONG_ASSIGN(_rightViewController, rightViewController);
        _canShowRight = false;
        return;
    }
    [rightViewController.view removeFromSuperview];
    STRONG_ASSIGN(_rightViewController, rightViewController);
    rightViewController.view.height = self.view.height;
    [rightViewController.view layoutSubviews];
    _rightContainerView .frame = rightViewController .view .bounds; //?
    [_rightContainerView addSubview:rightViewController .view];
    _canShowRight = true;
}
#pragma mark private method
- (void)_viewPanedProcess:(UIPanGestureRecognizer*) recognizer{
    CGPoint translation = [recognizer translationInView:self.view];
    //    float center_left  = _centerContainerView.left - _leftContainerView.width;
//    float center_left = _centerContainerView.left + _leftContainerView.width; //中间view相对屏幕左边距离
    float center_left = _centerContainerView.left;
    if (center_left>0) {
        if (_rightContainerView.superview ) {
            [_rightContainerView removeFromSuperview];
            [self.view addSubview:_leftContainerView];
            [self.view sendSubviewToBack:_leftContainerView];
        }

    }else{
        if (_leftContainerView.superview) {
            [_leftContainerView removeFromSuperview];
            [self.view addSubview:_rightContainerView];
            [self.view sendSubviewToBack:_rightContainerView];
        }
    }
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            //            _panGestureStartPoint = [recognizer locationInView:self.view];
            //            if (translation.x>0&&_status==LSUnderSideViewControllerStatusShowLeft) {
            //                _panValid = false;
            //            }
            //            if(translation.x<0&&_status==LSUnderSideViewControllerStatusShowRight){
            //                _panValid = false;
            //            }
            break;
        case UIGestureRecognizerStateChanged:
            //            if (!_panValid) {
            //                break;
            //            }
            //can show
            if (!((translation.x>0&&_canShowLeft)||(translation.x<=0&&_canShowRight)) ){
                return;
            }
            if (_status==LSUnderSideViewControllerStatusShowLeft&&center_left + translation.x<0) {
                _centerContainerView .left = _leftContainerView.width;
                break;
            }
            if (_status==LSUnderSideViewControllerStatusShowRight&&center_left + translation.x>0) {
                _centerContainerView .left = _leftContainerView.width;
                break;
            }
    
            if (center_left>_leftContainerView.width) {
                float delta = center_left-_leftContainerView.width;
                _centerContainerView .left += translation.x/delta;
                break;
            }
            if (center_left<-_rightContainerView.width) {
                float delta = -center_left-_leftContainerView.width;
                _centerContainerView .left += translation.x/delta;
                break;
            }
            _centerContainerView .left += translation.x/2;
            break;
            
        case UIGestureRecognizerStateEnded:{
            //            if (!_panValid) {
            //                _panValid = true;
            //                return;
            //            }
            CGPoint velocity = [recognizer velocityInView:self.view];
            
            if (_status==LSUnderSideViewControllerStatusShowLeft&&velocity.x<-750) {
                [self hideLeftAnimate:YES];
                break;
            }
            if (_status==LSUnderSideViewControllerStatusShowRight&&velocity.x>750) {
                [self hideRightAnimate:YES];
                break;
            }
            if (_leftViewController && ( center_left >= _leftContainerView.width/2||(_status==LSUnderSideViewControllerStatusShowCenter&&velocity.x>750))) {
                if (_canShowLeft) [self showLeftAnimate:YES];
            }else if(_rightViewController && (-center_left >= _rightContainerView.width/2||(_status==LSUnderSideViewControllerStatusShowCenter&& velocity.x<-750))){
                if (_canShowRight) [self showRightAnimate:YES];
            }else{
                [self hideLeftAnimate:YES];
                [self hideRightAnimate:YES];
            }
            break;
        }
        default:
            break;
    }
    [recognizer setTranslation:CGPointZero inView:self.view];
}

- (void)_viewTaped:(id)sender{
    [self hideLeftAnimate:YES];
    [self hideRightAnimate:YES];
}
#pragma mark method
- (void)showLeftAnimate:(BOOL)animate{
    if ([_delegate respondsToSelector:@selector(underSideViewControllerShouldShowLeft:)]) {
        if (![_delegate underSideViewControllerShouldShowLeft:self]){
            return ;
        }
    }
    if ([_delegate respondsToSelector:@selector(underSideViewControllerWillShowLeft:)]) {
        [_delegate underSideViewControllerWillShowLeft:self];
    }
    if (_rightContainerView.superview ) {
        [_rightContainerView removeFromSuperview];
        [self.view addSubview:_leftContainerView];
        [self.view sendSubviewToBack:_leftContainerView];
    }
    _status = LSUnderSideViewControllerStatusShowLeft;
    [self showMask];
    [UIView animateWithDuration:0.3 animations:^{
        _centerContainerView .left = DeviceWidth;
    } completion:^(BOOL finished) {
        if ([_delegate respondsToSelector:@selector(underSideViewControllerDidShowLeft:)]) {
            [_delegate underSideViewControllerDidShowLeft:self];
        }
    }];
}
- (void)hideLeftAnimate:(BOOL)animate{
    _status = LSUnderSideViewControllerStatusShowCenter;
    [self hideMask];
    //    if (_centerContainerView .left>0) {
    [UIView animateWithDuration:0.3 animations:^{
        _centerContainerView .left = 0;
    }];
    //    }
}
- (void)showRightAnimate:(BOOL)animate{
    if ([_delegate respondsToSelector:@selector(underSideViewControllerShouldShowRight:)]) {
        if (![_delegate underSideViewControllerShouldShowRight:self]){
            return ;
        }
    }
    if ([_delegate respondsToSelector:@selector(underSideViewControllerWillShowRight:)]) {
        [_delegate underSideViewControllerWillShowRight:self];
    }
    if (_leftContainerView.superview) {
        [_leftContainerView removeFromSuperview];
        [self.view addSubview:_rightContainerView];
        [self.view sendSubviewToBack:_rightContainerView];
    }
    _status = LSUnderSideViewControllerStatusShowRight;
    [self showMask];
    [UIView animateWithDuration:0.3 animations:^{
        //        _centerContainerView .left = -_rightContainerView.width + _leftContainerView.width;
        _centerContainerView.left = -_rightContainerView.width;
        
    } completion:^(BOOL finished) {
        if ([_delegate respondsToSelector:@selector(underSideViewControllerDidShowRight:)]) {
            [_delegate underSideViewControllerDidShowRight:self];
        }
    }];
}
- (void)hideRightAnimate:(BOOL)animate{
    _status = LSUnderSideViewControllerStatusShowCenter;
    [self hideMask];
    //    if (_centerContainerView .left<0) {
    [UIView animateWithDuration:0.3 animations:^{
        _centerContainerView .left = 0;
    }];
    //    }
    
}
- (void)showMask{
    [UIView animateWithDuration:0.3 animations:^{
        _maskButton.alpha=1;
        [_maskButton setUserInteractionEnabled:YES];
    }];
}

- (void)hideMask{
    [UIView animateWithDuration:0.3 animations:^{
        _maskButton.alpha=0;
        [_maskButton setUserInteractionEnabled:NO];
    }];
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return _enableGesture;
}
@end


@implementation LSUnderSideViewController (Convinence)

- (void)showLeft{
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(_viewPanedProcess:)];
    _panGestureRecognizer.delegate = self;
    [_centerContainerView addGestureRecognizer:_panGestureRecognizer];
    
    
    
    _maskButton = [[UIButton alloc]initWithFrame:self.view.frame];
    [_centerContainerView addSubview:_maskButton];
    _maskButton .alpha = 1;
    [_maskButton setUserInteractionEnabled:NO];
    _maskButton.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [_maskButton addTarget:self action:@selector(_viewTaped:) forControlEvents:UIControlEventTouchUpInside];
    [self showLeftAnimate:YES];
}
- (void)hideLeft{
    [self hideLeftAnimate:YES];
}
- (void)showRight{
    [self showRightAnimate:YES];
}
- (void)hideRight{
    [self hideRightAnimate:YES];
}

@end