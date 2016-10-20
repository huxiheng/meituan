//
//  LSFormDateUnqualifyCell.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/29.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSFormCell.h"



#define TimeDateCell(__key,__label) [LSFormDateUnqualifyCell mapperWithCellName:CellNameKeyed(__key) keyName:__key label:__label]
@interface LSFormDateUnqualifyCell : LSFormCell{
   
}
@property (nonatomic, strong)UIView         *viewBG;
@property (nonatomic, strong)UILabel        *labelTitle;
@property (nonatomic, strong)UILabel        *labelContent;

@property (nonatomic, copy)NSString         *strTitle;

@property (nonatomic, copy)NSString         *dateTimeType;

@property(nonatomic,retain) NSString *dateFormat;

@property (nonatomic, assign)UIDatePickerMode type;

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label dateType:(NSString *)dateType;
@end
