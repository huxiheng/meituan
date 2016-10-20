//
//  LSFormSelectChangeFrameSearchCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/1.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSFormSelectChangeFrameSearchCell.h"
#import "LSPickerActionSheet.h"
#import "LSFormTableViewController.h"
#import "LSForm.h"

@implementation LSFormSelectChangeFrameSearchCell
- (void)onInitWithLabel:(NSString *)label value:(id)value andRule:(NSDictionary *)rule{
    self.selectMapper = rule;
    self.strTitle = label;
    self.heightBG = [self.mapper[LSFormTableMapperCellHeightNewKey] floatValue];
    [self initSubViews];
}

- (void)initSubViews{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.textViewHeight = 17;
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, self.heightBG)];
    self.viewBG.backgroundColor =[UIColor colorWithHexString:kcolorViewBJ_f0eff4];
    [self addSubview:self.viewBG];
    
    self.viewSecondBG = [[UIView alloc] initWithFrame:CGRectMake(25, 0, DeviceWidth-50, 43)];
    self.viewSecondBG.backgroundColor = [UIColor whiteColor];
    self.viewSecondBG.layer.cornerRadius = 5;
    self.viewSecondBG.layer.masksToBounds = YES;
    [self.viewBG addSubview:self.viewSecondBG];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 43)];
    self.labelTitle.font = themeFont17;
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_999999];
    NSString *strWidth = [NSString stringWithFormat:@"%@：",self.strTitle];
    widthTitle = [NSString calculateTextWidth:17 Content:strWidth font:themeFont17];
    self.labelTitle.frame = CGRectMake(10, 0, widthTitle, 43);
    self.labelTitle.text = strWidth;
    [self.viewSecondBG addSubview:self.labelTitle];
    
    self.imageViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceWidth-50-10-21, 11, 21, 21)];
    self.imageViewIcon.image = [UIImage imageNamed:@"unqualitifyNewCheckcaidan"];
    [self.viewSecondBG addSubview:self.imageViewIcon];
    
    self.labelContent = [[UILabel alloc] initWithFrame:CGRectMake(10+widthTitle+3, 13, DeviceWidth-50-10-21-10-widthTitle-3-3, 17)];
    self.labelContent.textColor = [UIColor colorWithHexString:kc00_333333];
    self.labelContent.numberOfLines = 0;
    self.labelContent.textAlignment = NSTextAlignmentCenter;
    self.labelContent.font = themeFont17;
    [self.viewSecondBG addSubview:self.labelContent];
    
}
- (CGFloat)cellHeight {
//    return 50;
         return [self.labelContent sizeThatFits:CGSizeMake(self.labelContent.frame.size.width, FLT_MAX)].height + 26+self.heightBG-43;
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
        [self clickSureOperation:self.labelContent.text];
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
+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label andMapper:(NSDictionary *)mapper andHeight:(NSString *)height{
    
    return [LSFormCell mapperWithClassName:@"SelectChangeFrameSearch"
                                  cellName:cellName
                                   keyName:keyName
                                     label:label
                                     value:nil
                                   andRule:mapper
            andHeight:height];
}
- (void)setText:(NSString *)text
{
    _text = text;
    
    // update the UI
    self.labelContent.text = text;
}

- (void)clickSureOperation:(NSString  *)stringstr{
    CGFloat heightstr  = [NSString calculateTextHeight:DeviceWidth-50-10-21-10-widthTitle-3-3 Content:stringstr font:themeFont17];
    self.textViewHeight =heightstr+5>35?heightstr:20;
    [self updateFrame];
    if ([self.expandableTableView.delegate conformsToProtocol:@protocol(ACEExpandableTableViewDelegate)]) {
        
        id<ACEExpandableTableViewDelegate> delegate = (id<ACEExpandableTableViewDelegate>)self.expandableTableView.delegate;
        NSIndexPath *indexPath = [self.expandableTableView indexPathForCell:self];
        
        // update the text
//        _text = self.textComment.text;
//        _data = self.textComment.text;
        [delegate tableView:self.expandableTableView
                updatedText:stringstr
                atIndexPath:indexPath];
        
        CGFloat newHeight = [self cellHeight];
        newHeight= (newHeight>self.textViewHeight+26+self.heightBG-43)?self.textViewHeight+26+self.heightBG-43:newHeight;
        CGFloat oldHeight = [delegate tableView:self.expandableTableView heightForRowAtIndexPath:indexPath];
        if (fabs(newHeight - oldHeight) > 0.01) {
            
            // update the height
            if ([delegate respondsToSelector:@selector(tableView:updatedHeight:atIndexPath:)]) {
                [delegate tableView:self.expandableTableView
                      updatedHeight:newHeight
                        atIndexPath:indexPath];
            }
            
            UITableView *table= [self tableView];
            NSIndexPath *indexPath = [table indexPathForCell:self];
            self.expandableTableView = table;
            
            // refresh the table without closing the keyboard
            [self.expandableTableView beginUpdates];
            [self.expandableTableView endUpdates];
        }
    }
}
- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}
- (void)updateFrame{
    self.viewBG.frame = CGRectMake(0, 0, DeviceWidth, self.textViewHeight+26+self.heightBG-43);
    self.viewSecondBG.frame = CGRectMake(25, 0, DeviceWidth-50, self.textViewHeight+26);
    self.labelTitle.frame = CGRectMake(10, 13, widthTitle, self.textViewHeight);
    self.labelContent.frame =CGRectMake(10+widthTitle+3, 13, DeviceWidth-50-10-21-10-widthTitle-3-3, self.textViewHeight);
    self.imageViewIcon.frame = CGRectMake(DeviceWidth-50-10-21, (self.textViewHeight+26-21)/2, 21, 21);
}

@end
