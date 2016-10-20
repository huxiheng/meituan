//
//  XSActionSheet.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/27.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSActionSheet.h"

@interface XSActionSheet ()


@end

@implementation XSActionSheet
- (void)showInView:(UIView *)superView{
    if (!self.shadowView) {
        self.shadowView = [[UIView alloc] initWithFrame:self.frame];
        self.shadowView.backgroundColor = [UIColor blackColor];
        self.shadowView.alpha = 0.5;
         [self addSubview:self.shadowView];
    }
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    tap.cancelsTouchesInView = NO;
    [self.shadowView addGestureRecognizer:tap];
    
    if (self.viewUpdateVersion) {
        self.viewUpdateVersion.frame = CGRectMake((DeviceWidth-kscaleDeviceWidth(260))/2, (DeviceHeight-190)/2, kscaleDeviceWidth(260), 190);
        [self addSubview:self.shadowView];
        [self addSubview:self.viewUpdateVersion];
        [superView addSubview:self];
    }
    
    if (self.viewRemoveCountBind) {
        self.viewRemoveCountBind.frame = CGRectMake((DeviceWidth-kscaleDeviceWidth(288))/2, (DeviceHeight-190)/2, kscaleDeviceWidth(288), 190);
        [self addSubview:self.shadowView];
        [self addSubview:self.viewRemoveCountBind];
        [superView addSubview:self];
    }
    
    if (self.setPhotoView) {
        [self addSubview:self.shadowView];
        [self addSubview:self.setPhotoView];
        [superView addSubview:self];
        self.setPhotoView.frame = CGRectMake(0, DeviceHeight, self.setPhotoView.frame.size.width, self.setPhotoView.frame.size.height);
        [UIView animateWithDuration:0.3 animations:^{
            self.shadowView.alpha = 0.4;
            self.setPhotoView.frame = CGRectMake(0, DeviceHeight-self.setPhotoView.frame.size.height, DeviceWidth, self.frame.size.height);
        }completion:^(BOOL finished){
            
        }];
    }
    
    if (self.navVC) {
        self.navVC.interactivePopGestureRecognizer.enabled = NO;
    }
    
}

- (void)singleTap:(id)sender {
    [self hiddenSelf];
}

- (void)hiddenSelf {
    self.shadowView = nil;
    
    if (self.navVC) {
        self.navVC.interactivePopGestureRecognizer.enabled = YES;
    }
    if (self.viewUpdateVersion) {
        [UIView animateWithDuration:0.3 animations:^{
            self.shadowView.alpha = 0;
            
        } completion:^(BOOL finished) {
            for (UIView *subView in self.subviews) {
                [subView removeFromSuperview];
            }
            [self removeFromSuperview];
        }];
    }
    
    if (self.viewRemoveCountBind) {
        [UIView animateWithDuration:0.3 animations:^{
            self.shadowView.alpha = 0;
            [self.viewRemoveCountBind removeFromSuperview];
            
        } completion:^(BOOL finished) {
            for (UIView *subView in self.subviews) {
                [subView removeFromSuperview];
                
            }
            self.viewRemoveCountBind = nil;
            [self removeFromSuperview];
        }];
    }
    
    if (self.setPhotoView) {
        [UIView animateWithDuration:0.3 animations:^{
            self.shadowView.alpha =0.0;
            self.setPhotoView.frame =CGRectMake(0, DeviceHeight, self.setPhotoView.frame.size.width, self.setPhotoView.frame.size.height);
        } completion:^(BOOL finished) {
            for (UIView *subview in self.subviews) {
                [subview removeFromSuperview];
            }
            [self removeFromSuperview];
        }];
    }
}


@end
