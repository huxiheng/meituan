//
//  LSRefreashableViewController.h
//  Yingfeng
//
//  Created by lessu on 13-12-31.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface LSRefreashableViewController : XSViewSecondController<UIScrollViewDelegate,EGORefreshTableHeaderDelegate>
{
@protected
    BOOL                                _isRefreashing;
}
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
/**
 * 设置最少的网络访问时间
 */
@property(nonatomic,assign) NSTimeInterval loadingDelay;
//impl method
- (void)lsRefreashableViewControllerWillRefreash;

- (void)finishRefreash;
@end
