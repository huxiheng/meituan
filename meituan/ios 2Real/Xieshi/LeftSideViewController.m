//
//  LeftSideViewController.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/20.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LeftSideViewController.h"
#import "AppDelegate.h"
#import "SettingViewController.h"
#import "XSSettingViewController.h"
#import "LogInViewController.h"

#import "LeftVCButton.h"
#import "LeftVCCollectionViewCell.h"
#import "LeftVCCollectionHeaderView.h"

#import "XSActionSheet.h"
#import "XSActionViewSetPhotoView.h"

#import "HYAssetPickerController.h"


#define SIDE_DATA_CHILD(__sidedata)  ((NSArray *)__sidedata[@"child"])
#define SIDE_DATA_INDEX(__sidedata)     [__sidedata[@"index"] integerValue]
#import "LeftViewCell.h"
@interface LeftSideViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,LeftviewcontrollerClickHeadDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (strong,nonatomic) NSMutableArray   * sideDataArray;

//@property(nonatomic,retain) NSArray *ranges;
@property(nonatomic,retain) NSArray *titlesOfSections;

@property (nonatomic,retain)NSArray *imageArray;

@end

@implementation LeftSideViewController

- (void)setSubViews{
    
        UIScrollView *scrollviewBG = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        scrollviewBG.contentSize = CGSizeMake(DeviceWidth, DeviceHeight+0.5);
        scrollviewBG.bounces = YES;
        scrollviewBG.scrollEnabled =YES;
        //    scrollviewBG.delegate = self;
        scrollviewBG.showsVerticalScrollIndicator = NO;
        scrollviewBG.showsHorizontalScrollIndicator = NO;
        scrollviewBG.pagingEnabled =YES;
        scrollviewBG.scrollEnabled = YES;
            [self.view addSubview:scrollviewBG];
    
    UIImageView *imageviewBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    imageviewBG.image = [UIImage imageNamed:@"cebianlanbeijing"];
    [scrollviewBG addSubview:imageviewBG];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight) collectionViewLayout:flowLayout];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    [scrollviewBG addSubview:self.collectionView];
    
    
    [self.collectionView registerClass:[LeftVCCollectionViewCell class] forCellWithReuseIdentifier:[LeftVCCollectionViewCell cellIdentifier]];
    [self.collectionView registerClass:[LeftVCCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[LeftVCCollectionHeaderView viewIdentifier]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString returnImagesUser]]) {
        arrayimagesUser = (NSMutableArray *)[NSArray arrayWithContentsOfFile:[NSString returnImagesUser]];
    }else{
        arrayimagesUser = [NSMutableArray array];
    }
   
    
}

- (void)setDataForLeftVC{
    //4,0,1,2,3,5,6
    self.titlesOfSections = @[
                              //0           1
                              @"记录审核",@"报告批准",
                              //2           3           4
                              @"样品查询",@"统计详情",@"不合格信息查询",
                              //5           6
                              @"工程查询",@"现场图片上传",@"设置",@"退出"
                              ];
    self.imageArray = @[
                        [UIImage imageNamed:@"cebianlanshujushenhe"],[UIImage imageNamed:@"cebianlanbaogaobiaozhun"],
                        [UIImage imageNamed:@"cebianlanyang"],[UIImage imageNamed:@"cebianlanjinritongji"],[UIImage imageNamed:@"cebianlanbuhegexinxi"],
                        [UIImage imageNamed:@"cebianlangongcheng"],[UIImage imageNamed:@"cebianlantupianshangchuan"],[UIImage imageNamed:@"cebianlanxitongshezhi"],[UIImage imageNamed:@"cebianlantuichu"]
                        ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
    [self setDataForLeftVC];
}

#pragma mark ----UICollectionViewDelegate----

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.sideDataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LeftVCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LeftVCCollectionViewCell cellIdentifier ] forIndexPath:indexPath];
    id model = [self.sideDataArray objectAtIndex:indexPath.row];
    [cell reloadDataForCell:model];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((DeviceWidth-kscaleDeviceHeight(83)-kscaleDeviceWidth(42))/3, kscaleIphone6DeviceHeight(105));
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kscaleIphone6DeviceHeight(45),kscaleDeviceHeight(21), kscaleIphone6DeviceHeight(38), kscaleDeviceHeight(21));
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    LeftVCCollectionHeaderView *collectionHeaderVC = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[LeftVCCollectionHeaderView viewIdentifier] forIndexPath:indexPath];
    collectionHeaderVC.delegateClickHead = self;
    [collectionHeaderVC reloadDataForView:[NSString returnImagesUser]];
    
    return collectionHeaderVC;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(collectionView.frame.size.width, kscaleIphone6DeviceLength(265));
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row<countArray.count) {
        NSDictionary *dic = [countArray objectAtIndex:indexPath.row];
        if ([_delegate respondsToSelector:@selector(leftSideViewController:didSelectedWithName:)]) {
            [_delegate leftSideViewController:self didSelectedWithName:[dic[@"child"] integerValue]];
        }
    }
    if (indexPath.row == countArray.count) {
        [self settingButtonDidPress:nil];
    }
    if (indexPath.row == countArray.count+1) {
        [self logoutButtonDidPress:nil];
    }
    
}


