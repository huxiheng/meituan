//
//  MJDIYAutoFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJDIYAutoFooter.h"

@interface MJDIYAutoFooter()
@end

@implementation MJDIYAutoFooter
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    // 设置控件的高度
    self.mj_h = 40.0;
    self.labelStatusMessage =[[UILabel alloc] init];
    self.labelStatusMessage.textColor =[UIColor colorWithHexString:kc00_999999];
    self.labelStatusMessage.textAlignment =NSTextAlignmentCenter;
    self.labelStatusMessage.font =[UIFont systemFontOfSize:12.0];
    [self addSubview:self.labelStatusMessage];

    self.imageLoading =[[UIImageView alloc] initWithFrame:CGRectMake(56.0, (self.mj_h -14)/2, 14, 14)];
    self.imageLoading.image =[UIImage imageNamed:@"refreshingGreen"];
    [self addSubview:self.imageLoading];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    self.backgroundColor =[UIColor clearColor];;
    self.labelStatusMessage.frame =self.bounds;
    self.imageLoading.frame =CGRectMake(self.bounds.size.width/2-40, (self.mj_h-14)/2, 14, 14);
}
#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}
#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
}
#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self endLoading];
            self.labelStatusMessage.text = @"上拉加载更多";
            self.imageLoading.hidden =YES;
            break;
        case MJRefreshStateRefreshing:
            self.imageLoading.hidden =NO;
            self.labelStatusMessage.text = @"      加载中...";
            [self startLoading];
            break;
        case MJRefreshStateNoMoreData:
            [self endLoading];
            self.labelStatusMessage.text = @"无更多内容";
            self.imageLoading.hidden =YES;
            break;
        default:
            break;
    }
}
//用于延迟加载
-(void)startLoading
{
    if (self.imageLoading && !self.imageLoading.hidden) {
        CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat:((360.0f * M_PI) / 180.0f)];
        rotationAnimation.duration = 2.0;
        rotationAnimation.repeatCount = 999999;
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [self.imageLoading.layer addAnimation:rotationAnimation forKey:@"revItUpAnimation"];
    }
}
-(void)endLoading
{
    [self.imageLoading.layer removeAnimationForKey:@"revItUpAnimation"];
    self.imageLoading.hidden = YES;
}
@end
