//
//  XMGPresentationController.h
//  DItuProjectText
//
//  Created by Tesiro on 16/10/11.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSPresentationController : UIPresentationController
@property (nonatomic, strong)UIViewController *XSpresentedViewController;
@property (nonatomic,strong)UIButton *btnPresent;
@property (nonatomic, assign)CGRect frameForPresent;

@end
