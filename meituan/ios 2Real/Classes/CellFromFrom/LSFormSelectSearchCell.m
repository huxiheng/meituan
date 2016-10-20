//
//  LSFormSelectSearchCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/1.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSFormSelectSearchCell.h"
#import "LSPickerActionSheet.h"
#import "LSFormTableViewController.h"
#import "LSForm.h"

@implementation LSFormSelectSearchCell
- (void)onInitWithLabel:(NSString *)label value:(id)value andRule:(NSDictionary *)rule{
    self.selectMapper = rule;
    self.strTitle = label;
    [self initSubViews];
}

- (void)initSubViews{
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 50)];
    self.viewBG.backgroundColor =[UIColor colorWithHexString:kcolorViewBJ_f0eff4];
    [self addSubview:self.viewBG];
    
    self.viewSecondBG = [[UIView alloc] initWithFrame:CGRectMake(25, 0, DeviceWidth-50, 43)];
    self.viewSecondBG.backgroundColor = [UIColor whiteColor];
    self.viewSecondBG.layer.cornerRadius = 5;
    self.viewSecondBG.layer.masksToBounds = YES;
    [self.viewBG addSubview:self.viewSecondBG];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 60, 17)];
    self.labelTitle.font = themeFont17;
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_999999];
    NSString *strWidth = [NSString stringWithFormat:@"%@：",self.strTitle];
    widthTitle = [NSString calculateTextWidth:17 Content:strWidth font:themeFont17];
    self.labelTitle.frame = CGRectMake(10, 13, widthTitle, 17);
    self.labelTitle.text = strWidth;
    [self.viewSecondBG addSubview:self.labelTitle];
    
    self.imageViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceWidth-50-10-21, 11, 21, 21)];
    self.imageViewIcon.image = [UIImage imageNamed:@"unqualitifyNewCheckcaidan"];
    [self.viewSecondBG addSubview:self.imageViewIcon];
    
    self.labelContent = [[UILabel alloc] initWithFrame:CGRectMake(10+widthTitle, 13, DeviceWidth-50-10-21-10-widthTitle-3, 17)];
    self.labelContent.textColor = [UIColor colorWithHexString:kc00_333333];
    self.labelContent.textAlignment = NSTextAlignmentCenter;
    self.labelContent.font = themeFont17;
    [self.viewSecondBG addSubview:self.labelContent];
    
}
- (CGFloat)cellHeight {
    return 50;
//     return [self.labelContent sizeThatFits:CGSizeMake(self.labelContent.frame.size.width, FLT_MAX)].height + 10+6+10+7;
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
    
    NSArray *list = [self.selectMapper allValues] ;
    list = [list sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
        return [obj1 floatValue] > [obj2 floatValue];
    }];
    LSPickerActionSheet *pickerActionSheet = [[LSPickerActionSheet alloc]initWithTitle:self.strTitle andList:list];
    [pickerActionSheet setOnSelected:^BOOL(int index) {
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
        onComplete();
        return true;
    }];
    [pickerActionSheet showInView:viewController.view.window];
}
+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label andMapper:(NSDictionary *)mapper{
    return [LSFormCell mapperWithClassName:@"SelectSearch"
                                  cellName:cellName
                                   keyName:keyName
                                     label:label
                                     value:nil
                                   andRule:mapper
            ];
}
@end
