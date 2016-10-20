//
//  MJDIYHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJDIYHeader.h"

@interface MJDIYHeader()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UISwitch *s;
@property (weak, nonatomic) UIImageView *logo;
@property (weak, nonatomic) UIActivityIndicatorView *loading;



@end

@implementation MJDIYHeader
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    self.labelStatusMessage =[[UILabel alloc] init];
    self.labelStatusMessage.textColor =[UIColor whiteColor];
    self.labelStatusMessage.textAlignment =NSTextAlignmentCenter;
    self.labelStatusMessage.font =[UIFont systemFontOfSize:12.0];
    [self addSubview:self.labelStatusMessage];
    
    UIImage *imageArrow =[UIImage imageNamed:MJRefreshSrcName(@"arrow")];
    self.imageRefreshArrow =[[UIImageView alloc] initWithFrame:CGRectMake(55.0, (self.mj_h -imageArrow.size.height)/2, imageArrow.size.width, imageArrow.size.height)];
    self.imageRefreshArrow.image =imageArrow;
    [self addSubview:self.imageRefreshArrow];
    
    self.imageLoading =[[UIImageView alloc] initWithFrame:CGRectMake(56.0, (self.mj_h -14)/2, 14, 14)];
    self.imageLoading.image =[UIImage imageNamed:@"refreshing"];
    [self addSubview:self.imageLoading];
    
    self.imageBJ =[[UIImageView alloc] init];
    self.imageBJ.backgroundColor =[UIColor colorWithHexString:@"#2c2c2c"];
    [self addSubview:self.imageBJ];
    

    
    self.imageRefreshSuccess =[[UIImageView alloc] init];
    self.imageRefreshSuccess.image =[UIImage imageNamed:@"refreshSuccess"];
    [self addSubview:self.imageRefreshSuccess];
//    // 添加label
//    UILabel *label = [[UILabel alloc] init];
//    label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
//    label.font = [UIFont boldSystemFontOfSize:16];
//    label.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:label];
//    self.label = label;
//    
//    // 打酱油的开关
//    UISwitch *s = [[UISwitch alloc] init];
//    [self addSubview:s];
//    self.s = s;
//    
//    // logo
//    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
//    [self addSubview:logo];
//    self.logo = logo;
//    
//    // loading
//    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [self addSubview:loading];
//    self.loading = loading;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];

    self.labelStatusMessage.frame =self.bounds;
    self.imageBJ.frame =CGRectMake(0, -500, self.bounds.size.width, 500);
    self.imageRefreshArrow.frame =CGRectMake(55.0, (self.mj_h -self.imageRefreshArrow.image.size.height)/2, self.imageRefreshArrow.image.size.width, self.imageRefreshArrow.image.size.height);
    self.imageRefreshSuccess.frame =CGRectMake(120 +self.bounds.size.width-DeviceWidth , 18, 14, 14);
    self.imageLoading.frame =CGRectMake(56, 18, 14, 14);
//    self.label.frame = self.bounds;
//    
//    self.logo.center = CGPointMake(self.mj_w * 0.5, - self.logo.mj_h + 20);
//    
//    self.loading.center = CGPointMake(self.mj_w - 30, self.mj_h * 0.5);
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
           if (oldState == MJRefreshStateRefreshing) {
               self.imageRefreshArrow.hidden =YES;
               self.imageLoading.hidden =YES;
               self.imageRefreshSuccess.hidden =NO;
               self.labelStatusMessage.text =@"       刷新成功";
               [self endLoading];
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   self.imageRefreshArrow.hidden =NO;
                   self.imageLoading.hidden =YES;
                   self.imageRefreshSuccess.hidden =YES;
                   self.labelStatusMessage.text =@"下拉刷新";
                   self.imageRefreshArrow.transform =CGAffineTransformIdentity;

               });

           }
            else {
            self.imageRefreshArrow.hidden =NO;
            self.imageLoading.hidden =YES;
            self.imageRefreshSuccess.hidden =YES;
            self.labelStatusMessage.text =@"下拉刷新";
            [self endLoading];
            [self updateimageRefreshArrow:state];
            }
            break;
        case MJRefreshStatePulling:
            self.imageRefreshArrow.hidden =NO;
            self.imageLoading.hidden =YES;
            self.imageRefreshSuccess.hidden =YES;
            self.labelStatusMessage.text =@"释放立即刷新";
            [self updateimageRefreshArrow:state];
//            [self.loading stopAnimating];
//            [self.s setOn:YES animated:YES];
//            self.label.text = @"赶紧放开我吧(开关是打酱油滴)";
            break;
        case MJRefreshStateRefreshing:
