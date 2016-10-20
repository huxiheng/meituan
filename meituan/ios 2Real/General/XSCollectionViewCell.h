//
//  XSCollectionViewCell.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/19.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSCollectionViewCell : UICollectionViewCell
/**
 *  cell标示符
 *
 *  @return return value description
 */
+ (NSString *)cellIdentifier;
@property (strong, nonatomic)id model;
//@property (strong, nonatomic)UIView *viewLine;
- (void)initSubviews;    //override

/**
 *  加载cell的数据
 *
 *  @param model model description
 */
- (void)reloadDataForCell:(id)model;  //override

@end
