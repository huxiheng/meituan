//
//  LSPickerActionSheet.h
//  Yingfeng
//
//  Created by Lessu on 13-7-25.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSActionSheet.h"

@interface LSPickerActionSheet : LSActionSheet<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSArray* _list;
}

@property(nonatomic,copy) NSArray* list;
@property(nonatomic,copy) BOOL (^onSelected)(int index);
- (id)initWithTitle:(NSString *)title andList:(NSArray *)list;
@end
