//
//  XSActionSheet.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/27.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HiddenView) ();

@interface XSActionSheet : UIView
- (void)showInView:(UIView *)superView;
- (void)hiddenSelf;

@property (nonatomic, strong)UIView         *viewUpdateVersion;
@property (nonatomic, strong)UIView     *shadowView;//阴影背景
@property (nonatomic, strong)UIView     *viewRemoveCountBind;
@property (strong, nonatomic)UIView  *setPhotoView;   ///设置照相

@property (nonatomic, strong)XSNavigationViewController *navVC;
@property (nonatomic, copy)HiddenView     hiddenBlock;

@end
