//
//  LSFormImageCollectionCell.m
//  YinfengShop
//
//  Created by lessu on 13-12-25.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSFormImageCollectionCell.h"
#import "BlockUI.h"
#import "UIImageView+WebCache.h"

NSString *LSFormImageCollectionCellRuleFlagKey = @"flags";

@interface LSFormImageCollectionCell ()


@property(nonatomic,retain) UIView *containerView;
@property(nonatomic,retain) NSMutableArray * collectionList;

@property(nonatomic,retain) UIImagePickerController *addImagePicker;
@property(nonatomic,retain) UIImagePickerController *editImagePicker;
@property(nonatomic,assign) int editIndex;
@end


@implementation LSFormImageCollectionCell

- (void)onInitWithLabel:(NSString *)label value:(id)value andRule:(NSDictionary *)rule{
    self.textLabel.text = label;
    _containerView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, 300, 80)];
    [self addSubview:_containerView];
    
    int flag = [rule[LSFormImageCollectionCellRuleFlagKey] integerValue];
    _allowEdit = flag & LSFormImageCollectionCellAllowEdit;
    _allowAdd  = flag & LSFormImageCollectionCellCanAdd;
    _allowSetMainImage= flag& LSFormImageCollectionCellCanSetMainImage;
//    NSAssert(IS_DICTIONARY(rule[LSFormSelectCellRuleMapperKey]), @"mapper 必须是 dictionary");
//    self.selectMapper = rule[LSFormSelectCellRuleMapperKey];
}
- (CGFloat)cellHeight{
    return _containerView.height;
}
- (void)setData:(NSArray *)data{
    _data = data;
    _pictureList = data;
    [_containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _collectionList = [NSMutableArray array];
    if (data == nil) {
        return;
    }
    
    int row ;
    //不再编辑状态下，且数目大于0
    if (!_allowAdd&&_pictureList .count > 0) {
        row =(_pictureList .count - 1)/ IMAGES_PER_LINE + 1;
    }else{
        row = (_pictureList .count )/ IMAGES_PER_LINE + 1;
    }
    _containerView.width  = (IMAGE_SIZE.width+IMAGE_PADDING*2) * IMAGES_PER_LINE;
    _containerView.height = (IMAGE_SIZE.height+IMAGE_PADDING*2) * row + BOTTOM_PADDING;
    
    [_pictureList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        int row = idx / IMAGES_PER_LINE;
        int col = idx % IMAGES_PER_LINE;
        LSFormCellImageCollectionView *collectionView;
        if ([obj isKindOfClass:[UIImage class]]) {
            collectionView = [[LSFormCellImageCollectionView alloc]initAtX:col andY:row withImage:obj];
        }else if([obj isKindOfClass:[NSString class]]){
            collectionView = [[LSFormCellImageCollectionView alloc]initAtX:col andY:row withImageUrl:obj];
        }else{
            NSAssert(false, @"not supported type of data");
        }
        [_containerView addSubview:collectionView];
        [_collectionList addObject:collectionView];
        collectionView.delegate = self;
    }];
    
    if (_allowAdd){
        int row = _pictureList .count / IMAGES_PER_LINE;
        int col = _pictureList .count % IMAGES_PER_LINE;
        LSFormCellImageCollectionAddView *addView = [[LSFormCellImageCollectionAddView alloc]initAtX:col andY:row];
        [_containerView addSubview:addView];
        addView.addDelegate = self;
    }
    self.mainImageData = _mainImageData;
}

