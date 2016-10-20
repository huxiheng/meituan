//
//  ApplyReportDetailNewVCCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/4.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "ApplyReportDetailNewVCCell.h"

@implementation ApplyReportDetailNewVCCell
- (void)initSubviews{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.viewBG = [[UIView   alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 49)];
    [self addSubview:self.viewBG];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, DeviceWidth-15, 13)];
    self.labelTitle.font = themeFont13;
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_999999];
    [self.viewBG addSubview:self.labelTitle];
    
    self.labelContent = [[UILabel alloc] initWithFrame:CGRectMake(15, 27, DeviceWidth-30, 15)];
    self.labelContent.font = themeFont15;
    self.labelContent.textColor = [UIColor colorWithHexString:kc00_333333];
    self.labelContent.numberOfLines = 0;
    [self.viewBG addSubview:self.labelContent];
    
    self.viewLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 48.5, DeviceWidth, 0.5)];
    self.viewLineBottom.backgroundColor = kcolorLine;
    [self.viewBG addSubview:self.viewLineBottom];
    
}

- (void)reloadDataForCell:(id)model{
    self.model = model;
    self.labelTitle.text = ((XSCellModel *)self.model).title;
    self.labelContent.text =((XSCellModel *)self.model).content;
    
    if (((XSCellModel *)self.model).tagColor==YES) {
        self.viewBG.backgroundColor = [UIColor colorWithHexString:kcolorBJ_f0eff4];
    }else{
        self.viewBG.backgroundColor = [UIColor whiteColor];
    }
    
    CGFloat heightContent = [NSString calculateTextHeight:DeviceWidth-30 Content:((XSCellModel *)self.model).content font:themeFont15];
    heightContent = heightContent+5>25?heightContent:15;
    self.viewBG.frame=CGRectMake(0, 0, DeviceWidth, heightContent+34);
    self.viewLineBottom.frame = CGRectMake(0, heightContent+34-0.5, DeviceWidth, 0.5);
    self.labelContent.frame =CGRectMake(15, 27, DeviceWidth-30, heightContent);
}

@end
