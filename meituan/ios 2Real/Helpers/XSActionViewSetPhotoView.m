//
//  XSActionViewSetPhotoView.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/20.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSActionViewSetPhotoView.h"
#import "XSActionSheet.h"

#define ktagBtn 100
#define kbuttonHeight  44.0

@implementation XSActionViewSetPhotoView
- (instancetype)initWithArray:(NSArray *)arrayTitles{
    self= [super initWithFrame:CGRectMake(0, 0, DeviceWidth, kbuttonHeight*arrayTitles.count+10+44)];
    if (self) {
        self.backgroundColor = kcolorLine;
        self.arrayTitles = arrayTitles;
        [self load];
    }
    return self;
}

-(void)load{
    UIButton *buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCancel.frame = CGRectMake(0, self.frame.size.height-44, DeviceWidth, 44);
    //[buttonCancel setTintColor:[UIColor colorWithHexString:kc00_2c2c2c]];
    [buttonCancel setTitleColor:[UIColor colorWithHexString:kc00_2c2c2c] forState:UIControlStateNormal];
    [buttonCancel setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [buttonCancel setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:kbtnWhiteColorBJHighlightedState]] forState:UIControlStateHighlighted];
    buttonCancel.titleLabel.textAlignment = NSTextAlignmentCenter;
    buttonCancel.titleLabel.font = themeFont15;
    [buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
    [self addSubview:buttonCancel];
    [buttonCancel addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    for (int i=0; i<self.arrayTitles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 44*i, DeviceWidth, 44);
        [btn setTitleColor:[UIColor colorWithHexString:kc00_2c2c2c] forState:UIControlStateNormal];
        btn.tag= ktagBtn+i;
        [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:kbtnWhiteColorBJHighlightedState]] forState:UIControlStateHighlighted];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = themeFont15;
        [btn setTitle:self.arrayTitles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: btn];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43.7, DeviceWidth, 0.3)];
        lineView.backgroundColor = kcolorLine;
        [btn addSubview:lineView];
    }
}

-(void)btnClick:(UIButton *)button{
    self.blockSetPhoto(button.tag,button.titleLabel.text);
    XSActionSheet *supview =(XSActionSheet *)[self superview];
    [supview hiddenSelf];
}

@end
