//
//  LSFormCellImageCollectionAddView.m
//  YinfengShop
//
//  Created by lessu on 13-12-25.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFormCellImageCollectionAddView.h"

@implementation LSFormCellImageCollectionAddView
- (id)initAtX:(int)x andY:(int)y
{
    self = [super initAtX:x andY:y withImage:nil];
    if (self) {
        [self.imageButton setImage:[UIImage imageNamed:@"lsfc_image_collection_add_n"] forState:UIControlStateNormal];
        [self.imageButton setImage:[UIImage imageNamed:@"lsfc_image_collection_add_p"] forState:UIControlStateHighlighted];
        
    }
    return self;
}
- (void)_init{
    [super _init];
    self.delegate = self;
}

- (void)collectionView:(LSFormCellImageCollectionView *)collectionView buttonPressed:(UIButton *)sender{
    if ([_addDelegate respondsToSelector:@selector(collectionAddView:buttonPressed:)]) {
        [_addDelegate collectionAddView:self buttonPressed:sender];
    }
}

@end
