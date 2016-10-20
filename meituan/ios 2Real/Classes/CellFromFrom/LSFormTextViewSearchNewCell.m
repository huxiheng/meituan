//
//  LSFormTextViewSearchNewCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/8/1.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSFormTextViewSearchNewCell.h"

@implementation LSFormTextViewSearchNewCell
- (void)onInitWithLabel:(NSString *)label value:(NSString *)value andRule:(NSDictionary *)rule {
    self.strTitle = label;
    //    [self.contentView addSubview:self.textView];
    [self initSubViews];
}
- (void)initSubViews{
    self.textViewHeight = 17;
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 50)];
    self.viewBG.backgroundColor = [UIColor colorWithHexString:kcolorViewBJ_f0eff4];
    [self addSubview:self.viewBG];
    
    self.viewSecondBG = [[UIView alloc] initWithFrame:CGRectMake(25, 0, DeviceWidth-50, 43)];
    self.viewSecondBG.backgroundColor = [UIColor whiteColor];
    self.viewSecondBG.layer.cornerRadius = 5;
    self.viewSecondBG.layer.masksToBounds = YES;
    [self.viewBG addSubview:self.viewSecondBG];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 17)];
    self.labelTitle.font = themeFont17;
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_999999];
    NSString *strWidth = [NSString stringWithFormat:@"%@：",self.strTitle];
    widthTitle = [NSString calculateTextWidth:17 Content:strWidth font:themeFont17];
    self.labelTitle.frame = CGRectMake(10, 10, widthTitle, 17);
    self.labelTitle.text = strWidth;
    [self.viewSecondBG addSubview:self.labelTitle];
    
    self.textComment = [[UITextView alloc] initWithFrame:CGRectMake(widthTitle+10, 10, DeviceWidth-50-20-widthTitle, self.textViewHeight)];
    self.textComment.font = themeFont17;
    self.textComment.delegate = self;
    //    self.textComment.scrollEnabled = NO;
    self.textComment.autoresizingMask =UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.textComment.showsVerticalScrollIndicator = NO;
    self.textComment.showsHorizontalScrollIndicator = NO;
    self.textComment.backgroundColor = [UIColor clearColor];
    [self.viewSecondBG addSubview:self.textComment];
    
    self.imageViewBottom = [[UIImageView alloc] initWithFrame:CGRectMake(widthTitle, self.textViewHeight+10, DeviceWidth-50-20-widthTitle, 6)];
    self.imageViewBottom.image = [UIImage imageNamed:@"unqualifywenbenkuang"];
    [self.viewSecondBG addSubview:self.imageViewBottom];
    
    
}

- (void)setData:(NSString *)data{
    _data = data;
    if (IS_STRING(data)) {
        
    }
    
    
}
- (id)data{
    [super resignFirstResponder];
    
    return _data;
}

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label andHeight:(NSString *)height{
    return [LSFormCell mapperWithClassName:@"TextViewSearchNew" cellName:cellName keyName:keyName label:label value:nil andRule:nil andHeight:height];
}
- (BOOL)resignFirstResponder{
    [super resignFirstResponder];
    [self.textComment resignFirstResponder];
    return YES;
}
- (BOOL)isFirstResponder{
    [super isFirstResponder];
    [self.textComment isFirstResponder];
    return YES;
}
- (void)setText:(NSString *)text
{
    _text = text;
    
    // update the UI
    self.textComment.text = text;
}

- (CGFloat)cellHeight
{
    return [self.textComment sizeThatFits:CGSizeMake(self.textComment.frame.size.width, FLT_MAX)].height + 10+6+10+7;
}

#pragma mark - Text View Delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
//    self.textViewHeight =MIN(18, textView.contentSize.height-3);
    self.textViewHeight =MAX(self.textViewHeight, 18);
    
    // make sure the cell is at the top
    [self.expandableTableView scrollToRowAtIndexPath:[self.expandableTableView indexPathForCell:self]
                                    atScrollPosition:UITableViewScrollPositionTop
                                            animated:YES];
    
    [self updateFrame];
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)theTextView
{
    self.textViewHeight =MIN(38, theTextView.contentSize.height-3);
    [self updateFrame];
    if ([self.expandableTableView.delegate conformsToProtocol:@protocol(ACEExpandableTableViewDelegate)]) {
        
        id<ACEExpandableTableViewDelegate> delegate = (id<ACEExpandableTableViewDelegate>)self.expandableTableView.delegate;
        NSIndexPath *indexPath = [self.expandableTableView indexPathForCell:self];
        
        // update the text
        _text = self.textComment.text;
        _data = self.textComment.text;
        [delegate tableView:self.expandableTableView
                updatedText:_text
                atIndexPath:indexPath];
        
        CGFloat newHeight = [self cellHeight];
        newHeight= (newHeight>self.textViewHeight+33)?self.textViewHeight+33:newHeight;
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
    self.textComment.frame = CGRectMake(widthTitle+5+10, 10, DeviceWidth-50-20-widthTitle-5, self.textViewHeight);
    self.imageViewBottom.frame =CGRectMake(widthTitle+5, self.textViewHeight+10, DeviceWidth-50-20-widthTitle-5, 6);
    self.viewSecondBG.frame =CGRectMake(25, 0, DeviceWidth-50, self.textViewHeight+10+6+10);
    self.viewBG.frame = CGRectMake(0, 0, DeviceWidth, self.textViewHeight+10+6+10+7);
    self.labelTitle.frame = CGRectMake(10, 10, widthTitle, self.textViewHeight);
    
}
@end
