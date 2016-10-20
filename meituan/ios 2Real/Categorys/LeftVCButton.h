//
//  LeftVCButton.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/19.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftVCButton : UIButton
@property (nonatomic, strong) UIImage *imageBtn;
@property (nonatomic, copy) NSString  *strTitle;
- (instancetype)initWithFrame:(CGRect)frame WitnImage:(UIImage*)imageBtn title:(NSString *)title;
@end
