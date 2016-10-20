//
//  LSSideViewController.m
//  LSLab
//
//  Created by Lessu on 13-5-8.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSSideViewController.h"
#import "UIView+Sizes.h"
@interface LSSideViewController ()
{
    UIView *_leftContainerView;
    UIView *_rightContainerView;
    UIView *_centerContainerView;
    UIView *_contentContainerView;
    UIScrollView *_scrollView;
    
    UIPanGestureRecognizer *_panGestureRecognizer;
    UITapGestureRecognizer *_tapGestureRecognizer;
    CGPoint                 _panGestureStartPoint;
    
    UIButton                *_maskButton;
//    BOOL                    _panValid;
}
@end

@implementation LSSideViewController

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
    _status = LSSideViewControllerStatusShowCenter;
    if (!_centerContainerView) {
        _centerContainerView = [self.view retain];
    }
    _centerContainerView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;

    self.view = [[[UIView alloc]initWithFrame:self.view.frame] autorelease];
    [self.view setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    [self.view setClipsToBounds:YES];
    
    _leftContainerView = [[UIView alloc]initWithFrame:CGRectZero];
    _rightContainerView =[[UIView alloc]initWithFrame:CGRectZero];
    _contentContainerView = [[UIView alloc]initWithFrame:_centerContainerView.frame];
    
    [_contentContainerView addSubview:_leftContainerView];
    [_contentContainerView addSubview:_rightContainerView];
    [_contentContainerView addSubview:_centerContainerView];
    [self.view addSubview:_contentContainerView];
    
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(_viewPanedProcess:)];
    [_contentContainerView addGestureRecognizer:_panGestureRecognizer];
    