#pragma mark ------LeftviewcontrollerClickHeadDelegate---
- (void)leftviewController:(LeftVCCollectionHeaderView *)hesderVC didSelectHead:(UIImageView *)imageheader{
    self.headerViewImageView = imageheader;
    XSActionSheet *actionSheet =[[XSActionSheet alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    XSActionViewSetPhotoView *actionSheetSetPhotoView =[[XSActionViewSetPhotoView alloc] initWithArray:@[@"拍照",@"从相册选择"]];
    actionSheet.setPhotoView =actionSheetSetPhotoView;
    [self.view endEditing:YES];
    actionSheetSetPhotoView.blockSetPhoto=^(NSInteger index, NSString *strTitle){
        if (index ==101) {
            [self openLocalPhotoAlbum];
        }
        if (index ==100) {
            [self takePhoto];
        }
    };

    [actionSheet showInView:self.view];
}

#pragma mark -----选择相片－－－－－
-(void)takePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // NSLog(@"有摄像头");
        if ([DeviceAuthorizationManager DevicePhoto]) {  //判断是否有访问相机的权限
            NSLog(@"pickImageFromCamera");
            //从相机拍摄照片
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.allowsEditing =YES;
            [self presentViewController:imagePicker animated:YES completion:^{
                //        [[MyButton shareInstance] setButtonHidden:YES];
            }];
        }
    }
}

-(void)openLocalPhotoAlbum{
    
    XSImagePickerController *picker1 = [[XSImagePickerController alloc] init];
    picker1.sourceType = UIImagePickerControllerSourceTypePhotoLibrary ;
    picker1.allowsEditing = YES;
    picker1.delegate = self;
    
    [self presentViewController:picker1 animated:YES completion:NULL];
    
//    HYAssetPickerController *picker = [[HYAssetPickerController alloc] init];
//    picker.maximumNumberOfSelection = 9;//最大选择图片的张数
//    picker.assetsFilter = [ALAssetsFilter allPhotos];
////    picker.delegate = self;
//    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject,NSDictionary *bindings){
//        if ([[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyType]isEqual:ALAssetTypeVideo]) {
//            NSTimeInterval duration = [[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyDuration]doubleValue];
//            return duration >= 5;
//        }else{
//            return  YES;
//        }
//    }];
//    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark UIImagePickerViewController Delegate
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.headerViewImageView.image = image;
    NSData *imageData = UIImagePNGRepresentation(image);
    [self saveImageWithUser:imageData];
   
//    NSArray *arrayPhoto =@[image];
//    XSSaveLocalManager *saveLocalManage = [[XSSaveLocalManager alloc] init];
//    [saveLocalManage requestWithArrays:arrayPhoto finished:^(NSDictionary *dic) {
//        NSLog(@"%@",dic);
//        _saveFinalPath = dic[@"filename"];
//        
//    } failed:^{
//        
//    }];
    //关闭相册界面
    [picker dismissModalViewControllerAnimated:YES];

}

