//
//  LSFormImageCollectionCell.h
//  YinfengShop
//
//  Created by lessu on 13-12-25.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFormCell.h"

#import "LSFormCellImageCollectionView.h"
#import "LSFormCellImageCollectionAddView.h"
#define ImageCollectionCell(__keyName,__flags) [LSFormImageCollectionCell mapperWithCellName:CellNameKeyed(__keyName) keyName:__keyName andFlag:__flags]
typedef enum{
    LSFormImageCollectionCellNone               = 0,
    LSFormImageCollectionCellAllowEdit          = 1,
    LSFormImageCollectionCellCanAdd             = 1 << 1,
    LSFormImageCollectionCellCanSetMainImage    = 1 << 2,
}LSFormImageCollectionCellFlag;
@protocol LSFormImageCollectionCellDelegate;
@interface LSFormImageCollectionCell : LSFormCell<LSFormCellImageCollectionViewDelegate,LSFormCellImageCollectionAddViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,assign) id<LSFormImageCollectionCellDelegate> cellDelegate;
@property(nonatomic,retain) NSArray* pictureList;
//@property(nonatomic,assign) int      mainImageIndex;
@property(nonatomic,assign) id       mainImageData;
@property(nonatomic,assign) BOOL allowEdit;
@property(nonatomic,assign) BOOL allowAdd;
@property(nonatomic,assign) BOOL allowSetMainImage;


+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName andFlag:(int)flags;

@end



@protocol LSFormImageCollectionCellDelegate <NSObject>
//shouldReturn a uiimage that should be added/edited into data;
- (id)imageCollectionCell:(LSFormImageCollectionCell *)cell shouldAddImage:(UIImage *)image;
//- (id)imageCollectionCell:(LSFormImageCollectionCell *)cell shouldEditImage:(UIImage *)image;
- (BOOL)imageCollectionCell:(LSFormImageCollectionCell *)cell shouldDeleteAtIndex:(int)index;
- (BOOL)imageCollectionCell:(LSFormImageCollectionCell *)cell shouldSetAsMainAtIndex:(int)index;

@end
