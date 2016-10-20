//
//  EditInputTextView.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/27.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BlockGetTextView) (NSString *str);
typedef void (^updateSubviewFrameBlock)(UITextView *model);
typedef void (^BlockBeginEditting)();
@interface EditInputTextView : UIView<UITextViewDelegate>{
    CGFloat widthTitle;
}
@property (nonatomic, strong)UIView      *viewBG;
@property (nonatomic, strong)UITextView  *textComment;
@property (nonatomic, strong)UIImageView *imageBottom;
@property (nonatomic, strong)UILabel     *labelTitle;
@property (nonatomic, strong)UIView      *viewBottomLine;
@property (nonatomic, copy)NSString      *strTitle;
@property (nonatomic)float   textViewHeight;
@property (nonatomic, strong)BlockGetTextView  blockGetTextView;
@property (nonatomic, strong)updateSubviewFrameBlock updateSuviewsFrame;
@property (nonatomic, strong)BlockBeginEditting    blockBeginEditting;

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title;
- (void)updateFrame;
@end
