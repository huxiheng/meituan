//
//  LSFormTextFieldUnqualifyCell.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/27.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSFormCell.h"
#import "EditInputTextView.h"

#define TextFieldUnqualifyCell(__key,__titleNew) [LSFormTextFieldUnqualifyCell mapperWithCellName:CellNameKeyed(__key) keyName:__key label:__titleNew ]
@protocol ACEExpandableTableViewDelegate <UITableViewDelegate,UITextViewDelegate>

@required
- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath;

@end

@interface LSFormTextFieldUnqualifyCell : LSFormCell<UITextViewDelegate,UITextViewDelegate>{
    CGFloat widthTitle;
}
@property (nonatomic, strong)UIView      *viewBG;
@property (nonatomic, strong)UITextView  *textComment;
@property (nonatomic, strong)UIImageView *imageBottom;
@property (nonatomic, strong)UILabel     *labelTitle;
@property (nonatomic, strong)UIView      *viewBottomLine;
@property (nonatomic, copy)NSString      *strTitle;
@property (nonatomic)float   textViewHeight;


@property (nonatomic, readonly) CGFloat cellHeight;
@property (nonatomic, strong) NSString *text;


+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label ;
+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label andHeight:(NSString *)height;

@end
