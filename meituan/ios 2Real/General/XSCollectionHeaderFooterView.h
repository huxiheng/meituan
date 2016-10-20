//
//  XSCollectionHeaderFooterView.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/19.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSCollectionHeaderFooterView : UICollectionReusableView
+ (NSString *)viewIdentifier;
@property (strong, nonatomic)id model;
//@property (strong, nonatomic)UIView *viewLine;
- (void)initSubviews;    //override

/**
 *  加载cell的数据
 *
 *  @param model model description
 */
- (void)reloadDataForView:(id)model;  //override
@end
