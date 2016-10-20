//
//  LeftVCCollectionHeaderView.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/19.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSCollectionHeaderFooterView.h"
@protocol LeftviewcontrollerClickHeadDelegate;

@interface LeftVCCollectionHeaderView : XSCollectionHeaderFooterView
@property (nonatomic, strong)UIView   *viewBG;
@property (nonatomic, strong)UIImageView  *imageviewHeader;
@property (nonatomic, strong)UILabel      *labelTitle;
@property(nonatomic,assign) id<LeftviewcontrollerClickHeadDelegate> delegateClickHead;
@end

@protocol LeftviewcontrollerClickHeadDelegate <NSObject>

- (void)leftviewController:(LeftVCCollectionHeaderView *)hesderVC didSelectHead:(UIImageView *)imageheader;

@end