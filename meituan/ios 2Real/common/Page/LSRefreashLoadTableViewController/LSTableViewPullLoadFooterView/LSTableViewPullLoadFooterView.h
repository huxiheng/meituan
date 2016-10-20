//
//  LSTableViewPullLoadFooterView.h
//  SeeCollection
//
//  Created by Lessu on 13-3-3.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//
// v1.1
// 新增加载中时的 insets

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
typedef enum{
	LSPullRefreshPulling = 0,
	LSPullRefreshNormal,
	LSPullRefreshLoading,
    LSPullRefreshNoMore
} LSPullRefreshState;
@protocol LSRefreshTableFooterDelegate;

@interface LSTableViewPullLoadFooterView : UIView
{
    id _delegate;
    LSPullRefreshState _state;

    UILabel *_statusLabel;
//    CALayer *_arrowImage;
    UIActivityIndicatorView *_activityView;
    
    float               _contentOffsetY;
}
@property(nonatomic,assign) id <LSRefreshTableFooterDelegate> delegate;
@property(nonatomic,assign) float                       contentOffsetY;
@property(nonatomic,retain) UIColor                     *textColor;
@property(nonatomic,assign) BOOL                        hasMore;
@property(nonatomic,retain) UIScrollView                *scrollView;
- (void)lsLoadScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)lsLoadScrollViewDidEndDragging:(UIScrollView *)scrollView;

- (void)lsLoadScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;
@end


@protocol LSRefreshTableFooterDelegate
- (void)lsLoadTableFooterDidTriggerLoad:(LSTableViewPullLoadFooterView*)view;
- (BOOL)lsLoadTableFooterDataSourceIsLoading:(LSTableViewPullLoadFooterView*)view;
@end
