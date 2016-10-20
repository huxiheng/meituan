//
//  UploadImageDetailViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-28.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "UploadImageDetailViewController.h"
#import "BlockUI.h"
@interface UploadImageDetailViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *pageIndicatorLabel;
@property(nonatomic,retain) NSMutableArray *imageViews;
@property(nonatomic,retain) NSMutableArray *imageViewsStatus;
@property(assign, nonatomic) NSInteger currentPage;
@end

@implementation UploadImageDetailViewController

- (void)viewDidLoad {
    IOS7_LAYOUT_FIX;
    [super viewDidLoad];
    _imageViews = [NSMutableArray array];
    self.title = @"图片";
    
    //实例化长按手势监听 
    UILongPressGestureRecognizer *longPress =  [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDidRecognized:)];
    longPress.minimumPressDuration = 1.0;
    //将长按手势添加到需要实现长按操作的视图里
    [self.view addGestureRecognizer:longPress];
    _scrollView.delegate = self;
    _imageViewsStatus = [[NSMutableArray alloc]init];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self dataRequest];        
    });
    [self.view sendSubviewToBack:_scrollView];

}


- (void)dataRequest{
    self.imageCount = 3;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        {
            NSDictionary *params = @{
                                     @"Token"   : [LoginUtil token],
                                     @"TaskID"  : _taskId,
                                     @"ImgIndex":@1
                                    };
            APIConnection *connection = [[CommonAPI sharedInstance]connectionWithApiName:APIMETHOD_STAKE_GetTaskImage params:params];
            [connection setOnSuccess:^(id result) {
                if(IS_DICTIONARY(result[kAPIConnectionStandartDataKey])){
                    _imageViewsStatus[0] = @1;
                    NSString *imgByte = result[kAPIConnectionStandartDataKey][@"ImgByte"];
                    NSData *imageData = [[NSData alloc]initWithBase64EncodedString:imgByte options:NSDataBase64DecodingIgnoreUnknownCharacters];
                    UIImage *image = [UIImage imageWithData:imageData];
                    UIImageView *imageView = LS_CAST(UIImageView *, _imageViews[0]);
                    
                    imageView.contentMode = UIViewContentModeScaleAspectFill;
                    imageView.image = image;

                }else{
                    LS_CAST(UIImageView *, _imageViews[0]).image = [UIImage imageNamed:@"img_no_image"];
                    LS_CAST(UIImageView *, _imageViews[0]).contentMode = UIViewContentModeCenter;
                }
                
                
            }];
            [connection setOnFailed:^(NSError *error) {
                LS_CAST(UIImageView *, _imageViews[0]).image = [UIImage imageNamed:@"img_no_image"];
                LS_CAST(UIImageView *, _imageViews[0]).contentMode = UIViewContentModeCenter;
            }];
            [connection startAsynchronous];
        }
    
        {
            NSDictionary *params = @{
                                     @"Token"   : [LoginUtil token],
                                     @"TaskID"  : _taskId,
                                     @"ImgIndex":@2
                                     };
            APIConnection *connection = [[CommonAPI sharedInstance]connectionWithApiName:APIMETHOD_STAKE_GetTaskImage params:params];
            [connection setOnSuccess:^(id result) {
                if(IS_DICTIONARY(result[kAPIConnectionStandartDataKey])){
                    _imageViewsStatus[1] = @1;
                    NSString *imgByte = result[kAPIConnectionStandartDataKey][@"ImgByte"];
                    NSData *imageData = [[NSData alloc]initWithBase64EncodedString:imgByte options:NSDataBase64DecodingIgnoreUnknownCharacters];
                    UIImage *image = [UIImage imageWithData:imageData];
                    UIImageView *imageView = LS_CAST(UIImageView *, _imageViews[1]);
                    
                    imageView.contentMode = UIViewContentModeScaleAspectFill;
                    imageView.image = image;

                }else{
                    LS_CAST(UIImageView *, _imageViews[1]).image = [UIImage imageNamed:@"img_no_image"];
                    LS_CAST(UIImageView *, _imageViews[1]).contentMode = UIViewContentModeCenter;
                }
                
            }];
            [connection setOnFailed:^(NSError *error) {
                LS_CAST(UIImageView *, _imageViews[1]).image = [UIImage imageNamed:@"img_no_image"];
                LS_CAST(UIImageView *, _imageViews[1]).contentMode = UIViewContentModeCenter;
                
            }];
            [connection startAsynchronous];
        }
        {
            NSDictionary *params = @{
                                     @"Token"   : [LoginUtil token],
                                     @"TaskID"  : _taskId,
                                     @"ImgIndex":@3
                                     };
            APIConnection *connection = [[CommonAPI sharedInstance]connectionWithApiName:APIMETHOD_STAKE_GetTaskImage params:params];
            [connection setOnSuccess:^(id result) {
                if(IS_DICTIONARY(result[kAPIConnectionStandartDataKey])){
                    _imageViewsStatus[2] = @1;
                    NSString *imgByte = result[kAPIConnectionStandartDataKey][@"ImgByte"];
                    NSData *imageData = [[NSData alloc]initWithBase64EncodedString:imgByte options:NSDataBase64DecodingIgnoreUnknownCharacters];
                    UIImage *image = [UIImage imageWithData:imageData];
                    UIImageView *imageView = LS_CAST(UIImageView *, _imageViews[2]);

                    imageView.contentMode = UIViewContentModeScaleAspectFill;                    
                    imageView.image = image;

                }else{
                    LS_CAST(UIImageView *, _imageViews[2]).image = [UIImage imageNamed:@"img_no_image"];
                    LS_CAST(UIImageView *, _imageViews[2]).contentMode = UIViewContentModeCenter;
                }
                
            }];
            [connection setOnFailed:^(NSError *error) {
                LS_CAST(UIImageView *, _imageViews[2]).image = [UIImage imageNamed:@"img_no_image"];
                LS_CAST(UIImageView *, _imageViews[2]).contentMode = UIViewContentModeCenter;
            }];
            [connection startAsynchronous];
        }
        
        
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setImageCount:(NSInteger)imageCount{
    _imageCount = imageCount;
    if (_imageCount >= 0){
        [_imageViews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperview];
        }];
        [_imageViews removeAllObjects];
        [_imageViewsStatus removeAllObjects];
        for(int i = 0 ; i < imageCount ; i ++){
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = [UIImage imageNamed:@"img_downloading_image"];
            imageView.contentMode = UIViewContentModeCenter;
            imageView.frame = CGRectMake(_scrollView.width * i , 0, _scrollView.width, self.view.height);
            imageView.clipsToBounds = true;
            [_scrollView addSubview:imageView];
            [_imageViews addObject:imageView];
            [_imageViewsStatus addObject:@0];
        }
        
        _scrollView .contentSize = CGSizeMake(_scrollView.width * imageCount , _scrollView.height);
        
    }
}


