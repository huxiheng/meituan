//
//  ReportCheckTabelCell.m
//  Xieshi
//
//  Created by Tesiro on 16/7/13.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "ReportCheckTabelCell.h"

@implementation ReportCheckTabelCell

- (void)initSubviews {
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 50)];
    [self.contentView addSubview:self.viewBG];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(kscaleDeviceLength(18), 5, DeviceWidth-kscaleDeviceLength(36), 15)];
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_999999];
    self.labelTitle.font = themeFont14;
    [self.viewBG addSubview:self.labelTitle];
    
    self.labelContent = [[UILabel alloc] initWithFrame: CGRectMake(kscaleDeviceLength(18), 29, DeviceWidth-kscaleDeviceLength(36), 16)];
    self.labelContent.font = themeFont16;
    self.labelContent.numberOfLines = 0;
    self.labelContent.textColor = [UIColor colorWithHexString:kc00_333333];
    [self.viewBG addSubview:self.labelContent];
    
//    [self addLineView:CGRectMake(0, 64.5, DeviceWidth, 0.5)];
    self.viewLineBottom = [[UIView alloc] initWithFrame:CGRectZero];
    self.viewLineBottom.backgroundColor =kcolorLine;
    [self addSubview:self.viewLineBottom];
}

- (void)reloadDataForCell:(id)model {
    self.model = model;
    self.labelTitle.text = ((XSCellModel *)self.model).title;
    self.labelContent.text =((XSCellModel *)self.model).content;
    if (((XSCellModel *)self.model).tagColor == YES) {
        self.viewBG.backgroundColor = [UIColor colorWithHexString:kcolorBJ_f0eff4];
    }else{
        self.viewBG.backgroundColor = [UIColor whiteColor];
    }
    if (((XSCellModel *)self.model).heightcontent>25) {
        self.labelContent.frame = CGRectMake(kscaleDeviceLength(18), 29, DeviceWidth-kscaleDeviceLength(36), 40);
        self.viewBG.frame = CGRectMake(0, 0, DeviceWidth, 74);
        self.viewLineBottom.frame =CGRectMake(0, 73.5, DeviceWidth, 0.5);
    }else {
        self.labelContent.frame = CGRectMake(kscaleDeviceLength(18), 29, DeviceWidth-kscaleDeviceLength(36), 16);
        self.viewBG.frame = CGRectMake(0, 0, DeviceWidth, 50);
        self.viewLineBottom.frame =CGRectMake(0, 49.5, DeviceWidth, 0.5);
    }
}

@end
