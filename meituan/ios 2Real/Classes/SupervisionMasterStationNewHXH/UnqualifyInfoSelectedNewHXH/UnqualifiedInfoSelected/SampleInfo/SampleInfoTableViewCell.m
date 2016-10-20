//
//  SampleInfoTableViewCell.m
//  Xieshi
//
//  Created by Tesiro on 16/7/14.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "SampleInfoTableViewCell.h"

@implementation SampleInfoTableViewCell
- (void)initSubviews {
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 32)];
    [self addSubview:self.viewBG];
    
    self.labelShow = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, DeviceWidth-34, 32)];
    self.labelShow.font = themeFont(12);
    self.labelShow.textColor = [UIColor colorWithHexString:kc00_999999];
    self.labelShow.numberOfLines = 0;
    [self.viewBG addSubview:self.labelShow];
    
    self.viewLineBottom = [[UIView alloc] initWithFrame:CGRectZero];
    self.viewLineBottom.backgroundColor = kcolorLine;
    [self.viewBG addSubview:self.viewLineBottom];
    
//    [self addLineView:CGRectMake(0, 40.5, DeviceWidth, 0.5)];
}

- (void)reloadDataForCell:(id)model{
    self.model = model;
    self.labelShow.text = [NSString stringWithFormat:@"%@ : %@",((XSCellModel *)self.model).title,((XSCellModel *)self.model).content];
    if (((XSCellModel *)self.model).tagColor ==YES) {
        self.viewBG.backgroundColor = [UIColor colorWithHexString:kcolorBJ_f0eff4];
    }else {
        self.viewBG.backgroundColor = [UIColor whiteColor];
    }
    
    NSString *string = self.labelShow.text;
    NSRange range = [string rangeOfString:((XSCellModel *)self.model).content];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.labelShow.text];
    [attributeString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:kc00_666666]} range:NSMakeRange(range.location, range.length)];
    [self.labelShow setAttributedText:attributeString];
    
    if (((XSCellModel *)self.model).heightcontent>20) {
        self.labelShow.frame = CGRectMake(17, 0, DeviceWidth-34, 51);
        self.viewBG.frame = CGRectMake(0, 0, DeviceWidth, 51);
        self.viewLineBottom.frame = CGRectMake(0, 50.5, DeviceWidth, 0.5);
    }else {
        self.labelShow.frame = CGRectMake(17, 0, DeviceWidth-34, 32);
        self.viewBG.frame = CGRectMake(0, 0, DeviceWidth, 32);
        self.viewLineBottom.frame = CGRectMake(0, 31.5, DeviceWidth, 0.5);
    }
    
}

@end
