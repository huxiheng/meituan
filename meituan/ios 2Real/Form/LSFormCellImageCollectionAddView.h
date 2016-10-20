//
//  LSFormCellImageCollectionAddView.h
//  YinfengShop
//
//  Created by lessu on 13-12-25.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFormCellImageCollectionView.h"
@protocol LSFormCellImageCollectionAddViewDelegate;
@interface LSFormCellImageCollectionAddView : LSFormCellImageCollectionView<LSFormCellImageCollectionViewDelegate>
@property(nonatomic,assign) id<LSFormCellImageCollectionAddViewDelegate> addDelegate;

- (id)initAtX:(int)x andY:(int)y;

@end
@protocol LSFormCellImageCollectionAddViewDelegate <NSObject>

- (void)collectionAddView:(LSFormCellImageCollectionAddView*)addView buttonPressed:(UIButton *)sender;

@end
