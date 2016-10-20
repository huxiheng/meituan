//
//  LSFormTextFieldNewCell.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/25.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSFormCell.h"

#define TextFieldNewCell(__key,__placeHold) [LSFormTextFieldNewCell mapperWithCellName:CellNameKeyed(__key) keyName:__key placeHold:__placeHold]

@interface LSFormTextFieldNewCell : LSFormCell<UITextFieldDelegate>

@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UIView      *viewBG;

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName placeHold:(NSString *)placeHold;

@end
