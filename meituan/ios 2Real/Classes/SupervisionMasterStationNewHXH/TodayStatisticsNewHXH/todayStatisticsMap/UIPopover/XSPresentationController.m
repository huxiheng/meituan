//
//  XMGPresentationController.m
//  DItuProjectText
//
//  Created by Tesiro on 16/10/11.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import "XSPresentationController.h"

@implementation XSPresentationController
-(void)containerViewDidLayoutSubviews{
    [super containerViewDidLayoutSubviews];
    
    self.presentedView.frame = _frameForPresent;
    self.XSpresentedViewController = self.presentedViewController;
    //添加蒙板
    [self setUpCoverView];
}

-(void)setUpCoverView{
    UIView *coverView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    [self.containerView insertSubview:coverView atIndex:0];
    
    coverView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.0];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewClick)];
    [coverView addGestureRecognizer:tapGes];
}

-(void)coverViewClick{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
