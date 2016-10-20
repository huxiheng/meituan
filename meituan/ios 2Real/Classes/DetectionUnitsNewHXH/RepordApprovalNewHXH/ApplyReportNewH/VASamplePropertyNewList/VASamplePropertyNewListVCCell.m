//
//  VASamplePropertyNewListVCCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/4.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "VASamplePropertyNewListVCCell.h"

@implementation VASamplePropertyNewListVCCell
- (void)initSubviews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.viewBGName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth,kscaleDeviceHeight(40))];
    [self addSubview:self.viewBGName];
    
    self.imageViewHeadName = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 11, 11)];
    self.imageViewHeadName.image = [UIImage imageNamed:@"unqualifiedyuan"];
    [self.viewBGName addSubview:self.imageViewHeadName];
    
    self.labelShowName = [[UILabel alloc] initWithFrame:CGRectMake(36, 12, DeviceWidth-36-15, 17)];
    self.labelShowName.font = themeFont17;
    self.labelShowName.textColor = [UIColor colorWithHexString:kc00_999999];
    [self.viewBGName addSubview:self.labelShowName];
    
    self.imageViewLineBottomName = [[UIImageView alloc] initWithFrame:CGRectMake(0,kscaleDeviceHeight(39) , DeviceWidth, kscaleDeviceHeight(1) )];
    self.imageViewLineBottomName.image = [UIImage imageNamed:@"xuxianagreement"];
    [self.viewBGName addSubview:self.imageViewLineBottomName];
    
    self.viewBGStandardValue = [[UIView alloc] initWithFrame:CGRectMake(0, kscaleDeviceHeight(40), DeviceWidth, kscaleDeviceHeight(40) )];
    [self addSubview:self.viewBGStandardValue];
    
    self.imageViewHeadStandardValue = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 11, 11)];
    self.imageViewHeadStandardValue.image = [UIImage imageNamed:@"unqualifiedyuan"];
    [self.viewBGStandardValue addSubview:self.imageViewHeadStandardValue];
    
    self.labelShowStandardValue = [[UILabel alloc] initWithFrame:CGRectMake(36, 12, DeviceWidth-36-15, 17)];
    self.labelShowStandardValue.font = themeFont17;
    self.labelShowStandardValue.textColor = [UIColor colorWithHexString:kc00_999999];
    [self.viewBGStandardValue addSubview:self.labelShowStandardValue];
    
    self.imageViewLineBottomStandardValue = [[UIImageView alloc] initWithFrame:CGRectMake(0,kscaleDeviceHeight(39) , DeviceWidth,kscaleDeviceHeight(1) )];
    self.imageViewLineBottomStandardValue.image = [UIImage imageNamed:@"xuxianagreement"];
    [self.viewBGStandardValue addSubview:self.imageViewLineBottomStandardValue];
    
    self.viewBGTestValue = [[UIView alloc] initWithFrame:CGRectMake(0,kscaleDeviceHeight(80) , DeviceWidth, kscaleDeviceHeight(40) )];
    self.viewBGTestValue.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.viewBGTestValue];
    
    self.imageViewHeadTestValue = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 11, 11)];
    self.imageViewHeadTestValue.image = [UIImage imageNamed:@"unqualifiedyuan"];
    [self.viewBGTestValue addSubview:self.imageViewHeadTestValue];
    
    self.labelShowTestValue = [[UILabel alloc] initWithFrame:CGRectMake(36, 12, DeviceWidth-36-15, 17)];
    self.labelShowTestValue.font = themeFont17;
    self.labelShowTestValue.textColor = [UIColor colorWithHexString:kc00_999999];
    [self.viewBGTestValue addSubview:self.labelShowTestValue];
    
    self.imageViewLineBottomTestValue = [[UIImageView alloc] initWithFrame:CGRectMake(0, kscaleDeviceHeight(39), DeviceWidth, kscaleDeviceHeight(1) )];
    self.imageViewLineBottomTestValue.image = [UIImage imageNamed:@"xuxianagreement"];
    [self.viewBGTestValue addSubview:self.imageViewLineBottomTestValue];
    
    
    self.viewBGResultValue = [[UIView alloc] initWithFrame:CGRectMake(0, kscaleDeviceHeight(120) , DeviceWidth,kscaleDeviceHeight(40) )];
    self.viewBGResultValue.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.viewBGResultValue];
    
    self.imageViewHeadResultValue = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 11, 11)];
    self.imageViewHeadResultValue.image = [UIImage imageNamed:@"unqualifiedyuan"];
    [self.viewBGResultValue addSubview:self.imageViewHeadResultValue];
    
    self.labelShowResultValue = [[UILabel alloc] initWithFrame:CGRectMake(36, 12, DeviceWidth-36-15, 17)];
    self.labelShowResultValue.font = themeFont17;
    self.labelShowResultValue.textColor = [UIColor colorWithHexString:kc00_999999];
    [self.viewBGResultValue addSubview:self.labelShowResultValue];
    
    self.imageViewLineBottomResultValue = [[UIImageView alloc] initWithFrame:CGRectMake(0, kscaleDeviceHeight(39) , DeviceWidth, kscaleDeviceHeight(1) )];
    self.imageViewLineBottomResultValue.image = [UIImage imageNamed:@"xuxianagreement"];
    [self.viewBGResultValue addSubview:self.imageViewLineBottomResultValue];
    
    
    self.viewBottom = [[UIView alloc] initWithFrame:CGRectMake(0,kscaleDeviceHeight(160) , DeviceWidth, kscaleDeviceHeight(40) )];
    self.viewBottom.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.viewBottom];
    
    self.imageViewBottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, kscaleDeviceHeight(39) , DeviceWidth, kscaleDeviceHeight(1) )];
    self.imageViewBottomLine.image = [UIImage imageNamed:@"xuxianagreement"];
    [self.viewBottom addSubview:self.imageViewBottomLine];
    
    
}