- (void)longPressDidRecognized:(UIGestureRecognizer *)recognizer{
    if(recognizer.state == UIGestureRecognizerStateBegan){
        NSInteger index  = _scrollView.contentOffset.x / _scrollView.width;
        if ([_imageViewsStatus[index] integerValue] == 0) {
            return;
        }
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"操作" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存" otherButtonTitles:nil];
        [sheet showInView:self.view withCompletionHandler:^(NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                UIImageWriteToSavedPhotosAlbum(LS_CAST(UIImageView *,_imageViews[index]).image, self, @selector(didFinishSaveingToAlbumWithImage:error:context:), NULL);
            }
        }];
    }
}

- (void)didFinishSaveingToAlbumWithImage:(UIImage *)image error:(NSError *)error context:(id)context{
    if (error == nil) {
        [LSDialog showMessage:@"保存成功"];
    }else{
        [LSDialog showMessage:[NSString stringWithFormat:@"保存失败:%@",        [error localizedDescription] ]];
    }
    
}
- (NSInteger)currentPage{
    return _scrollView.contentOffset.x / _scrollView.width;
}

- (void)setCurrentPage:(NSInteger)currentPage{
    if (currentPage>=0 && currentPage < _imageCount) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.width * currentPage, 0) animated:YES];
    }
    _pageIndicatorLabel.text = [NSString stringWithFormat:@"%d/%d",currentPage+1,_imageCount];
}

- (IBAction)downloadButtonDidPress:(id)sender {
    NSInteger index  = _scrollView.contentOffset.x / _scrollView.width;
    if ([_imageViewsStatus[index] integerValue] == 0) {
        return;
    }
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"操作" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存" otherButtonTitles:nil];
    [sheet showInView:self.view withCompletionHandler:^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            UIImageWriteToSavedPhotosAlbum(LS_CAST(UIImageView *,_imageViews[index]).image, self, @selector(didFinishSaveingToAlbumWithImage:error:context:), NULL);
        }
    }];
}
- (IBAction)leftButtonDidPress:(id)sender {
    if (self.currentPage == 0) {
        return;
    }
    self.currentPage --;
    
}
- (IBAction)rightButtonDidPress:(id)sender {
    if (self.currentPage == _imageCount - 1) {
        return;
    }
    self.currentPage ++;   
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
        _pageIndicatorLabel.text = [NSString stringWithFormat:@"%d/%d",self.currentPage+1,_imageCount];
}


@end
