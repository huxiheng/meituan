//
//  SampleInfoHeaderView.m
//  Xieshi
//
//  Created by Tesiro on 16/7/14.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "SampleInfoHeaderView.h"

@implementation SampleInfoHeaderView
- (void)initSubviews{
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 91.5)];
    self.viewBG.backgroundColor = [UIColor colorWithHexString:kcolorBJ_f0eff4];
    [self addSubview:self.viewBG];
    
    self.imageBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 91.5)];
    self.imageBG.userInteractionEnabled = YES;
    self.imageBG.image = [UIImage imageNamed:@"unqualifyiedTuCeng"];
    [self.viewBG addSubview:self.imageBG];
    
    self.labelSampleTitle = [[UILabel alloc] initWithFrame:CGRectMake(17, 10, (DeviceWidth-120-17-5), 31)];
    self.labelSampleTitle.font = themeFont17;
    self.labelSampleTitle.textColor = [UIColor colorWithHexString:kc00_1A90CD];
    [self.viewBG addSubview:self.labelSampleTitle];
    
    self.labelQuality = [[UILabel alloc] initWithFrame:CGRectMake(17, 51, DeviceWidth-34, 31)];
    self.labelQuality.font = themeFont(17);
    self.labelQuality.textColor = [UIColor colorWithHexString:kc00_E00A2D];
    self.labelQuality.numberOfLines = 0;
    [self.viewBG addSubview:self.labelQuality];
    
    UIView *vieewLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 91.5, DeviceWidth, 0.5)];
    vieewLineBottom.backgroundColor = kcolorLine;
    [self.viewBG addSubview:vieewLineBottom];
    
//    [self addLineView:CGRectMake(0, 91.5, DeviceWidth, 0.5)];
    
}

- (void)reloadDataForView:(id)model{
    
    self.model=model;
    self.labelSampleTitle.text = [NSString stringWithFormat:@"样品编号:%@",(((NSDictionary*)self.model)[@"dataMessage"])[@"Sample_ID"]];
    self.labelQuality.text =[NSString stringWithFormat:@"检测结果:%@",(((NSDictionary*)self.model)[@"dataMessage"])[@"Exam_Result"]];
    
    ///根据内容适应行高
    if ([((NSDictionary*)self.model)[@"height"] integerValue]>22) {
        self.labelSampleTitle.frame = CGRectMake(17, 10, (DeviceWidth-34), 17);
        self.labelQuality.frame =CGRectMake(17, 32, DeviceWidth-34, 60);
    }else {
        self.labelSampleTitle.frame = CGRectMake(17, 10, (DeviceWidth-34), 31);
        self.labelQuality.frame =CGRectMake(17, 51, DeviceWidth-34, 31);
    }
}

@end
