//
//  LSFormSwitchNewCell.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/25.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSFormCell.h"

#define SwitchNewCell(__keyName,__label) [LSFormSwitchNewCell mapperWithCellName:CellNameKeyed(__keyName) keyName:__keyName]

@interface LSFormSwitchNewCell : LSFormCell
@property (nonatomic, strong)UIView   *viewBG;
@property (nonatomic, strong)UIView   *viewSecond;
@property (nonatomic, strong)UILabel  *labelTitle;
@property (nonatomic, strong)UIButton *btnYes;
@property (nonatomic, strong)UIButton *btnNo;
@property (nonatomic, assign)BOOL     isStatus;

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName;

@end
