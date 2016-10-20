//
//  LSFormSelectChangeFrameSearchCell.h
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

@interface LSFormSelectChangeFrameSearchCell : LSFormCell{
    CGFloat widthTitle;
}
@property(nonatomic,retain) NSDictionary* selectMapper;
@property (nonatomic,copy) NSString    *strTitle;
@property (nonatomic)float   textViewHeight;
@property (nonatomic)float   heightBG;
@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong)UIView     *viewBG;
@property (nonatomic, strong)UIView     *viewSecondBG;
@property (nonatomic, strong)UILabel    *labelTitle;
@property (nonatomic, strong)UILabel    *labelContent;
@property (nonatomic, strong)UIImageView *imageViewIcon;


+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label andMapper:(NSDictionary *)mapper andHeight:(NSString *)height;
@end
