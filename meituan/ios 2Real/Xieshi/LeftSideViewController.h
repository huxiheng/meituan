//
//  LeftSideViewController.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/20.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    
    XieshiModuleNameVerify = 0,
    XieshiModuleNameApply,
    
    XieshiModuleNameSample,
    XieshiModuleNameToday,
    XieshiModuleNameUnqualified,
    
    XieshiModuleNameProject,
    XieshiModuleNameRoute,
    XieshiModuleNameUpload,
} XieshiModuleName;
@protocol LeftSideViewControllerDelegate;
@interface LeftSideViewController : UIViewController<UICollectionViewDelegateFlowLayout>{
    NSMutableArray *countArray ;
    UIScrollView *_backgroundScrollView;
    
    
    NSMutableArray *arrayimagesUser;
}
@property (strong, nonatomic)  UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property(nonatomic,assign) id<LeftSideViewControllerDelegate> delegate;
@property(nonatomic,assign) NSString *powerString;
@property (nonatomic, strong)UIImageView *headerViewImageView;


- (void)selectFirst;
@end

@protocol LeftSideViewControllerDelegate <NSObject>

- (void)leftSideViewController:(LeftSideViewController*)controller didSelectedWithName:(XieshiModuleName)name;


@end
