//
//  LSFormTextViewCell.h
//  YinfengShop
//
//  Created by lessu on 13-12-23.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFormCell.h"

#define TextViewCellCanEdit(__key,__height) [LSFormTextViewCell mapperWithCellName:CellNameKeyed(__key) keyName:__key andCanEdit:YES andHeight:__height]
#define TextViewCellNOEdit(__key,__height)  [LSFormTextViewCell mapperWithCellName:CellNameKeyed(__key) keyName:__key andCanEdit:NO andHeight:__height]

@interface LSFormTextViewCell : LSFormCell<UITextViewDelegate>
@property(nonatomic,retain) UITextView* textView;

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName andCanEdit:(BOOL)canEdit andHeight:(CGFloat)height;

@end