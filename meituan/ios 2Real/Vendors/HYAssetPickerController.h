//
//  HYAssetPickerController.h
//  Shanyue
//
//  Created by  on 15/1/5.
//  Copyright (c) 2015年 _Zhizi_. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSNavigationViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

#pragma mark - HYAssetPickerController

@protocol HYAssetPickerControllerDelegate;

@interface HYAssetPickerController :UINavigationController

@property (nonatomic, weak) id <UINavigationControllerDelegate, HYAssetPickerControllerDelegate> delegate;



@property (nonatomic, strong) ALAssetsFilter *assetsFilter;

@property (nonatomic, copy, readonly) NSArray *indexPathsForSelectedItems;

@property (nonatomic, assign) NSInteger maximumNumberOfSelection;
@property (nonatomic, assign) NSInteger minimumNumberOfSelection;

@property (nonatomic, strong) NSPredicate *selectionFilter;

@property (nonatomic, assign) BOOL showCancelButton;

@property (nonatomic, assign) BOOL showEmptyGroups;

@property (nonatomic, assign) BOOL isFinishDismissViewController;



@end

@protocol HYAssetPickerControllerDelegate <NSObject>

@optional

-(void)assetPickerController:(HYAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets;


-(void)assetPickerControllerDidCancel:(HYAssetPickerController *)picker;

-(void)assetPickerController:(HYAssetPickerController *)picker didSelectAsset:(ALAsset*)asset;

-(void)assetPickerController:(HYAssetPickerController *)picker didDeselectAsset:(ALAsset*)asset;

-(void)assetPickerControllerDidMaximum:(HYAssetPickerController *)picker;

-(void)assetPickerControllerDidMinimum:(HYAssetPickerController *)picker;
-(void)getAssetFromPickerController:(NSArray *)assetArray;
@end

#pragma mark - HYAssetViewController

@interface HYAssetViewController : UITableViewController

@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, strong) NSMutableArray *indexPathsForSelectedItems;

@property (nonatomic,assign) NSInteger number;     //新加的，选中的张数
@property (nonatomic,weak) IBOutlet UIButton *preBtn;  
@property (nonatomic,weak) IBOutlet UIButton *confirmBtn;
@property (nonatomic,weak) UIView *bottomView;

-(IBAction)previewSelectPicture:(id)sender;
-(IBAction)confirmSelectPicture:(id)sender;
@end

#pragma mark - HYVideoTitleView

@interface HYVideoTitleView : UILabel

@end

#pragma mark - HYTapAssetView

@protocol HYTapAssetViewDelegate <NSObject>

-(void)touchSelect:(BOOL)select;
-(BOOL)shouldTap;

@end

@interface HYTapAssetView : UIView

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL disabled;
@property (nonatomic, weak) id<HYTapAssetViewDelegate> delegate;

@end

#pragma mark - HYAssetView

@protocol HYAssetViewDelegate <NSObject>

-(BOOL)shouldSelectAsset:(ALAsset*)asset;
-(void)tapSelectHandle:(BOOL)select asset:(ALAsset*)asset;

@end

@interface HYAssetView : UIView

- (void)bind:(ALAsset *)asset selectionFilter:(NSPredicate*)selectionFilter isSeleced:(BOOL)isSeleced;

@end

#pragma mark - HYAssetViewCell

@protocol HYAssetViewCellDelegate;

@interface HYAssetViewCell : UITableViewCell

@property(nonatomic,weak)id<HYAssetViewCellDelegate> delegate;

- (void)bind:(NSArray *)assets selectionFilter:(NSPredicate*)selectionFilter minimumInteritemSpacing:(float)minimumInteritemSpacing minimumLineSpacing:(float)minimumLineSpacing columns:(int)columns assetViewX:(float)assetViewX;

@end

@protocol HYAssetViewCellDelegate <NSObject>

- (BOOL)shouldSelectAsset:(ALAsset*)asset;
- (void)didSelectAsset:(ALAsset*)asset;
- (void)didDeselectAsset:(ALAsset*)asset;

@end

#pragma mark - HYAssetGroupViewCell

@interface HYAssetGroupViewCell : UITableViewCell

- (void)bind:(ALAssetsGroup *)assetsGroup;

@end

#pragma mark - HYAssetGroupViewController

@interface HYAssetGroupViewController : UITableViewController

@end

