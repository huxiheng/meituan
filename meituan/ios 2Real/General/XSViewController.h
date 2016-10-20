//
//  XSViewController.h
//  Xieshi
//
//  Created by Tesiro on 16/7/12.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface XSViewController : UIViewController

@property (nonatomic, strong)UILabel  *labelNavTitle;
@property (nonatomic, copy)NSString   *titleForNav;

/**
 *  设置导航条的leftiterm
 *
 *  @param str   str description
 *  @param image image description
 */
- (void)setNavLeftItemWith:(NSString *)str andImage:(UIImage *)image;

/**
 *  设置导航的rightitem
 *
 *  @param str   str description
 *  @param image image description
 */
- (void)setNavRightItemWith:(NSString *)str andImage:(UIImage *)image;
- (void)setNavRightItems:(NSArray *)arrays;

- (void)setData;

- (void)rightItemClick:(id)sender;
- (void)rightItem2Click:(id)sender;
- (void)leftItemClick:(id)sender;



@end
