//
//  LSFormSelectUnqualitifyNewCell.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/29.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSFormCell.h"
#define SelectNewCell(__keyName,__label,__mapper) [LSFormSelectUnqualitifyNewCell mapperWithCellName:CellNameKeyed(__keyName) keyName:__keyName label:__label andMapper:__mapper]
@interface LSFormSelectUnqualitifyNewCell : LSFormCell
@property(nonatomic,retain) NSDictionary* selectMapper;
@property (nonatomic,copy) NSString    *strTitle;

@property (nonatomic,strong)UILabel    *labelTitle;
@property (nonatomic, strong)UILabel   *labelContent;
@property (nonatomic,strong)UIView    *viewBottomLine;
@property (nonatomic, strong)UIImageView   *imageViewRight;

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label andMapper:(NSDictionary *)mapper;
@end