- (void)reloadDataForCell:(id)model {
//    cell.textLabel.text = item[@"ParameterName"];
//    if (STRING_NOT_EMPTY( item[@"UCStandardValue"])) {
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@(标准:%@)",item[@"UCResultValue"],item[@"UCStandardValue"]];
//    }else{
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",item[@"UCResultValue"]];
//    }
    
    self.model = model;
    self.labelShowName.text = [NSString stringWithFormat:@"参数名称：%@",((NSDictionary*)self.model)[@"ParameterName"]];
    NSRange rangeName = [self.labelShowName.text rangeOfString:((NSDictionary*)self.model)[@"ParameterName"]];
    [self.labelShowName setAttributeText:self.labelShowName.text nsrange:rangeName andColorRGB:kc00_333333];
    
    self.labelShowStandardValue.text = [NSString stringWithFormat:@"标准值：%@",((NSDictionary*)self.model)[@"UCStandardValue"]];
    NSRange rangeStandardValue = [self.labelShowStandardValue.text rangeOfString:((NSDictionary*)self.model)[@"UCStandardValue"]];
    [self.labelShowStandardValue setAttributeText:self.labelShowStandardValue.text nsrange:rangeStandardValue andColorRGB:kc00_333333];
    
    self.labelShowTestValue.text = [NSString stringWithFormat:@"检测值：%@",((NSDictionary*)self.model)[@"UCTestValue"]];
    NSRange rangetextValue = [self.labelShowTestValue.text rangeOfString:((NSDictionary*)self.model)[@"UCTestValue"]];
    [self.labelShowTestValue setAttributeText:self.labelShowTestValue.text nsrange:rangetextValue andColorRGB:kc00_333333];
    
    self.labelShowResultValue.text = [NSString stringWithFormat:@"检测结果：%@",((NSDictionary*)self.model)[@"UCResultValue"]];
    NSRange rangeResultValue = [self.labelShowResultValue.text rangeOfString:((NSDictionary*)self.model)[@"UCResultValue"]];
    [self.labelShowResultValue setAttributeText:self.labelShowResultValue.text nsrange:rangeResultValue andColorRGB:kc00_333333];
}

@end
