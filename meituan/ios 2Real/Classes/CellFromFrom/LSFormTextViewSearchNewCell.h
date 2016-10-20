//
//  LSFormTextViewSearchNewCell.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/1.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSFormCell.h"
#import "EditInputTextView.h"

@protocol ACEExpandableTableViewDelegate <UITableViewDelegate>

@required
- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath;

@end

@interface LSFormTextViewSearchNewCell : LSFormCell<UITextViewDelegate,UITextViewDelegate>{
    CGFloat widthTitle;
}
@property (nonatomic, strong)UIView     *viewBG;
@property (nonatomic, strong)UIView     *viewSecondBG;
@property (nonatomic, strong)UILabel    *labelTitle;
@property (nonatomic, strong)UIImageView *imageViewBottom;
@property (nonatomic, strong)UITextView  *textComment;

@property (nonatomic, copy)NSString     *strTitle;
@property (nonatomic)float   textViewHeight;
@property (nonatomic, copy) NSString *text;

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label andHeight:(NSString *)height;

@end
