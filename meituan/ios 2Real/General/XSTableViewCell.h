//
//  XSTableViewCell.h
//  Xieshi
//
//  Created by Tesiro on 16/7/13.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSTableViewCell : UITableViewCell
/**
 *  cell标示符
 *
 *  @return return value description
 */
+ (NSString *)cellIdentifier;

/**
 *  cell的高度
 *
 *  @param model model description
 *
 *  @return return value description
 */
+ (CGFloat)returnCellHeight:(id)model;


@property (strong, nonatomic)id model;
@property (strong, nonatomic)UIView *viewLine;
- (void)initSubviews;    //override

/**
 *  加载cell的数据
 *
 *  @param model model description
 */
- (void)reloadDataForCell:(id)model;  //override

- (void)addLineView:(CGRect)frame;

@end
