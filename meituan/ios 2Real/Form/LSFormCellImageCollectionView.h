//
//  LSFormCellImageCollectionView.h
//  YinfengShop
//
//  Created by lessu on 13-12-25.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IMAGE_SIZE CGSizeMake(65,65)
#define IMAGE_PADDING 2
#define IMAGES_PER_LINE 4
#define BOTTOM_PADDING (2* IMAGE_PADDING)
@protocol LSFormCellImageCollectionViewDelegate;
@interface LSFormCellImageCollectionView : UIView
@property(nonatomic,readonly) UIImageView *imageView;
@property(nonatomic,readonly) UIButton    *imageButton;

@property(nonatomic,retain) UIImage  *image;
@property(nonatomic,copy)   NSString *imageUrl;

@property(nonatomic,assign)   BOOL isMainImage;

@property(nonatomic,assign) id<LSFormCellImageCollectionViewDelegate> delegate;

- (void)_init;

- (id)initAtX:(int)x andY:(int)y withImage:(UIImage *)image;
- (id)initAtX:(int)x andY:(int)y withImageUrl:(NSString *)imageUrl;

@end

@protocol LSFormCellImageCollectionViewDelegate <NSObject>

- (void)collectionView:(LSFormCellImageCollectionView *)collectionView buttonPressed:(UIButton *)sender;

@end