//    _tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_viewTaped:)];
//    [_centerContainerView addGestureRecognizer:_tapGestureRecognizer];
    
    _maskButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [_centerContainerView addSubview:_maskButton];
    _maskButton .alpha = 0;
    [_maskButton setUserInteractionEnabled:NO];
    _maskButton.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [_maskButton addTarget:self action:@selector(_viewTaped:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
    [_leftViewController viewWillAppear:animated];
    [_rightViewController viewWillAppear:animated];
//    [_scrollView setContentOffset:CGPointMake(_leftContainerView.width, 0)];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_leftViewController viewDidAppear:animated];
    [_rightViewController viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_leftViewController viewWillDisappear:animated];
    [_rightViewController viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_leftViewController viewDidDisappear:animated];
    [_rightViewController viewDidDisappear:animated];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _contentContainerView.height = self.view.height;        
    _contentContainerView.top    = self.view.top;           
    
    _centerContainerView.top=0;
    _centerContainerView.height = _contentContainerView.height;
    _centerContainerView.left = _leftContainerView.width;
    [_centerContainerView setNeedsLayout];
    
    _leftContainerView.left = 0;

    _rightContainerView.left = _leftContainerView.width + _centerContainerView.width;
    _maskButton .frame = _centerContainerView.bounds;
    _contentContainerView.frame = CGRectMake(-_leftContainerView.width,0, _leftContainerView.width+_centerContainerView.width+_rightContainerView.width,  _contentContainerView.height);
//    LS_CAST(UIScrollView *,self.view).contentSize = CGSizeMake(_leftContainerView.width+self.view.width+_rightContainerView.width, self.view.height);

}


- (void)dealloc
{
    [_maskButton release];
    [_scrollView release];
    [_leftContainerView release];
    [_rightContainerView release];
    [_contentContainerView release];
    [super dealloc];
}
#pragma mark setter/getter
- (void)setLeftViewController:(UIViewController *)leftViewController{
    STRONG_ASSIGN(_leftViewController, leftViewController);
    leftViewController.view.height = self.view.height;      //?高度应该不需要在这里设置
    [leftViewController.view layoutSubviews];
    _leftContainerView .frame = leftViewController .view .bounds; //?
    
    
    [_leftContainerView addSubview:leftViewController .view];
}
- (void)setRightViewController:(UIViewController *)rightViewController{
    STRONG_ASSIGN(_rightViewController, rightViewController);
    rightViewController.view.height = self.view.height;
    [rightViewController.view layoutSubviews];
    _rightContainerView .frame = rightViewController .view .bounds; //?
    [_rightContainerView addSubview:rightViewController .view];
}
#pragma mark private method
- (void)_viewPanedProcess:(UIPanGestureRecognizer*) recognizer{
    CGPoint translation = [recognizer translationInView:self.view];
//    float center_left  = _contentContainerView.left - _leftContainerView.width;
    float center_left = _contentContainerView.left + _leftContainerView.width; //中间view相对屏幕左边距离

    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
//            _panGestureStartPoint = [recognizer locationInView:self.view];
//            if (translation.x>0&&_status==LSSideViewControllerStatusShowLeft) {
//                _panValid = false;
//            }
//            if(translation.x<0&&_status==LSSideViewControllerStatusShowRight){
//                _panValid = false;
//            }
            break;
        case UIGestureRecognizerStateChanged:
//            if (!_panValid) {
//                break;
//            }
            if (_status==LSSideViewControllerStatusShowLeft&&center_left + translation.x<0) {
                _contentContainerView .left = _leftContainerView.width;
                break;
            }
            if (_status==LSSideViewControllerStatusShowRight&&center_left + translation.x>0) {
                _contentContainerView .left = _leftContainerView.width;
                break;
            }
            if (center_left>_leftContainerView.width) {
                float delta = center_left-_leftContainerView.width;
                _contentContainerView .left += translation.x/delta;
                break;
            }
            if (center_left<-_rightContainerView.width) {
                float delta = -center_left-_leftContainerView.width;
                _contentContainerView .left += translation.x/delta;
                break;
            }
            _contentContainerView .left += translation.x/2;
            break;
        
        case UIGestureRecognizerStateEnded:{
//            if (!_panValid) {
//                _panValid = true;
//                return;
//            }
            CGPoint velocity = [recognizer velocityInView:self.view];
            
            if (_status==LSSideViewControllerStatusShowLeft&&velocity.x<-750) {
                [self hideLeftAnimate:YES];
                break;
            }
            if (_status==LSSideViewControllerStatusShowRight&&velocity.x>750) {
                [self hideRightAnimate:YES];
                break;
            }
            if (_leftViewController && ( center_left >= _leftContainerView.width/2||(_status==LSSideViewControllerStatusShowCenter&&velocity.x>750))) {
                [self showLeftAnimate:YES];
            }else if(_rightViewController && (-center_left >= _rightContainerView.width/2||(_status==LSSideViewControllerStatusShowCenter&& velocity.x<-750))){
                [self showRightAnimate:YES];
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
    if ([_delegate respondsToSelector:@selector(sideViewControllerShouldShowLeft:)]) {
        if (![_delegate sideViewControllerShouldShowLeft:self]){
            return ;
        }
    }
    if ([_delegate respondsToSelector:@selector(sideViewControllerWillShowLeft:)]) {
        [_delegate sideViewControllerWillShowLeft:self];
    }
    _status = LSSideViewControllerStatusShowLeft;
    [self showMask];
    [UIView animateWithDuration:0.3 animations:^{
        _contentContainerView .left = 0;
    } completion:^(BOOL finished) {
        if ([_delegate respondsToSelector:@selector(sideViewControllerDidShowLeft:)]) {
            [_delegate sideViewControllerDidShowLeft:self];
        }
    }];
}
- (void)hideLeftAnimate:(BOOL)animate{
    _status = LSSideViewControllerStatusShowCenter;
    [self hideMask];
//    if (_contentContainerView .left>0) {
        [UIView animateWithDuration:0.3 animations:^{
            _contentContainerView .left = - _leftContainerView.width;
        }];
//    }
}
- (void)showRightAnimate:(BOOL)animate{
    if ([_delegate respondsToSelector:@selector(sideViewControllerShouldShowRight:)]) {
        if (![_delegate sideViewControllerShouldShowRight:self]){
            return ;
        }
    }
    if ([_delegate respondsToSelector:@selector(sideViewControllerWillShowRight:)]) {
        [_delegate sideViewControllerWillShowRight:self];
    }
    _status = LSSideViewControllerStatusShowRight;
    [self showMask];
    [UIView animateWithDuration:0.3 animations:^{
//        _contentContainerView .left = -_rightContainerView.width + _leftContainerView.width;
        _contentContainerView.left = - _leftContainerView.width -_rightContainerView.width;
        
    } completion:^(BOOL finished) {
        if ([_delegate respondsToSelector:@selector(sideViewControllerDidShowRight:)]) {
            [_delegate sideViewControllerDidShowRight:self];
        }
    }];
}
- (void)hideRightAnimate:(BOOL)animate{
    _status = LSSideViewControllerStatusShowCenter;
    [self hideMask];
//    if (_contentContainerView .left<0) {
        [UIView animateWithDuration:0.3 animations:^{
            _contentContainerView .left = - _leftContainerView.width;
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
@end


@implementation LSSideViewController (Convinence)

- (void)showLeft{
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