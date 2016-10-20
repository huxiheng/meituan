//
//  LSFormTextFieldUnqualifyCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/27.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSFormTextFieldUnqualifyCell.h"

#define kPadding 5

@implementation LSFormTextFieldUnqualifyCell
- (void)onInitWithLabel:(NSString *)label value:(NSString *)value andRule:(NSDictionary *)rule {
    self.strTitle = label;
//    [self.contentView addSubview:self.textView];
    [self initSubViews];
}
- (void)updateFrame {
//    self.frame = CGRectMake(0, 0, DeviceWidth, self.textViewHeight+37);
    self.viewBottomLine.frame = CGRectMake(0, self.textViewHeight+24-0.5 , DeviceWidth, 0.5 );
    self.viewBG.frame =CGRectMake(0, 0, DeviceWidth, self.textViewHeight+0.5);
    self.textComment.frame = CGRectMake(widthTitle+15+5,9, DeviceWidth-widthTitle-5-30-10, self.textViewHeight);
    self.imageBottom.frame =CGRectMake(widthTitle+15, self.textViewHeight+9 , DeviceWidth-widthTitle-5-30,6);
    
}
- (void)initSubViews{
    self.textViewHeight = kscaleDeviceHeight(31.0);
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth,kscaleDeviceHeight(55))];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.viewBG];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, kscaleDeviceHeight(9) , 60, kscaleDeviceHeight(37))];
    self.labelTitle.font = themeFont17;
    self.labelTitle.textColor = [UIColor colorWithHexString:kc00_999999];
    NSString *strTitle = [NSString stringWithFormat:@"%@：",self.strTitle];
    self.labelTitle.text = strTitle;
    widthTitle = [NSString calculateTextWidth:kscaleDeviceHeight(37) Content:strTitle font:themeFont17];
    self.labelTitle.frame = CGRectMake(15, kscaleDeviceHeight(9) , widthTitle+5, kscaleDeviceHeight(37));
    [self.viewBG addSubview:self.labelTitle];
    
    
    self.textComment = [[UITextView alloc] initWithFrame:CGRectMake(widthTitle+5+15+5, kscaleDeviceHeight(9), DeviceWidth-widthTitle-5-30-10, self.textViewHeight)];
    self.textComment.font = themeFont17;
    self.textComment.delegate = self;
//    self.textComment.scrollEnabled = NO;
    self.textComment.textColor = [UIColor colorWithHexString:kc00_333333];
    self.textComment.returnKeyType = UIReturnKeyDone;
    self.textComment.autoresizingMask =UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.textComment.showsVerticalScrollIndicator = NO;
    self.textComment.showsHorizontalScrollIndicator = NO;
    self.textComment.backgroundColor = [UIColor clearColor];
    [self.viewBG addSubview:self.textComment];
    
    self.imageBottom = [[UIImageView alloc] initWithFrame:CGRectMake(widthTitle+5+15, self.textViewHeight+kscaleDeviceHeight(9), DeviceWidth-widthTitle-5-30, kscaleDeviceHeight(6))];
    self.imageBottom.image = [UIImage imageNamed:@"unqualifywenbenkuang"];
    [self.viewBG addSubview:self.imageBottom];
    
    self.viewBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, kscaleDeviceHeight(54.5), DeviceWidth, kscaleDeviceHeight(0.5))];
    self.viewBottomLine.backgroundColor = kcolorLine;
    [self.viewBG addSubview:self.viewBottomLine];
}

- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
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
+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label {

    NSString *height = [NSString stringWithFormat:@"%f",kscaleDeviceHeight(55)];
    return [LSFormCell mapperWithClassName:@"TextFieldUnqualify" cellName:cellName keyName:keyName label:label value:nil andRule:nil andHeight:height];
    
}

//- (CGFloat)cellHeight{
//    return self.editInputView.frame.size.height;
//    
//}

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

//- (UITextView *)textView
//{
//    if ( _textView== nil) {
//        CGRect cellFrame = self.contentView.bounds;
//        cellFrame.origin.y += kPadding;
//        cellFrame.size.height -= kPadding;
//        
//        _textView = [[UITextView alloc] initWithFrame:cellFrame];
//        _textView.delegate = self;
//        
//        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        _textView.backgroundColor = [UIColor clearColor];
//        _textView.font = [UIFont systemFontOfSize:18.0f];
//        
//        _textView.scrollEnabled = NO;
//        _textView.showsVerticalScrollIndicator = NO;
//        _textView.showsHorizontalScrollIndicator = NO;
//        // textView.contentInset = UIEdgeInsetsZero;
//    }
//    return _textView;
//}

- (void)setText:(NSString *)text
{
    _text = text;
    
    // update the UI
    self.textComment.text = text;
}

- (CGFloat)cellHeight
{
    return [self.textComment sizeThatFits:CGSizeMake(self.textComment.frame.size.width, FLT_MAX)].height + 24;
}


#pragma mark - Text View Delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [textView resignFirstResponder]; 
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
//    self.textViewHeight =MIN(40, textView.contentSize.height-3);
    self.textViewHeight =MAX(self.textViewHeight,31 );
    [self updateFrame];
     UITableView *table =[self tableView];
    
    // make sure the cell is at the top
    [self.expandableTableView scrollToRowAtIndexPath:[self.expandableTableView indexPathForCell:self]
                                    atScrollPosition:UITableViewScrollPositionTop
                                            animated:YES];
    [self ShiShiRefreshHeight];
    return YES;
}

- (void)textViewDidChange:(UITextView *)theTextView
{
    self.textViewHeight =MIN(40 , theTextView.contentSize.height- 3);
    [self updateFrame];
    [self ShiShiRefreshHeight];
}

- (void)ShiShiRefreshHeight{
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
        newHeight= (newHeight>self.textViewHeight+24 )?self.textViewHeight+24 :newHeight;
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
@end
