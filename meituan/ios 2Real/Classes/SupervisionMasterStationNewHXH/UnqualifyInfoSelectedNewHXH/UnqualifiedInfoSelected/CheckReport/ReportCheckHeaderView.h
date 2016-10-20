//
//  ReportCheckHeaderView.h
//  Xieshi
//
//  Created by Tesiro on 16/7/13.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSView.h"

typedef void(^BlockClickBG) ();
@interface ReportCheckHeaderView : XSView
@property (nonatomic, strong)UIView    *viewBG;
@property (nonatomic, strong)UIImageView *imageViewHeade;
@property (nonatomic, strong)UILabel     *labelTitle;
@property (nonatomic, strong)UIImageView *imageViewEntrance;

@property (nonatomic, strong)BlockClickBG  blockClickBG;

@end