#pragma mark ------保存图片到本地---------
-(void)saveImageWithUser:(NSData*)dataImage{
    NSString *plistPath = [NSString returnImagesUser];
    NSLog(@"%@",plistPath);

    for (int i=0; i<arrayimagesUser.count; i++) {
        NSDictionary *dicChild = [arrayimagesUser objectAtIndex:i];
        NSString* dicUserName = dicChild[@"userName"];
        if ([dicUserName isEqualToString:[LoginUtil loginUserName]]) {
            NSDictionary *dicUser = @{@"imagedata":dataImage,@"userName":[LoginUtil loginUserName]};
            [arrayimagesUser replaceObjectAtIndex:i withObject:dicUser];
            [arrayimagesUser writeToFile:plistPath atomically:YES];
            return;
        }
    }
    
    NSDictionary *dicUser = @{@"imagedata":dataImage,@"userName":[LoginUtil loginUserName]};
    [arrayimagesUser addObject:dicUser];
    [arrayimagesUser writeToFile:plistPath atomically:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



//判断点击的按钮
- (void)sideButtonsDidPress:(UIButton *)sender{
    
    sender.selected = true;
    
}

- (void)indexPathOfLocation:(NSInteger)location{
    if (location < 0) {
        return ;
    }
    
    NSString *strMap = [NSString stringWithFormat:@"%d",location];
    NSDictionary *dic = @{@"child":strMap};
    [countArray addObject:dic];
    
    
}

- (void)setPowerString:(NSString *)powerString{
    //10001101
    _powerString = powerString;
    
    NSArray* mapper = @[@(4),@(0),@(1),@(2),@(3),@(5),@(6),@(-1)];
    
    countArray = [NSMutableArray array];
    
    for (NSUInteger i = 0 ; i < powerString.length; i++) {
        unichar power =  [powerString characterAtIndex:i];
        if (power == '1') {
            [self indexPathOfLocation:[mapper[i] integerValue]];
        }
    }
    
    self.sideDataArray = [NSMutableArray array];
    for (int j = 0; j<countArray.count + 2; j++) {
        XSCollectionCellModel *cellModel = [[XSCollectionCellModel alloc] init];
        
        if (j<countArray.count) {
            NSDictionary *dic = [countArray objectAtIndex:j];
            cellModel.imageForCell = [self.imageArray objectAtIndex:[dic[@"child"] integerValue]];
            cellModel.strName = [self.titlesOfSections objectAtIndex:[dic[@"child"] integerValue]];
            [self.sideDataArray addObject:cellModel];
        }else if (j == countArray.count){
            cellModel.imageForCell = [self.imageArray objectAtIndex:7];
            cellModel.strName = [self.titlesOfSections objectAtIndex:7];
            [self.sideDataArray addObject:cellModel];
        }else if(j==countArray.count+1){
            cellModel.imageForCell = [self.imageArray lastObject];
            cellModel.strName = [self.titlesOfSections lastObject];
            [self.sideDataArray addObject:cellModel];
        }
        
        
    }
    [self.collectionView reloadData];
    
}

- (void)selectFirst{
    
    //    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    //    [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
}


- (NSInteger)linearyNumberOfIndexPath:(NSIndexPath *)indexPath{
    NSUInteger titleSection = SIDE_DATA_INDEX( _sideDataArray[indexPath.section] );
    NSUInteger titleRow     = [SIDE_DATA_CHILD( _sideDataArray[indexPath.section] )[indexPath.row] integerValue];
    NSInteger ret = 0;
    for (int i = 0 ; i< titleSection; i++) {
        ret += ARRAY_CAST( self.titlesOfSections[i] ).count;
    }
    ret += titleRow;
    return ret;
}


- (void)logoutButtonDidPress:(id)sender {
    //    APP_DELEGATE.window.rootViewController = APP_DELEGATE.rootNavigationController;
    LogInViewController *loginViewController= [[LogInViewController alloc]init];
    
    APP_DELEGATE.rootNavigationController = [[XSNavigationViewController alloc] initWithRootViewController:loginViewController];
    APP_DELEGATE.window.rootViewController = APP_DELEGATE.rootNavigationController;
}
- (void)settingButtonDidPress:(id)sender {
    
    XSSettingViewController *controller = [[XSSettingViewController alloc]init];
    XSNavigationViewController *navigationController = [[XSNavigationViewController alloc]initWithRootViewController:controller];
    [APP_DELEGATE.rootMainViewController presentViewController:navigationController animated:YES completion:0];
    //    [APP_DELEGATE.rootMainViewController presentViewController:wrapNavigationController(controller) animated:YES completion:0];
}

@end