- (void)setMainImageData:(id)mainImageData{
    if (mainImageData == NULL) {
        return;
    }
    _mainImageData = mainImageData;
    __block int index;
    [self.pictureList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj == mainImageData) {
            index = idx;
            *stop = true;
        }
    }];

    [_collectionList enumerateObjectsUsingBlock:^(LSFormCellImageCollectionView *collectionView, NSUInteger idx, BOOL *stop) {
        collectionView.isMainImage = false; 
    }];
    
    LSFormCellImageCollectionView *collectionView = _collectionList[index];
    collectionView.isMainImage = true;
}
- (void)collectionView:(LSFormCellImageCollectionView *)collectionView buttonPressed:(UIButton *)sender{
    if (!_allowEdit||!_allowSetMainImage) {
        return ;
    }
    int index = [_collectionList indexOfObject:collectionView];
//    int editButtonIndex     = -1;
    int deleteButtonIndex   = -1;
    int setAsMainButtonIndex= -1;
    int cancleButtonIndex   = -1;
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"操作" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    if (_allowEdit) {
//        editButtonIndex   = [actionSheet addButtonWithTitle:@"修改"];
        deleteButtonIndex =[actionSheet addButtonWithTitle:@"删除"];
    }
    if (_allowSetMainImage) {
        setAsMainButtonIndex = [actionSheet addButtonWithTitle:@"设为封面"];
    }
    cancleButtonIndex = [actionSheet addButtonWithTitle:@"取消"];

    [actionSheet showInView:self.window withCompletionHandler:^(NSInteger buttonIndex) {
        if (buttonIndex == cancleButtonIndex) return ;
//        if (buttonIndex == editButtonIndex) {
//            UIImagePickerController * pickerController = [[UIImagePickerController alloc] init];
//            [pickerController setAllowsEditing:YES];
//            [pickerController setDelegate:self];
//
//            [pickerController setSourceType:UIImagePickerControllerSourceTypeCamera|UIImagePickerControllerSourceTypePhotoLibrary];
//            
//            self.editImagePicker = pickerController;
//            self.editIndex = index;
//            [self.delegate presentModalViewController:pickerController animated:YES];
//        }else 
        if(buttonIndex == deleteButtonIndex){
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                BOOL shouldDelete = false;

                if ([_cellDelegate respondsToSelector:@selector(imageCollectionCell:shouldDeleteAtIndex:)]) {
                    shouldDelete = [_cellDelegate imageCollectionCell:self shouldDeleteAtIndex:index];
                }
                dispatch_sync(dispatch_get_main_queue(), ^{
                    if (shouldDelete) {
                        NSMutableArray *mutableData = [_data mutableCopy];
                        [mutableData removeObjectAtIndex:index];
                        self.data = mutableData;
                        [self.delegate cell:self valuedChanged:_data];
                        [self.delegate cell:self heightChanged:self.cellHeight];
                    }
                });
                
            });
        }else if( buttonIndex == setAsMainButtonIndex){
            dispatch_async(dispatch_get_global_queue(0, 0), ^{

                BOOL shouldSet = false;
                if ([_cellDelegate respondsToSelector:@selector(imageCollectionCell:shouldSetAsMainAtIndex:)]) {
                    shouldSet = [_cellDelegate imageCollectionCell:self shouldSetAsMainAtIndex:index];
                }
                dispatch_sync(dispatch_get_main_queue(), ^{

                    if (shouldSet) {
                        self.mainImageData = self.data[index];
                        [self.delegate cell:self valuedChanged:_data];
                    }
                });

            });

        }
    }];
}

- (void)collectionAddView:(LSFormCellImageCollectionAddView*)addView buttonPressed:(UIButton *)sender{
    if (_allowAdd){
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"新增" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
        [actionSheet showInView:self.window withCompletionHandler:^(NSInteger buttonIndex) {
            //cancel
            if (buttonIndex == 2) return;         
            
            UIImagePickerController * pickerController = [[UIImagePickerController alloc] init];
            [pickerController setAllowsEditing:YES];
            [pickerController setDelegate:self];
            
            switch (buttonIndex) {          //拍照
                case 0:
                    [pickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
                    break;
                case 1:                     //相册
                    [pickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                    break;
                default:
                    break;
            }
            self.addImagePicker = pickerController;
            [self.delegate presentModalViewController:pickerController animated:YES];
        }];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = info[@"UIImagePickerControllerEditedImage"];
    __block id result = nil;
    if (picker == _addImagePicker) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{

            if ([_cellDelegate respondsToSelector:@selector(imageCollectionCell:shouldAddImage:)]) {
                result = [_cellDelegate imageCollectionCell:self shouldAddImage:image];
            }
            dispatch_sync(dispatch_get_main_queue(), ^{

                if (result != nil) {
                    self.data = [_data arrayByAddingObject:result];
                    [self.delegate cell:self valuedChanged:_data];
                    [self.delegate cell:self heightChanged:self.cellHeight];
                }
                self.addImagePicker = nil;
            });
        });
    }else if(picker == _editImagePicker){
        dispatch_async(dispatch_get_global_queue(0, 0), ^{

            if ([_cellDelegate respondsToSelector:@selector(imageCollectionCell:shouldAddImage:)]) {
                result = [_cellDelegate imageCollectionCell:self shouldAddImage:image];
            }
            dispatch_sync(dispatch_get_main_queue(), ^{

                if (result != nil) {
                    NSMutableArray *mutableData = [_data mutableCopy];
                    mutableData[_editIndex] = result;
                    self.data = mutableData;
                    [self.delegate cell:self valuedChanged:_data];
                    [self.delegate cell:self heightChanged:self.cellHeight];
                } 
                self.editImagePicker= nil;
            });
        });

    }

    [picker dismissModalViewControllerAnimated:NO];
}

+ (NSDictionary *)mapperWithCellName:(NSString *)cellName keyName:(NSString *)keyName andFlag:(int)flags{
    return [LSFormCell mapperWithClassName:@"ImageCollection" cellName:cellName keyName:keyName label:nil value:nil 
                                   andRule:@{
                                             LSFormImageCollectionCellRuleFlagKey : @(flags)
                                             }];
}
@end


