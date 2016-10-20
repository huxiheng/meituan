//
//  XSVersionUpdateView.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/27.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSVersionUpdateView : UIView
@property (nonatomic, strong)UIView         *viewBG;
@property (nonatomic, strong)UIImageView    *imageViewRight;
@property (nonatomic, strong)UILabel        *labelTitle;
@property (nonatomic, strong)UIButton       *btnSure;

@property (nonatomic, copy)NSString         *strImageName;
@property (nonatomic, copy)NSString         *strTitle;

- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title;


@end
