//
//  LSFormRangeUnqualitafyNewCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/29.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSFormRangeUnqualitafyNewCell.h"
#import "LSFormTableViewController.h"

@implementation LSFormRangeUnqualitafyNewCell
- (void)onInitWithLabel:(NSString *)label value:(id)value andRule:(NSDictionary *)rule{
    self.strTitle = label;
    [self initSubviews];
}

- (void)initSubviews{
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(55))];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.viewBG];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15,kscaleDeviceHeight(9) , 60,kscaleDeviceHeight(37))];
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_999999 ];
    self.labelTitle.font = themeFont17;
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    NSString *strTitleNew = [NSString stringWithFormat:@"%@：",self.strTitle];
    CGFloat widthTitle = [NSString calculateTextWidth:kscaleDeviceHeight(37)  Content:strTitleNew font:themeFont17];
    self.labelTitle.text = strTitleNew;
    self.labelTitle.frame = CGRectMake(15, kscaleDeviceHeight(9) , widthTitle, kscaleDeviceHeight(37));
    [self.viewBG addSubview:self.labelTitle];
    
    self.labelContent = [[UILabel alloc] initWithFrame:CGRectMake(15+widthTitle, kscaleDeviceHeight(9) , DeviceWidth-15-widthTitle-15, kscaleDeviceHeight(37) )];
    self.labelContent.textColor = [UIColor colorWithHexString:kc00_F0A568];
    self.labelContent.numberOfLines = 0;
//    NSString *strContent = [NSString stringWithFormat:@"        %@\n到    %@",@"0000/00/00",@"0000/00/00"];
//    CGFloat heightContent = [NSString calculateTextHeight:DeviceWidth-20-widthTitle-15-5 Content:strContent font:themeFont17];
//    self.labelContent.frame = CGRectMake(15+widthTitle+5, 10, DeviceWidth-20-widthTitle-15-5, heightContent);
//    self.labelContent.textAlignment =NSTextAlignmentCenter;
//    self.labelContent.font  = themeFont17;
    
    
        self.labelContent.textAlignment =NSTextAlignmentCenter;
        self.labelContent.font  = themeFont15;

    [self.viewBG addSubview:self.labelContent];
    
    self.viewLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, kscaleDeviceHeight(54.5) , DeviceWidth, kscaleDeviceHeight(0.5))];
        self.viewLineBottom.backgroundColor = kcolorLine;
        [self.viewBG addSubview:self.viewLineBottom];
        heightViewCell =kscaleDeviceHeight(55);
        self.viewBG.frame = CGRectMake(0, 0, DeviceWidth, heightViewCell);
//    self.viewLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 10+heightContent+9.5, DeviceWidth, 0.5)];
//    self.viewLineBottom.backgroundColor = kcolorLine;
//    [self.viewBG addSubview:self.viewLineBottom];
//    heightViewCell =10+heightContent+10;
//    self.viewBG.frame = CGRectMake(0, 0, DeviceWidth, heightViewCell);
}

- (CGFloat)cellHeight{
    return heightViewCell;
}

- (void)setData:(id)data{
        _data = (NSString *)data;
    NSArray *data1 = [data componentsSeparatedByString:@","];
       self.labelContent.text = [NSString stringWithFormat:@"      %@\n到  %@",data1[0],data1[1]];
        self.labelContent.text = [NSString stringWithFormat:@"%@  到  %@",data1[0],data1[1]];
        NSString *string3=[NSString stringWithFormat:@"%@  到  %@",data1[0],data1[1]];
        NSRange range3 = [string3 rangeOfString: @"到"];
        NSMutableAttributedString *attribute3 =[[NSMutableAttributedString alloc] initWithString: string3];
        [attribute3 addAttributes:@{
                                    NSForegroundColorAttributeName:[UIColor colorWithHexString:kc00_333333]
                                    }range:range3];
        [self.labelContent setAttributedText:attribute3];
    //
        static NSDateFormatter *formatter;
        if (formatter == NULL) {
            formatter= [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HH:mm"];
        }
        _startDate = [formatter dateFromString:data1[0]];
        _endDate   = [formatter dateFromString:data1[1]];
    
}

//- (void)setData:(NSArray *)data{
//    NSAssert(IS_ARRAY(data), @"data must be an Array");
//    _data = data;
////   self.labelContent.text = [NSString stringWithFormat:@"      %@\n到  %@",_data[0],_data[1]];
//    self.labelContent.text = [NSString stringWithFormat:@"%@  到  %@",_data[0],_data[1]];
//    NSString *string3=[NSString stringWithFormat:@"%@  到  %@",_data[0],_data[1]];
//    NSRange range3 = [string3 rangeOfString: @"到"];
//    NSMutableAttributedString *attribute3 =[[NSMutableAttributedString alloc] initWithString: string3];
//    [attribute3 addAttributes:@{
//                                NSForegroundColorAttributeName:[UIColor colorWithHexString:kc00_333333]
//                                }range:range3];
//    [self.labelContent setAttributedText:attribute3];
//    
//    static NSDateFormatter *formatter;
//    if (formatter == NULL) {
//        formatter= [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"HH:mm"];
//    }
//    _startDate = [formatter dateFromString:data[0]];
//    _endDate   = [formatter dateFromString:data[1]];
//}

- (void)onSelected:(LSFormTableViewController *)viewController complete:(void (^)())onComplete{
    LSFTimeRangePickerViewController *controller = [[LSFTimeRangePickerViewController alloc]init];
    VIEW_CONTROLLER_LOAD(controller);
    [viewController presentModalViewController:wrapNavigationController(controller) animated:YES];
    
    controller.title = @"选择时间";
    controller.type = _type;
    [controller setOnClose:^{
        [viewController dismissViewControllerAnimated:YES completion:0];
    }];
    
    [controller setOnConfirm:^(NSTimeInterval start, NSTimeInterval end) {
        if (start>end) {
            [LSDialog showMessage:@"开始时间需要小于结束时间"];
            return ;
        }
        self.data = [NSString stringWithFormat:@"%@,%@",timeStringOfTimeIntervalWithFormat(start, _dateFormat),timeStringOfTimeIntervalWithFormat(end  , _dateFormat)];
        
        if ([self.delegate respondsToSelector:@selector(cell:valuedChanged:)]) {
            [self.delegate cell:self valuedChanged:self.data];
        }
        [viewController dismissViewControllerAnimated:YES completion:^{
            onComplete();
            startInterval = start;
            endInterval = end;
            
        }];
        
    }];
    UNUSED_VAR(controller.view);
    controller.startTimeInterval = [_startDate timeIntervalSince1970];
    controller.endTimeInterval   = [_endDate   timeIntervalSince1970];
}

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label{
    return [LSFormCell mapperWithClassName:@"RangeUnqualitafyNew" cellName:cellName keyName:keyName label:label value:nil andRule:nil];
}

@end
