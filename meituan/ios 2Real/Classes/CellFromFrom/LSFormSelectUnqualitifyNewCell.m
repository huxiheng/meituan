//
//  LSFormSelectUnqualitifyNewCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/29.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSFormSelectUnqualitifyNewCell.h"
#import "LSPickerActionSheet.h"
#import "LSFormTableViewController.h"
#import "LSForm.h"

@implementation LSFormSelectUnqualitifyNewCell
- (void)onInitWithLabel:(NSString *)label value:(id)value andRule:(NSDictionary *)rule{
    self.selectMapper = rule;
    self.strTitle = label;
    [self initSubViews];
}

- (void)initSubViews{
    UIView  *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth,kscaleDeviceHeight(55))];
    viewBG.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewBG];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15,kscaleDeviceHeight(9), 60,kscaleDeviceHeight(37))];
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_999999];
    self.labelTitle.font = themeFont17;
    NSString *strTitleNew = [NSString stringWithFormat:@"%@：",self.strTitle];
    self.labelTitle.text = strTitleNew;
    CGFloat widthStr = [NSString calculateTextWidth:kscaleDeviceHeight(37) Content:strTitleNew font:themeFont17];
    self.labelTitle.frame = CGRectMake(15,kscaleDeviceHeight(9) , widthStr,kscaleDeviceHeight(37));
    [viewBG addSubview:self.labelTitle];
    
    self.labelContent = [[UILabel alloc] initWithFrame:CGRectMake(15+widthStr,kscaleDeviceHeight(9), DeviceWidth-20-widthStr-50,kscaleDeviceHeight(37))];
    self.labelContent.font = themeFont17;
    self.labelContent.textColor = [UIColor colorWithHexString:kc00_333333];
    self.labelContent.textAlignment = NSTextAlignmentCenter;
    [viewBG addSubview:self.labelContent];
    
    self.imageViewRight = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceWidth-33,kscaleDeviceHeight(21.5), 18, kscaleDeviceHeight(12))];
    self.imageViewRight.image = [UIImage imageNamed:@"unqualifyMoreCaiDan"];
    [viewBG addSubview:self.imageViewRight];
    
    self.viewBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0,kscaleDeviceHeight(54.5)  , DeviceWidth, kscaleDeviceHeight(0.5))];
    self.viewBottomLine.backgroundColor = kcolorLine;
    [viewBG addSubview:self.viewBottomLine];
    
}

- (CGFloat)cellHeight {
    return kscaleDeviceHeight(55);
}

- (void)setData:(NSString *)data{
    _data = data;
    if (data == NULL) {
        self.labelContent.text = NULL;
    }else{
        self.labelContent.text = self.selectMapper[data];
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
    
    
    NSArray *list = [self.selectMapper allValues] ;
    list = [list sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
        return [obj1 floatValue] > [obj2 floatValue];
    }];
    LSPickerActionSheet *pickerActionSheet = [[LSPickerActionSheet alloc]initWithTitle:self.strTitle andList:list];
    [pickerActionSheet setOnSelected:^BOOL(int index) {
        viewController.tableView.frame = CGRectMake(0, 64, DeviceWidth, DeviceHeight-64);
        viewController.tableView.contentOffset = currentPoint;
        if ([self.selectMapper allKeys].count == 0) {
            return true;
        }
        NSString* value = list[index];
        NSInteger valueIndex = [[self.selectMapper allValues] indexOfObject:value];
        self.data = [self.selectMapper allKeys][valueIndex];
        if ([self.delegate respondsToSelector:@selector(cell:valuedChanged:)]) {
            [self.delegate cell:self valuedChanged:self.data];
        }
        onComplete();
        return true;
    }];
    [pickerActionSheet setOnCancel:^BOOL{
        viewController.tableView.frame = CGRectMake(0, 64, DeviceWidth, DeviceHeight-64);
        viewController.tableView.contentOffset = currentPoint;
        onComplete();
        return true;
    }];
    [pickerActionSheet showInView:viewController.view.window];
}

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label andMapper:(NSDictionary *)mapper{
    return [LSFormCell mapperWithClassName:@"SelectUnqualitifyNew"
                                  cellName:cellName
                                   keyName:keyName
                                     label:label
                                     value:nil
                                   andRule:mapper
            ];
}
@end
