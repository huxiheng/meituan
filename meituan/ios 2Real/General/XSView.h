//
//  XSView.h
//  Xieshi
//
//  Created by Tesiro on 16/7/13.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSView : UITableViewHeaderFooterView

+ (NSString *)viewIdentifier;
@property (strong, nonatomic)id model;
@property (strong, nonatomic)UIView *viewLine;
- (void)addLineView:(CGRect)frame;
- (void)initSubviews;    //override

/**
 *  加载视图数据
 *
 *  @param model model description
 */
- (void)reloadDataForView:(id)model;   //override

@end