//            [self.s setOn:YES animated:YES];
//            self.label.text = @"加载数据中(开关是打酱油滴)";
//            [self.loading startAnimating];
            self.imageRefreshArrow.hidden =YES;
            self.imageLoading.hidden =NO;
            self.imageRefreshSuccess.hidden =YES;
            [self startLoading];
            self.labelStatusMessage.text =@"正在刷新...";
            [self updateimageRefreshArrow:state];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    CGFloat red = 1.0 - pullingPercent * 0.5;
    CGFloat green = 0.5 - 0.5 * pullingPercent;
    CGFloat blue = 0.5 * pullingPercent;
    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
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
-(void)updateimageRefreshArrow:(MJRefreshState)state {
//    MJRefreshCheckState;
    if (state ==MJRefreshStatePulling) {
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            self.imageRefreshArrow.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    }
    if (state ==MJRefreshStateRefreshing) {
        [self startLoading];
    }
    if (state ==MJRefreshStateIdle) {
//        if (oldState == MJRefreshStateRefreshing) {
//            self.imageRefreshArrow.hidden =NO;
//            self.imageLoading.hidden =YES;
//            self.imageRefreshSuccess.hidden =YES;
//            self.labelStatusMessage.text =@"下啦刷新";
//            [self endLoading];
//            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
//                self.imageRefreshArrow.transform = CGAffineTransformIdentity;
//            }];
//
//        }
//        else {
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.imageRefreshArrow.transform = CGAffineTransformIdentity;
            }];
//        }
    }
   
}
//#pragma mark 监听控件的刷新状态
//- (void)setState:(MJRefreshState)state
//{
//    MJRefreshCheckState;
//    
//    switch (state) {
//        case MJRefreshStateIdle:
//            if (oldState == MJRefreshStateRefreshing) {
//                self.imageRefreshArrow.transform =CGAffineTransformIdentity;
//                self.imageRefreshArrow.hidden =NO;
//                self.imageLoading.hidden =YES;
//                self.imageRefreshSuccess.hidden =YES;
//                self.labelStatusMessage.text =@"下啦刷新";
//            } else {
//                self.imageRefreshArrow.transform =CGAffineTransformIdentity;
//                self.imageRefreshArrow.hidden =NO;
//                self.imageLoading.hidden =YES;
//                self.imageRefreshSuccess.hidden =YES;
//                self.labelStatusMessage.text =@"下啦刷新";
//                
//            }
//            
//            break;
//        case MJRefreshStatePulling:
//            self.imageRefreshArrow.hidden =NO;
//            self.imageLoading.hidden =YES;
//            self.imageRefreshSuccess.hidden =YES;
//            self.labelStatusMessage.text =@"下啦刷新";
//            [self updateimageRefreshArrow:state];
//            //            [self.loading stopAnimating];
//            //            [self.s setOn:YES animated:YES];
//            //            self.label.text = @"赶紧放开我吧(开关是打酱油滴)";
//            break;
//        case MJRefreshStateRefreshing:
//            //            [self.s setOn:YES animated:YES];
//            //            self.label.text = @"加载数据中(开关是打酱油滴)";
//            //            [self.loading startAnimating];
//            self.imageRefreshArrow.hidden =YES;
//            self.imageLoading.hidden =NO;
//            self.imageRefreshSuccess.hidden =YES;
//            [self startLoading];
//            self.labelStatusMessage.text =@"加载数据中";
//            break;
//        default:
//            break;
//    }
//}
//
//#pragma mark 监听拖拽比例（控件被拖出来的比例）
//- (void)setPullingPercent:(CGFloat)pullingPercent
//{
//    [super setPullingPercent:pullingPercent];
//    
//    // 1.0 0.5 0.0
//    // 0.5 0.0 0.5
//    CGFloat red = 1.0 - pullingPercent * 0.5;
//    CGFloat green = 0.5 - 0.5 * pullingPercent;
//    CGFloat blue = 0.5 * pullingPercent;
//    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//}
////用于延迟加载
//-(void)startLoading
//{
//    if (self.imageLoading && !self.imageLoading.hidden) {
//        CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//        rotationAnimation.toValue = [NSNumber numberWithFloat:((360.0f * M_PI) / 180.0f)];
//        rotationAnimation.duration = 2.0;
//        rotationAnimation.repeatCount = 999999;
//        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//        [self.imageLoading.layer addAnimation:rotationAnimation forKey:@"revItUpAnimation"];
//    }
//}
//-(void)endLoading
//{
//    [self.imageLoading.layer removeAnimationForKey:@"revItUpAnimation"];
//    self.imageLoading.hidden = YES;
//}
//-(void)updateimageRefreshArrow:(MJRefreshState)state {
//    if (state ==MJRefreshStatePulling) {
//        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
//            self.imageRefreshArrow.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
//        }];
//    }
//    
//}
@end
