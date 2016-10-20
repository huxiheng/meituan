//
//  LSFormCellImageCollectionView.m
//  YinfengShop
//
//  Created by lessu on 13-12-25.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFormCellImageCollectionView.h"
#import "UIImageView+WebCache.h"


@interface LSFormCellImageCollectionView ()
@property(nonatomic,retain) UIImageView *mainIndicatorImageView;
@end

@implementation LSFormCellImageCollectionView


- (id)initAtX:(int)x andY:(int)y withImage:(UIImage *)image{
    self = [super init];
    if (self) {
        [self _init];
        self.left = (IMAGE_SIZE.width    + IMAGE_PADDING*2) * x + IMAGE_PADDING;
        self.top  = (IMAGE_SIZE .height  + IMAGE_PADDING*2) * y + IMAGE_PADDING;
        self.image = image;
    }
    
    return self;
}
- (id)initAtX:(int)x andY:(int)y withImageUrl:(NSString *)imageUrl{
    self = [super init];
    if (self) {
        [self _init];
        self.left = (IMAGE_SIZE.width    + IMAGE_PADDING*2) * x + IMAGE_PADDING;
        self.top  = (IMAGE_SIZE .height  + IMAGE_PADDING*2) * y + IMAGE_PADDING;
        self.imageUrl = imageUrl;
    }
    return self;
}
- (void)_init{
    
    self.width= IMAGE_SIZE .width;
    self.height=IMAGE_SIZE .height;
    
    _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _imageView .layer .cornerRadius = 10;
    _imageView .layer .masksToBounds = YES;
    [self addSubview:_imageView];
    
    _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _imageButton.frame = _imageView.bounds;
    
    [_imageButton addTarget:self action:@selector(imageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_imageButton];
}

- (void)setImage:(UIImage *)image{
    _imageView.image = image;
}

- (void)setImageUrl:(NSString *)imageUrl{
    [_imageView setImageWithURL:[NSURL URLWithString:imageUrl]];
}
- (void)setIsMainImage:(BOOL)isMainImage{
    if (_mainIndicatorImageView == NULL && isMainImage == false) {
        return;
    }
    if (_mainIndicatorImageView == NULL) {
        _mainIndicatorImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lsfc_image_collection_checkBox_p"]];
        _mainIndicatorImageView.left = self.width - _mainIndicatorImageView.width;
        _mainIndicatorImageView.top = self.height - _mainIndicatorImageView.height;
        [self addSubview:_mainIndicatorImageView];
    }
    _mainIndicatorImageView.hidden = !isMainImage;
}
- (void)imageButtonPressed:(id)sender{
    if ([_delegate respondsToSelector:@selector(collectionView:buttonPressed:)]) {
        [_delegate collectionView:self buttonPressed:sender];
    }
}

@end