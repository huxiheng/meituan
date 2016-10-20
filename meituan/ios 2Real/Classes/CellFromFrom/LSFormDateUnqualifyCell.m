//
//  LSFormDateUnqualifyCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/29.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSFormDateUnqualifyCell.h"
#import "LSDateNewActionSheet.h"
#import "LSFormTableViewController.h"



@implementation LSFormDateUnqualifyCell
- (void)onInitWithLabel:(NSString *)label value:(id)value andRule:(NSDictionary *)rule{
    self.strTitle = label;
    self.dateTimeType = (NSString *)value;
    [self initSubviews];
}

- (void)initSubviews{
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(55))];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.viewBG];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, kscaleDeviceHeight(9), 60, kscaleDeviceHeight(37))];
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_999999];
    self.labelTitle.font = themeFont17;
    NSString *strTitleNew = [NSString stringWithFormat:@"%@：",self.strTitle];
    CGFloat strWidth = [NSString calculateTextWidth:kscaleDeviceHeight(37) Content:strTitleNew font:themeFont17];
     self.labelTitle.text = strTitleNew;
    self.labelTitle.frame = CGRectMake(15, kscaleDeviceHeight(9) , strWidth,kscaleDeviceHeight(37) );
    [self.viewBG addSubview:self.labelTitle];
    
    self.labelContent = [[UILabel alloc] initWithFrame:CGRectMake(strWidth+20,kscaleDeviceHeight(9) , DeviceWidth-strWidth-20-15, kscaleDeviceHeight(37) )];
    self.labelContent.textColor = [UIColor colorWithHexString:kc00_F0A568];
    self.labelContent.font = themeFont17;
    self.labelContent.textAlignment = NSTextAlignmentCenter;
    [self.viewBG addSubview:self.labelContent];
    
    UIView *viewLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, kscaleDeviceHeight(54.5), DeviceWidth, kscaleDeviceHeight(0.5))];
    viewLineBottom.backgroundColor = kcolorLine;
    [self.viewBG addSubview:viewLineBottom];
    
}

- (CGFloat)cellHeight {
    return kscaleDeviceHeight(55);
}

- (void)setData:(NSString *)data{
    _data = data;
    if (data == NULL) {
        self.labelContent.text = NULL;
    }else{
        self.labelContent.text = self.data;
    }
}
- (id)data{
    return _data;
}

- (void)onSelected:(LSFormTableViewController *)viewController complete:(void (^)())onComplete{
    CGPoint currentPoint = viewController.tableView.contentOffset;
    NSIndexPath *indexpath=[viewController.tableView indexPathForCell:self];
    [viewController.tableView scrollToRowAtIndexPath:[viewController.tableView indexPathForCell:self] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    int b = (DeviceHeight/self.height)/2-1;
    if (indexpath.row == b) {
        //        viewController.tableView.frame = CGRectMake(0, -180, DeviceWidth, DeviceHeight);
        viewController.tableView.contentOffset = CGPointMake(0, 140);
    }
    if (indexpath.row>b) {
        viewController.tableView.contentOffset = CGPointMake(0, 140+(indexpath.row-b)*self.height);
    }
    
    LSDateNewActionSheet *dateNewActionSheet = [[LSDateNewActionSheet alloc] initWithTitle:self.strTitle];
    [dateNewActionSheet setBlockSelectdDate:^BOOL(NSTimeInterval timeInterval){
        viewController.tableView.frame = CGRectMake(0, 64, DeviceWidth, DeviceHeight-64);
        self.data = timeStringOfTimeIntervalWithFormat(timeInterval, _dateFormat);
        if ([self.delegate respondsToSelector:@selector(cell:valuedChanged:)]) {
            [self.delegate cell:self valuedChanged:self.data];
        }
        
        if ( [self.dateTimeType isEqualToString:@"starteTypeDate"]) {
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",timeInterval] forKey:@"startDateTimeInterval"];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"endDateTimeInterval"]&&timeInterval>[[[NSUserDefaults standardUserDefaults] objectForKey:@"endDateTimeInterval"] floatValue]) {
                [LSDialog showMessage:@"开始时间需要小于结束时间"];
            }
        }
        if ([self.dateTimeType isEqualToString:@"endTypeDate"]) {
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",timeInterval] forKey:@"endDateTimeInterval"];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"startDateTimeInterval"]&&[[[NSUserDefaults standardUserDefaults] objectForKey:@"startDateTimeInterval"] floatValue]>timeInterval) {
                [LSDialog showMessage:@"开始时间需要小于结束时间"];
            }
            
           
        }
        onComplete();
        return true;
    }];
    [dateNewActionSheet setOnCancel:^BOOL{
        viewController.tableView.frame = CGRectMake(0, 64, DeviceWidth, DeviceHeight-64);
        viewController.tableView.contentOffset = CGPointMake(0, 0);
        
        onComplete();
        return true;
    }];
    [dateNewActionSheet showInView:viewController.view.window];
}

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label dateType:(NSString *)dateType{
    
    return [LSFormCell mapperWithClassName:@"DateUnqualify"
                                  cellName:cellName
                                   keyName:keyName
                                     label:label
                                     value:dateType
                                   andRule:nil
            ];
}
@end
