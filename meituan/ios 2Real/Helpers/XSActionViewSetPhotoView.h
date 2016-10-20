//
//  XSActionViewSetPhotoView.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/20.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^viewDidClickedBlock)(NSInteger index, NSString *strTitle);
@interface XSActionViewSetPhotoView : UIView
@property (strong, nonatomic)NSArray *arrayTitles;
@property (strong, nonatomic)viewDidClickedBlock blockSetPhoto;
- (instancetype)initWithArray:(NSArray *)arrayTitles;

@end
