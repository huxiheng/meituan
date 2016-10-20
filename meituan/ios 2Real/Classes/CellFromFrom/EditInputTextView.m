//
//  EditInputTextView.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/27.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "EditInputTextView.h"

@implementation EditInputTextView
- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        self.strTitle = title;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    self.textViewHeight = 31.0;
    
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 68)];
    self.viewBG.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:249.0/255.0 blue:251.0/255.0 alpha:1.0];
    [self addSubview:self.viewBG];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 60, 37)];
    self.labelTitle.font = themeFont17;
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_999999];
    NSString *strTitle = [NSString stringWithFormat:@"%@：",self.strTitle];
    self.labelTitle.text = strTitle;
     widthTitle = [NSString calculateTextWidth:37 Content:strTitle font:themeFont17];
    self.labelTitle.frame = CGRectMake(15, 15, widthTitle+5, 37);
    [self.viewBG addSubview:self.labelTitle];
    
    
    self.textComment = [[UITextView alloc] initWithFrame:CGRectMake(widthTitle+5+15+5, 15, DeviceWidth-widthTitle-5-30-10, self.textViewHeight)];
    self.textComment.font = themeFont17;
    self.textComment.delegate = self;
    self.textComment.scrollEnabled = NO;
    self.textComment.autoresizingMask =UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.textComment.showsVerticalScrollIndicator = NO;
    self.textComment.showsHorizontalScrollIndicator = NO;
    self.textComment.backgroundColor = [UIColor clearColor];
    [self.viewBG addSubview:self.textComment];
    
    self.imageBottom = [[UIImageView alloc] initWithFrame:CGRectMake(widthTitle+5+15, self.textViewHeight+15, DeviceWidth-widthTitle-5-30, 6)];
    self.imageBottom.image = [UIImage imageNamed:@"unqualifywenbenkuang"];
    [self.viewBG addSubview:self.imageBottom];
    
    self.viewBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 67.5, DeviceWidth, 0.5)];
    self.viewBottomLine.backgroundColor = kcolorLine;
    [self.viewBG addSubview:self.viewBottomLine];
}

- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"%f",textView.contentSize.height);
    
    self.textViewHeight =MIN(40, textView.contentSize.height-3);
    [self updateFrame];
    self.updateSuviewsFrame(self.textComment);
    
    [self.textComment isFirstResponder];
    [self isFirstResponder];
    //    textView.frame =CGRectMake(10, 30, 300, textView.contentSize.height-3);
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.textViewHeight =MIN(40, textView.contentSize.height-3);
    self.textViewHeight =MAX(self.textViewHeight, 31.0f);
    [self updateFrame];
    self.blockBeginEditting();
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    self.blockGetTextView(textView.text);
    [self.textComment isFirstResponder];
}

- (void)updateFrame {
    self.frame = CGRectMake(0, 0, DeviceWidth, self.textViewHeight+37);
    self.viewBottomLine.frame = CGRectMake(0, self.textViewHeight+37-0.5, DeviceWidth, 0.5);
    self.viewBG.frame =CGRectMake(0, 0, DeviceWidth, self.textViewHeight+37);
    self.textComment.frame = CGRectMake(widthTitle+15+5, 15, DeviceWidth-widthTitle-5-30-10, self.textViewHeight);
    self.imageBottom.frame =CGRectMake(widthTitle+15, self.textViewHeight+15, DeviceWidth-widthTitle-5-30, 6);
    
}



@end
