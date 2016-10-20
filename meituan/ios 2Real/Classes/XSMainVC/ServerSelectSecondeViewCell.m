//
//  ServerSelectSecondeViewCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/26.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "ServerSelectSecondeViewCell.h"

@implementation ServerSelectSecondeViewCell
- (void)initSubviews {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 59.5)];
    self.viewBG.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    [self addSubview:self.viewBG];
    
//    self.btnBG = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.btnBG.frame = CGRectMake(0 , 0 , DeviceWidth , 59.5);
//    self.btnBG.backgroundColor = [UIColor clearColor];
//    [self.viewBG addSubview:self.btnBG];
    
    self.imageViewHead = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 40, 40)];
    self.imageViewHead.userInteractionEnabled = YES;
    [self.viewBG addSubview:self.imageViewHead];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 100, 59.5)];
    self.labelTitle.font = themeFont17;
    self.labelTitle.textColor = [UIColor lightGrayColor];
    
    [self.viewBG addSubview:self.labelTitle];
    
    self.imageviewSelectTag = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceWidth-15-20, 20, 20, 20)];
//    self.imageviewSelectTag.image = [UIImage imageNamed:@"selectanniu"];
   
    [self.viewBG addSubview:self.imageviewSelectTag];
    
    UIView *viewBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5, DeviceWidth, 0.5)];
    viewBottom.backgroundColor = kcolorLine;
    [self.viewBG addSubview:viewBottom];
    
}



- (void)reloadDataForCell:(id)model {
    self.model = model;
    self.imageViewHead.image = ((XSCellModel *)self.model).images;
    self.labelTitle.text =((XSCellModel *)self.model).title;
    if (((XSCellModel *)self.model).tagColor == YES) {
        self.imageviewSelectTag.image = [UIImage imageNamed:@"selectduihao"];
    }else{
        self.imageviewSelectTag.image = [UIImage imageNamed:@"selectanniu"];
    }
}
@end
