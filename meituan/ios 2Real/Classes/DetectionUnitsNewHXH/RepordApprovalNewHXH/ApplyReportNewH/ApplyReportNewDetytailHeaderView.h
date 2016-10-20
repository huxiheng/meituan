//
//  ApplyReportNewDetytailHeaderView.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/4.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSView.h"

typedef void(^BlockClickBG) ();
@interface ApplyReportNewDetytailHeaderView : XSView
@property (nonatomic, strong)UIView         *viewBG;
@property (nonatomic, strong)UIImageView    *imageViewHeader;
@property (nonatomic, strong)UILabel        *labelTitle;
@property (nonatomic, strong)UIImageView    *imageviewEntrance;
@property (nonatomic, copy)BlockClickBG     blockClickBG;

@end
